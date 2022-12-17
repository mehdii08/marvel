import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/errors/exceptions.dart';

enum Method { get, post, put, delete, update, patch }

extension MathodName on Method {
  String get name {
    switch (this) {
      case Method.get:
        return 'GET';
      case Method.post:
        return 'POST';
      case Method.update:
        return 'UPDATE';
      case Method.delete:
        return 'DELETE';
      case Method.put:
        return 'PUT';
      case Method.patch:
        return 'PATCH';
    }
  }
}

typedef Request = Future<Response> Function();

@lazySingleton
class ApiHelper {
  final Dio _dio;

  ApiHelper(this._dio);

  Future<Response> request(
    String path, {
    Method method = Method.get,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    Future<Response> request() => _dio.request(
          path,
          options: Options(method: method.name),
          data: data,
          queryParameters: queryParameters,
        );
    return await _handleErrorAndGetResponse(request);
  }

  Future<Response> _handleErrorAndGetResponse(Request request) async {
    try {
      return await request();
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        throw const TimeoutException();
      } else if (e.type == DioErrorType.response && e.response?.data is Map) {
        final response = e.response;
        final message = response?.data['message'];
        throw ServerException(
          statusCode: response?.statusCode,
          message: message,
        );
      }
      throw const NetworkException();
    }
  }
}
