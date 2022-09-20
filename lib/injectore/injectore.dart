import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test_weather_app/core/services/dio_services.dart';
import 'package:test_weather_app/feature/weather/data/datasource/weather_local_services.dart';
import 'package:test_weather_app/feature/weather/data/datasource/weather_network_services.dart';
import 'package:test_weather_app/feature/weather/data/repository/weather_local_repository_impl.dart';
import 'package:test_weather_app/feature/weather/data/repository/weather_repository_impl.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_local_repository.dart';
import 'package:test_weather_app/feature/weather/domain/repository/weather_repository.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_daily_weather_local_usecase.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_daily_weather_network_usecase.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_today_weather_local_usecase.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_today_weather_network_usecase.dart';

final injector = Get.find;
void initialDependencies() {
  Get.lazyPut<Dio>(() => dioServices());

  Get.lazyPut<WeatherNetworkSerices>(
    () => WeatherNetworkSerices(
      injector(),
    ),
  );

  Get.lazyPut<WeatherLocalServices>(
    () => WeatherLocalServices(),
  );

  Get.lazyPut<WeatherRepository>(
    () => WeatherRepositoryImpl(
      injector(),
      injector(),
    ),
  );

  Get.lazyPut<WeatherLocalRepository>(
    () => WeatherLocalRepositoryImpl(
      injector(),
    ),
  );

  Get.lazyPut<GetTodayWeatherNetworkUsecase>(
    () => GetTodayWeatherNetworkUsecase(
      injector(),
    ),
  );

  Get.lazyPut<GetDailyWeatherNetworkUsecase>(
    () => GetDailyWeatherNetworkUsecase(
      injector(),
    ),
  );

  Get.lazyPut(
    () => GetDailyWeatherLocalUsecase(
      injector(),
    ),
  );

  Get.lazyPut(
    () => GetTodayWeatherLocalUsecase(
      injector(),
    ),
  );
}
