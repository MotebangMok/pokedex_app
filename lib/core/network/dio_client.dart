import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/api_constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient(){
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      responseBody: true,
      requestBody: true,
      logPrint: (object) => debugPrint(object.toString(),
    ),),);
    
  }

  Dio get dio=>_dio;
}
