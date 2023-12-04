import 'package:dio/dio.dart';
import 'package:crossworduel/config/network/custom_dio.dart';
import 'package:crossworduel/features/profile/data/models/heart_time_model.dart';
import 'package:crossworduel/features/profile/data/models/notification_model.dart';
import 'package:crossworduel/features/profile/data/models/score_model.dart';
import 'package:crossworduel/features/unauth/data/models/me_model.dart';
import 'package:retrofit/retrofit.dart';
part 'profile_remote_data_source.g.dart';

abstract class ProfileRemoteDataSourceContract {
  Future<MeModel> edit(Map<String, dynamic> body);
  Future<ScoreModel> myScore();
  Future<MeModel> refreshMe();
  Future<List<NotificationModel>> getNotification();
  Future<void> checkUsername(@Body() Map<String, dynamic> body);
  Future<void> deleteUser();
  Future<HeartTimeModel> getHeartTime();
}

@RestApi()
abstract class ProfileRemoteDataSourceImpl
    implements ProfileRemoteDataSourceContract {
  factory ProfileRemoteDataSourceImpl(
      {required CustomAuthDio authDio, String? baseUrl}) {
    final instance =
        _ProfileRemoteDataSourceImpl(authDio.dio, baseUrl: baseUrl);
    return instance;
  }

  @override
  @POST("/api/v1/me/edit")
  Future<MeModel> edit(@Body() Map<String, dynamic> body);

  @override
  @POST("/api/v1/score/my")
  Future<ScoreModel> myScore();

  @override
  @GET("/api/v1/me/")
  Future<MeModel> refreshMe();

  @override
  @GET("/api/v1/me/notification")
  Future<List<NotificationModel>> getNotification();

  @override
  @POST("/api/v1/checkUsername")
  Future<void> checkUsername(@Body() Map<String, dynamic> body);

  @override
  @POST("/api/v1/user/delete")
  Future<void> deleteUser();

  @override
  @GET("/api/v1/me/timeTillFullHeart")
  Future<HeartTimeModel> getHeartTime();
}
