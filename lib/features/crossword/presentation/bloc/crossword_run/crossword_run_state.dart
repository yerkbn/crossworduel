part of 'crossword_run_cubit.dart';

class CrosswordRunState extends Equatable {
  final CrosswordEntity crosswordEntity;
  const CrosswordRunState({required this.crosswordEntity});

  @override
  List<Object> get props => [crosswordEntity];
}
