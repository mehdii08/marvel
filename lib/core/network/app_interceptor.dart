import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const publicKey = '5295c550265a24404f9cace64c971bd6'; //todo
    const privateKey = 'cb17168db6c04859f0fb530529dc0dcda49255eb'; //todo
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
