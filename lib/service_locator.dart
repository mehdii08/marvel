import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/config.dart';
import 'package:marvel_characters/core/network/app_interceptor.dart';
import 'package:marvel_characters/service_locator.config.dart';

final sl = GetIt.I;

@InjectableInit()
Future initSL() async {
  await $initGetIt(sl);
  sl<Dio>().interceptors.addAll([
    AppInterceptor(),
    LogInterceptor(responseBody: true, requestBody: true),
  ]);
}

Future<Dio> getDio() async {
  final options = BaseOptions(
      baseUrl: serverUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds
      receiveTimeout: 20 * 1000 // 20 seconds
      );
  final dio = Dio(options)..transformer = DefaultTransformer();
  return dio;
}

@module
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<Dio> get resolveDio => getDio();
}
