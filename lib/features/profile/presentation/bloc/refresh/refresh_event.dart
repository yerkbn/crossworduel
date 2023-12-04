part of 'refresh_bloc.dart';

@immutable
abstract class RefreshEvent {}

class RunRefreshEvent extends RefreshEvent {}
