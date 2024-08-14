import 'package:equatable/equatable.dart';

class AnswerClueEntity extends Equatable {
  final String answer;
  final String clue;

  AnswerClueEntity({required this.answer, required this.clue});

  factory AnswerClueEntity.init({String? answer}) {
    return AnswerClueEntity(answer: answer ?? "", clue: "");
  }

  AnswerClueEntity copyWith({String? answer, String? clue}) {
    return AnswerClueEntity(
      answer: answer ?? this.answer,
      clue: clue ?? this.clue,
    );
  }

  @override
  List<Object?> get props => [answer, clue];
}
