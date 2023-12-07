import 'package:crossworduel/game/core/game/bloc/game_bloc.dart';
import 'package:crossworduel/game/core/instruction/parent_instruction.dart';

class CrosswordTapGameEvent extends LocalGameEvent {
  final String status = 'CROSSWORD_TAP';
  final int index;

  const CrosswordTapGameEvent({
    required this.index,
  });

  @override
  List<Object> get props => [index];

  @override
  InstructionData get generateInstruction =>
      CrosswordTapInsD(index: index, objectMap: {});

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

  const KeyboardTapGameEvent({
    required this.letter,
  });

  @override
  List<Object> get props => [letter];

  @override
  InstructionData get generateInstruction =>
      KeyboardTapInsD(letter: letter, objectMap: {});

  @override
  Map get generateServerMap => {};

  @override
  int get getDuration => 0;

  @override
  String get getId => status;
}
