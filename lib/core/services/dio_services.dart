
import 'package:dio/dio.dart';

Dio dioServices() {
  Dio dio = Dio();
  dio.options.baseUrl = 'https://api.openweathermap.org';
  return dio;
}