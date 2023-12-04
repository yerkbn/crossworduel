part of 'custom_dio.dart';

class CustomUnauthDio extends CustomDio {
  CustomUnauthDio({
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
      RequestOptions requestOptions, RequestInterceptorHandler handler) {
    return handler.next(requestOptions);
  }

  @override
  Future<void> call(GetIt sl) async {
    sl.registerLazySingleton<CustomUnauthDio>(() => this);
  }
}
