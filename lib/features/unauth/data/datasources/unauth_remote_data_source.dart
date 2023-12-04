import 'package:dio/dio.dart';
import 'package:crossworduel/config/network/custom_dio.dart';
import 'package:crossworduel/features/unauth/data/models/me_model.dart';
import 'package:retrofit/retrofit.dart';

part 'unauth_remote_data_source.g.dart';

abstract class UnauthRemoteDataSourceContract {
  Future<MeModel> signin(Map<String, dynamic> body);
  Future<MeModel> signinWithGoogle(Map<String, dynamic> body);
  Future<MeModel> signinWithApple(@Body() Map<String, dynamic> body);
}

@RestApi()
abstract class UnauthRemoteDataSourceImpl
    implements UnauthRemoteDataSourceContract {
  factory UnauthRemoteDataSourceImpl(
      {required CustomUnauthDio unauthDio, String? baseUrl}) {
    final instance =
        _UnauthRemoteDataSourceImpl(unauthDio.dio, baseUrl: baseUrl);
    return instance;
  }

  @override
  @POST("/api/v1/auth")
  Future<MeModel> signin(@Body() Map<String, dynamic> body);

  @override
  @POST("/api/v1/auth/google")
  Future<MeModel> signinWithGoogle(@Body() Map<String, dynamic> body);

  @override
  @POST("/api/v1/auth/apple")
  Future<MeModel> signinWithApple(@Body() Map<String, dynamic> body);
}
