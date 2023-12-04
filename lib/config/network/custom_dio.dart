import 'package:crossworduel/core/exception/exception_mapper.dart';
import 'package:crossworduel/core/exception/network_exception.dart';
import 'package:crossworduel/core/normalizer/normalizer.dart';
import 'package:crossworduel/core/service-locator/service_locator.dart';
import 'package:crossworduel/core/service-locator/service_locator_manager.dart';
import 'package:crossworduel/features/unauth/presentation/bloc/auth/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

part 'custom_auth_dio.dart';
part 'custom_unauth_dio.dart';

class CustomDio extends ServiceLocator with Normalizer {
  String backendUrl;
  final ExceptionMapper exceptionMapper = ExceptionMapper();
  final Dio dio = Dio();

  CustomDio({required this.backendUrl});

  BaseOptions get getBaseOptions => BaseOptions(
        baseUrl: backendUrl,
        receiveTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 10),
        contentType: "application/json",
      );

  dynamic onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    printWrapped(
        'RESPONSE::  URI: ${response.realUri} DATA::: ${response.data}');
    if (response.statusCode != 200) {
      throw NetworkFailureExcD();
    } else if ((response.data as Map)['statusCode'] == 1000) {
      // success
      if ((response.data as Map)['result'] == null) {
        response.data = [];
      } else {
        response.data = (response.data as Map)['result'];
      }

      return handler.next(response);
    } else {
      exceptionMapper.mapping(response.data as Map);
    }
  }

  set baseUrl(String url) {
    dio.options.baseUrl = url;
  }

  String get baseUrl => dio.options.baseUrl;

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton(() => this);
  }
}
