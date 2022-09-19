import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'weather_network_services.g.dart';

@RestApi()
abstract class WeatherNetworkSerices {
  factory WeatherNetworkSerices(Dio dio, {String baseUrl}) = _WeatherNetworkSerices;

  @GET('/data/2.5/onecall')
  Future<HttpResponse> getWeatherData(
    @Queries() Map<String, dynamic> queries
  );

}