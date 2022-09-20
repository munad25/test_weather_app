import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_weather_app/core/enum/connectifity_status.dart';
import 'package:test_weather_app/core/usecase/usecase.dart';
import 'package:test_weather_app/feature/weather/domain/entities/abstract/abs_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_today_weather_local_usecase.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_today_weather_network_usecase.dart';

class HomeController extends GetxController {
  final _getTodayNetwork = Get.find<GetTodayWeatherNetworkUsecase>();
  final _getTodayLocal = Get.find<GetTodayWeatherLocalUsecase>();

  final Rxn<Placemark> placemark = Rxn();
  final Rxn<TodayWeather> todayWeather = Rxn();
  final Rxn<AbsWeather> active = Rxn();
  final Rx<ConnectifityStatus> internetStatus = ConnectifityStatus.offline.obs;

  @override
  void onInit() async {
    final connectifity = Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        internetStatus.value = ConnectifityStatus.online;
      } else {
        internetStatus.value = ConnectifityStatus.offline;
      }
    });

    ever(internetStatus, (_) {
      initData();
    });
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    bool serviceEnabled;
    LocationPermission permission;
    if (internetStatus.value == ConnectifityStatus.online) {
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
        (r) {
          todayWeather.value = r;
          active.value = r.current;
        },
      );
    }  else {
      final result = await _getTodayLocal(NoParams());

      result.fold((l) {
        if(active.value == null) {
          Get.snackbar('Data empty', 'data not found in offline mode', duration: 5.seconds);
        }

        print(l.message);
      }, (r) {
        Get.snackbar('Data offline','You are in offline mode', duration: 5.seconds);
        active.value = r.current;
        todayWeather.value = r;
      });
    }
  } 
}
