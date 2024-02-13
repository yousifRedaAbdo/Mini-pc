import 'package:dio/dio.dart';

class dioHelper {
  static late Dio dio;
  static int() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getdata({
    required String url,
    Map<String, dynamic>? quary,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token'
    };
    return await dio.get(url, queryParameters: quary);
  }

  static Future<Response> postdata({
    required String url,
    Map<String, dynamic>? quary,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Token $token'
    };
    return dio.post(url, queryParameters: quary, data: data);
  }

  static Future<Response> putdata({
    required String url,
    Map<String, dynamic>? quary,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': 'Token $token'
    };
    return dio.put(url, queryParameters: quary, data: data);
  }

  static Future<Response> postdataLogin({
    required String url,
    Map<String, dynamic>? quary,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Authorization': token
    };
    return dio.post(url, queryParameters: quary, data: data);
  }
}
