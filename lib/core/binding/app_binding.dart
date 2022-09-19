import 'package:get/get.dart';
import 'package:test_weather_app/injectore/injectore.dart';

abstract class AppBinding implements Bindings {
  
  void pageController();
  
  @override
  void dependencies() {
    // inject  dependencies from data & domain layer
    initialDependencies();

    // inject page controller
    pageController();
  }

}