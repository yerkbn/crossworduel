import 'package:equatable/equatable.dart';

abstract class ParamsParent extends Equatable {
  const ParamsParent();

  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}});
}
