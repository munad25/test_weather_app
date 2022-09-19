import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/week_weather.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_daily_weather_network_usecase.dart';

class WeatherDailyController extends GetxController {
  final _getDailyNetwork = Get.find<GetDailyWeatherNetworkUsecase>();
  final RxList<DailyWeather> dailyWeather = <DailyWeather>[].obs;
  final Rxn<DailyWeather> active = Rxn();
  
  
  @override
  void onInit() {
    initData();
    // TODO: implement onInit
    super.onInit();
  }

   Future<void> initData() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Failed!', 'Location service unavailable');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final location = await Geolocator.getCurrentPosition();

    final result = await _getDailyNetwork(location);
    result.fold(
      (l) => print(l),
      (r) {
        dailyWeather.clear();
        if(r.isNotEmpty) {
          active.value = r.first;
        }
        dailyWeather.addAll(r);
      },
    );
  }
}