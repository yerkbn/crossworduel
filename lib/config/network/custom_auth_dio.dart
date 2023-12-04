part of 'custom_dio.dart';

class CustomAuthDio extends CustomDio {
  String get token => globalSL<AuthBloc>().currentUser!.token;
  Map<String, String> get getHeader => {"Authorization": token};

  CustomAuthDio({
    required super.backendUrl,
  }) {
    dio.options = getBaseOptions;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequest,
        onResponse: onResponse,
      ),
    );
  }

  dynamic onRequest(
    RequestOptions requestOptions,
    RequestInterceptorHandler handler,
  ) {
    printWrapped(
        'REQUEST::  URI: ${requestOptions.uri} - DATA:${requestOptions.data} - TOKEN: $token');
    requestOptions.headers = getHeader;
    return handler.next(requestOptions);
  }

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton<CustomAuthDio>(() => this);
  }
}
