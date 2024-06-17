part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {
  MainSwitchData get getCategory;
}

class ActiveCategoryState extends CategoryState {
  final MainSwitchData category;

  ActiveCategoryState({required this.category});

  @override
  List<Object?> get props => [category];

  @override
  MainSwitchData get getCategory => category;
}
