import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:marvel_characters/core/config.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final hash =
        md5.convert(utf8.encode('$ts$privateKey$publicKey')).toString();
    final params = <String, dynamic>{
      'ts': ts,
      'apikey': publicKey,
      'hash': hash,
    };
    return handler.next(options..queryParameters.addAll(params));
  }
}
