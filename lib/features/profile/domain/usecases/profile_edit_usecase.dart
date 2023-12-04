import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:crossworduel/core/usecases/params_parent.dart';
import 'package:crossworduel/core/usecases/usecase.dart';
import 'package:crossworduel/features/profile/domain/repositories/profile_repository_contract.dart';
import 'package:crossworduel/features/unauth/domain/entities/me_entity.dart';

class ProfileEditUsecase implements UseCase<MeEntity, ProfileEditParams> {
  final ProfileRepositoryContract _repositoryContract;

  ProfileEditUsecase(this._repositoryContract);

  @override
  Future<Either<ExceptionData, MeEntity>> call(ProfileEditParams params) async {
    return _repositoryContract.edit(params);
  }
}

// ignore: must_be_immutable
class ProfileEditParams extends ParamsParent {
  String username;
  String avatar;
  bool isPushEnabled;

  ProfileEditParams({
    required this.username,
    required this.isPushEnabled,
    required this.avatar,
  });

  void update({
    String? newUsername,
    bool? newIsPushEnabled,
    String? avatar,
  }) {
    username = newUsername ?? username;
    isPushEnabled = newIsPushEnabled ?? isPushEnabled;
    avatar = avatar ?? avatar;
  }

  @override
  Map<String, dynamic> getBody({Map<String, dynamic> params = const {}}) {
    return {
      "username": username,
      "isPushEnabled": isPushEnabled,
    };
  }

  @override
  List<Object?> get props => [username, isPushEnabled];
}
