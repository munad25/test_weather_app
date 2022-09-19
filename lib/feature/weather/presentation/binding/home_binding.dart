import 'package:get/get.dart';
import 'package:test_weather_app/core/binding/app_binding.dart';
import 'package:test_weather_app/feature/weather/presentation/controller/home_controller.dart';

class HomeBinding extends AppBinding {
  @override
  void pageController() {
    Get.lazyPut(() => HomeController());
  }

}