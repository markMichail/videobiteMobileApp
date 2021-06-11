import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:videobite/shared/components/constants.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: '$URL/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token ?? '',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    @required dynamic data,
    String token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': token != null ? 'Bearer ' + token : null,
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
  }

  static Future<Response> deleteData({
    @required String url,
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token != null ? 'Bearer ' + token : null,
    };
    return dio.delete(
      url,
    );
  }
}
