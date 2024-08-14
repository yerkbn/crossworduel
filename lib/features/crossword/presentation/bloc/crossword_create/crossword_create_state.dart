part of 'crossword_create_cubit.dart';

class CrosswordCreateState extends Equatable {
  final CrosswordEntity crosswordEntity;
  const CrosswordCreateState({required this.crosswordEntity});

  @override
  List<Object> get props => [crosswordEntity];
}
