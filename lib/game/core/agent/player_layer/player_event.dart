import 'package:crossworduel/game/core/game/bloc/game_bloc.dart';
import 'package:crossworduel/game/core/instruction/parent_instruction.dart';

class LetterTapGameEvent extends LocalGameEvent {
  final String status = 'LETTER_TAP';
  final int index;

  const LetterTapGameEvent({
    required this.index,
  });

  @override
  List<Object> get props => [index];

  @override
  InstructionData get generateInstruction =>
      LetterTapInsD(index: index, objectMap: {});

  @override
  Map get generateServerMap => {};

  @override
  int get getDuration => 0;

  @override
  String get getId => status;
}
