import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:test_weather_app/config/routes/app_route.dart';
import 'package:test_weather_app/feature/weather/presentation/binding/home_binding.dart';
import 'package:test_weather_app/feature/weather/presentation/binding/weather_daily_binding.dart';
import 'package:test_weather_app/feature/weather/presentation/view/home_view.dart';
import 'package:test_weather_app/feature/weather/presentation/view/weather_daily_view.dart';

class AppPages {
  static const initialRoute = AppRoute.HOME;

  static List<GetPage> getPages = [
    GetPage(
      name: AppRoute.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoute.WEATHER_DAILY,
      page: () => WeatherDailyView(),
      binding: WeatherDailyBinding(),
    ),
  ];
}
