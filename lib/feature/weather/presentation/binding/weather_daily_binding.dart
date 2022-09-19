import 'package:get/get.dart';
import 'package:test_weather_app/core/binding/app_binding.dart';
import 'package:test_weather_app/feature/weather/presentation/controller/weather_daily_controller.dart';

class WeatherDailyBinding extends AppBinding {
  @override
  void pageController() {
    Get.lazyPut(
      () => WeatherDailyController(),
    );
  }
}
