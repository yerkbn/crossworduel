import 'package:crossworduel/core/usecases/params_parent.dart';

class NoParams extends ParamsParent {
  const NoParams();

  @override
  List<Object?> get props => [];

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {
      ...params,
    };
  }
}
