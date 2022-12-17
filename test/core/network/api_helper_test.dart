import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/errors/exceptions.dart';
import 'package:marvel_characters/core/network/api_helper.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late ApiHelper apiHelper;

  setUp(() {
    dio = MockDio();
    apiHelper = ApiHelper(dio);
  });

  group('request', () {
    final tParams = {'id': '123'};
    final tData = {'id': '456'};
    const tPath = '/path/to/api';
    const tMethod = Method.post;
    test('should forward requests to Dio', () async {
      when(() => dio.request(any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenAnswer(
              (_) async => Response(requestOptions: RequestOptions(path: '')));
      await apiHelper.request(tPath,
          method: tMethod, data: tData, queryParameters: tParams);
      verify(() => dio.request(tPath,
          data: tData,
          queryParameters: tParams,
          options: any(named: 'options'))).called(1);
    });
    test(
        'should throw network error if request failed and error is of type CONNECT_TIMEOUT',
        () async {
      when(() => dio.request(any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenThrow(DioError(
              type: DioErrorType.connectTimeout,
              requestOptions: RequestOptions(path: '')));
      final Future<Response<dynamic>> Function(String,
          {Map<String, dynamic> data,
          Method method,
          Map<String, dynamic> queryParameters}) call = apiHelper.request;
      expect(
          () async => await call(tPath,
              method: tMethod, data: tData, queryParameters: tParams),
          throwsA(isA<TimeoutException>()));
    });
    test(
        'should throw network error if request failed and error is of type RECEIVE_TIMEOUT',
        () async {
      when(() => dio.request(any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenThrow(DioError(
              type: DioErrorType.receiveTimeout,
              requestOptions: RequestOptions(path: '')));
      final Future<Response<dynamic>> Function(String,
          {Map<String, dynamic> data,
          Method method,
          Map<String, dynamic> queryParameters}) call = apiHelper.request;
      expect(
          () async => await call(tPath,
              method: tMethod, data: tData, queryParameters: tParams),
          throwsA(isA<TimeoutException>()));
    });
    test(
        'should throw network error if request failed and error is of type SEND_TIMEOUT',
        () async {
      when(() => dio.request(any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenThrow(DioError(
              type: DioErrorType.sendTimeout,
              requestOptions: RequestOptions(path: '')));
      final Future<Response<dynamic>> Function(String,
          {Map<String, dynamic> data,
          Method method,
          Map<String, dynamic> queryParameters}) call = apiHelper.request;
      expect(
          () async => await call(tPath,
              method: tMethod, data: tData, queryParameters: tParams),
          throwsA(isA<TimeoutException>()));
    });
    test(
        'should throw network error if request failed and error is of type RESPONSE and there is one element in errors in response',
        () async {
      final tResponse = Response(data: {
        "code": "InvalidCredentials",
        "message": "The passed API key is invalid."
      }, statusCode: 409, requestOptions: RequestOptions(path: ''));
      when(() => dio.request(any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenThrow(DioError(
              response: tResponse,
              type: DioErrorType.response,
              requestOptions: RequestOptions(path: '')));
      final Future<Response<dynamic>> Function(String,
          {Map<String, dynamic> data,
          Method method,
          Map<String, dynamic> queryParameters}) call = apiHelper.request;
      expect(
          () async => await call(tPath,
              method: tMethod, data: tData, queryParameters: tParams),
          throwsA(equals(const ServerException(
            statusCode: 409,
            message: 'The passed API key is invalid.',
          ))));
    });
  });
}
