part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class SwitchCategoryEvent extends CategoryEvent {
  final MainSwitchData category;

  SwitchCategoryEvent({required this.category});
}
