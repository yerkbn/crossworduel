import 'package:crossworduel/game/domain/entities/crossword_entity.dart';
import 'package:crossworduel/game/game-core/crossword/entity/point_entity.dart';
import 'package:crossworduel/game/game-core/game/bloc/game_bloc.dart';
import 'package:crossworduel/game/game-core/instruction/parent_instruction.dart';

class CrosswordTapGameEvent extends LocalGameEvent {
  final String status = 'CROSSWORD_TAP';
  final PointEntity point;

  const CrosswordTapGameEvent({
    required this.point,
  }) : super(isLocal: true);

  @override
  List<Object> get props => [point];

  @override
  InstructionData get generateInstruction =>
      CrosswordTapInsD(point: point, objectMap: {});

  @override
  Map get generateServerMap => {};

  @override
  int get getDuration => 0;

  @override
  String get getId => status;
}

class KeyboardTapGameEvent extends LocalGameEvent {
  final String status = 'KEYBOARD_TAP';
  final String letter;
  final CrosswordEntity crossword;

  const KeyboardTapGameEvent({
    required this.letter,
    required this.crossword,
  });

  @override
  List<Object> get props => [letter];

  @override
  InstructionData get generateInstruction =>
      KeyboardTapInsD(letter: letter, objectMap: {});

  @override
  Map get generateServerMap {
    final CrosswordEntity edited = crossword.setLetter(letter);
    return {
      'status': status,
      "data": {"correctCnt": edited.getCorrectSpnCnt}
    };
  }

  @override
  int get getDuration => 0;

  @override
  String get getId => status;
}

class DeleteTapGameEvent extends LocalGameEvent {
  final String status = 'DELETE_TAP';

  const DeleteTapGameEvent() : super(isLocal: true);

  @override
  List<Object> get props => [];

  @override
  InstructionData get generateInstruction => DeleteTapInsD(objectMap: {});

  @override
  Map get generateServerMap => {};

  @override
  int get getDuration => 0;

  @override
  String get getId => status;
}

class NextPrevGameEvent extends LocalGameEvent {
  final String status = 'NEXT_PREV_TAP';
  final bool isNext;

  const NextPrevGameEvent({
    required this.isNext,
  }) : super(isLocal: true);

  @override
  List<Object> get props => [];

  @override
  InstructionData get generateInstruction =>
      NextPrevInsD(objectMap: {isNext: isNext}, isNext: isNext);

  @override
  Map get generateServerMap => {};

  @override
  int get getDuration => 0;

  @override
  String get getId => status;
}

// class AllDoneGameEvent extends LocalGameEvent {
//   final String status = 'ALL_DONE';

//   const AllDoneGameEvent() : super(isLocal: true);

//   @override
//   List<Object> get props => [];

//   @override
//   InstructionData get generateInstruction => FinalInsD(
//       objectMap: {},
//       finalEntity: const FinalEntity(
//           winnerId: "1",
//           delta: 3,
//           score: ScoreEntity(heart: 1, strike: 1, point: 2)));

//   @override
//   Map get generateServerMap => {};

//   @override
//   int get getDuration => 0;

//   @override
//   String get getId => status;
// }
