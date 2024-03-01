import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "Accept";
const String AUTHORIZATION = "Authorization";
const String DEFAULT_LANGUAGE = "language";

class DioHelper {
  static late Dio dio;
  static DioHelper? _instance;

  DioHelper._(); // Private constructor

  static DioHelper get instance {
    _instance ??= DioHelper._(); // Create a new instance if not exists
    return _instance!;
  }

  static void init() {
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      // ACCEPT: APPLICATION_JSON,
      // AUTHORIZATION: Constants.token,
      // DEFAULT_LANGUAGE: language
    };

    dio = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
        headers: headers,
        receiveTimeout: const Duration(seconds: 6),
        sendTimeout: const Duration(seconds: 6),
      ),
    );

    if (!kReleaseMode) {
      // It's debug mode so print app logs
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      AUTHORIZATION: token ?? '',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
