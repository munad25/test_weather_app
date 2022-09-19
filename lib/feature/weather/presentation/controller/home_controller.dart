import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_today_weather_network_usecase.dart';

class HomeController extends GetxController {
  final _getTodayNetwork = Get.find<GetTodayWeatherNetworkUsecase>();

  final Rxn<Placemark> placemark = Rxn();
  final Rxn<TodayWeather> todayWeather = Rxn();

  @override
  void onInit() async {
    super.onInit();
    await initData();
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
    final address =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (address.length > 0) {
      placemark.value = address.first;
    }

    final result = await _getTodayNetwork(location);
    result.fold(
      (l) => print(l),
      (r) => todayWeather.value = r,
    );
  }
}
