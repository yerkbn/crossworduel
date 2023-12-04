part of 'refresh_bloc.dart';

@immutable
abstract class RefreshState {}

class SilentRefreshState extends RefreshState {}

class RunRefreshState extends RefreshState {}
