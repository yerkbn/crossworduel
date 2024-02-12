import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crossworduel/config/network/network_config.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:crossworduel/game/game-core/agent/agent.dart';
import 'package:crossworduel/game/game-core/instruction/parent_instruction.dart';
import 'package:crossworduel/game/game-core/mock/mock.dart';
import 'package:crossworduel/game/game-core/shedule/limitter_shedule.dart';
import 'package:crossworduel/game/game-core/shedule/queue_shedule.dart';
import 'package:crossworduel/game/game-core/shedule/shedule.dart';
import 'package:crossworduel/game/domain/entities/player_entity.dart';
import 'package:crossworduel/game/domain/entities/room_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

/// Test for executing will be passed from
/// specific game too
typedef GameMockCreator = MockParent Function(MockConfig connfig);

class GameBloc extends Bloc<GameEvent, GameState> with Normalizer {
  final AuthBloc authBloc;
  // for testing purposes
  final bool _isTesting;
  // All game logic run inside a agent
  final ParentAgent _gameAgent;
  // Instructions comming from server will be mapped by this mapper
  final InstructionMapper _instrtructionMapper;
  final MeEntity _currentUser;

  // Limiting user input, and flooting server
  final SimpleSheduleManager<LimiterShedule> _limitterManager =
      SimpleSheduleManager<LimiterShedule>(
          (String id) => LimiterShedule(id: id, defaultDuration: 100));

  // Limiting server message
  final QueueShedule _queueShedule =
      QueueShedule(id: 'INSTRUCTIONS_FROM_BACKEND', defaultDuration: 10);

  // socket stuff
  late WebSocket _channel;
  late StreamSubscription _serverSubscription;
  late String _roomId;
  late MockParent _mock;

  GameBloc({
    required this.authBloc,
    required ParentAgent gameAgent,
    required RoomEntity routeParameter,
    required MeEntity currentUser,
    required GameMockCreator gameMockCreator,
    required bool isTesting,
  })  : _gameAgent = gameAgent,
        _currentUser = currentUser,
        _isTesting = isTesting,
        _instrtructionMapper =
            InstructionMapper(additionalInstructions: gameAgent.instructions),
        super(LoadingGameState(me: gameAgent.currentPlayer)) {
    on(mapEventToState);
    _initConnect(routeParameter, gameMockCreator);
  }

  void _initConnect(RoomEntity parameter, GameMockCreator gameMockCreator) {
    if (_isTesting) {
      _mock =
          gameMockCreator(MockConfig(me: _currentUser, onMessage: _onMessage));
      _mock.runTest();
    } else {
      if (parameter.roomId != null) {
        _roomId = parameter.roomId!;
        _socketRoomConnect();
      } else {
        _roomCreate(parameter.createRoom!);
      }
    }
  }

  Future<void> mapEventToState(GameEvent event, Emitter<GameState> emit) async {
    if (event is ReconnectGameEvent) {
      await _reconnect();
    }
    if (event is LoadingGameEvent) {
      emit(LoadingGameState(
          me: event.me ?? _gameAgent.currentPlayer, opponent: event.opponent));
    }
    if (event is FailureGameEvent) {
      emit(FailureGameState(error: event.error));
    }

    if (event is RunGameEvent) {
      emit(RunningGameState(gameAgent: _gameAgent));
      await Future.delayed(const Duration(milliseconds: 70));
      _gameAgent.instructionToAction(event.instruction);
      emit(RunningGameState(gameAgent: _gameAgent));
    }

    /// SERVER ERRORS OR USER ERRORS
    if (event is AFKGameEvent) {
      emit(AFKGameState());
    }

    /// EVENTS COMMING FROM FRONT
    if (event is LocalGameEvent) {
      _limitterManager.push(
          id: event.getId,
          item: SheduleItem(() {
            _gameAgent.instructionToAction(event.generateInstruction);
            if (!event.isLocal) {
              _sendToServer(event.generateServerMessage);
            }
          }, event.getDuration));
      emit(RunningGameState(gameAgent: _gameAgent));
    }
  }

  /// ------------------------------------------
  /// SERVER SOCKET STAFF
  /// ------------------------------------------

  Future<void> _reconnect() async {
    _queueShedule.clear();
    _socketRoomConnect(extraPrefix: '&is_reconnect=true');
  }

  /// When roomId is given and we just
  /// connect to given url that is it
  void _socketRoomConnect({String extraPrefix = ''}) =>
      _socketConnect(_generateSocketProtocol(roomId: _roomId));

  /// When user create room for own self
  Future<void> _roomCreate(RoomCreateEntity createRoom) async {
    add(const LoadingGameEvent());
    try {
      _socketConnect(_generateSocketProtocol(
          subjectId: createRoom.subjectId, guestId: createRoom.playerId));
    } catch (err) {
      add(FailureGameEvent(error: err.toString()));
    }
  }

  /// This will connect to servers
  Future<void> _socketConnect(String socketProtocol) async {
    final String url = '${globalSL<NetworkConfig>().globalBattleSocket}/room';
    _channel = await WebSocket.connect(url);
    _serverSubscription = _channel.listen(_onMessage, onError: _onError);
    _sendToServer(socketProtocol);
  }

  String _generateSocketProtocol(
      {String? roomId, String? subjectId, String? guestId}) {
    final Map protocol = {
      "token": _currentUser.getToken,
      "deviceType": "m",
    };
    if (roomId != null) protocol['roomId'] = roomId;
    if (subjectId != null) protocol['subjectId'] = subjectId;
    if (guestId != null) protocol['guestId'] = guestId;
    return LocalGameEvent.generateServerMessageFromMap(protocol);
  }

  Future<void> _onMessage(message) async {
    final String stringMessage = message.toString();
    printWrapped(stringMessage);
    final InstructionData instruction =
        _instrtructionMapper.parse(stringMessage);
    // We clear all UI staff if it is Reconnecting case
    _clearViewInReconnecting(instruction);

    if (instruction is AFKInsD) {
      add(AFKGameEvent());
    }
    _queueShedule.push(SheduleItem(() {
      add(RunGameEvent(instruction: instruction));
    }, instruction.duration));
  }

  void _sendToServer(String answer) {
    if (_isTesting) {
      _mock.add(answer);
    } else {
      _channel.add(answer);
    }
  }

  Future<void> _onError(message) async {
    // _serverSubscription.cancel();
    _shutDownConnection();
    add(FailureGameEvent(error: message.toString()));
    await Future.delayed(const Duration(milliseconds: 500));
    _socketRoomConnect(extraPrefix: '&is_reconnect=true');
  }

  Future<void> _shutDownConnection() async {
    await _serverSubscription.cancel();
    await _channel.close();
  }

  @override
  Future<void> close() {
    if (!_isTesting && _channel.readyState == WebSocket.open) {
      // sending to backend that player leave
      final PlayerLeaveGameEvent event =
          PlayerLeaveGameEvent(playerId: _currentUser.id);
      _channel.add(event.generateServerMessage);
      // closing channel
      _shutDownConnection();
    }
    _mock.close();
    return super.close();
  }

  /// If comming instruction is reconnecting cases we fully clear our
  /// page in order to cuccessfully commit reconnecting
  void _clearViewInReconnecting(InstructionData data) {
    if (data is ReconnectingInsD) {
      // _queueShedule.clear();
      // FinishInsD finishInsD = FinishInsD.parseMap({'deepClear': true});
      // _queueShedule.push(SheduleItem(() {
      //   add(RunGameEvent(instruction: finishInsD));
      // }, finishInsD.deepClear));
    }
  }
}
