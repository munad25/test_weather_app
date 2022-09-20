import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_weather_app/core/enum/connectifity_status.dart';
import 'package:test_weather_app/core/usecase/usecase.dart';
import 'package:test_weather_app/core/utils/local_data.dart';
import 'package:test_weather_app/feature/weather/domain/entities/abstract/abs_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/today_weather.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_today_weather_local_usecase.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_today_weather_network_usecase.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeController extends GetxController {
  final _getTodayNetwork = Get.find<GetTodayWeatherNetworkUsecase>();
  final _getTodayLocal = Get.find<GetTodayWeatherLocalUsecase>();
  final _localData = LocalData();

  final Rxn<Placemark> placemark = Rxn();
  final Rxn<TodayWeather> todayWeather = Rxn();
  final Rxn<AbsWeather> active = Rxn();
  final Rx<ConnectifityStatus> internetStatus = ConnectifityStatus.offline.obs;
  final RxString latestUpdate = ''.obs;
  final RxString latestPosition = ''.obs;

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

    final checkInternet = await Connectivity().checkConnectivity();
    if(checkInternet == ConnectivityResult.mobile || checkInternet == ConnectivityResult.wifi) {
      internetStatus.value = ConnectifityStatus.online;
    } else {
      internetStatus.value = ConnectifityStatus.offline;
    }
    await initData();

    ever(internetStatus, (_) async {
      await initData();
    });
    super.onInit();
    
  }

  Future<void> initData() async {
    bool serviceEnabled;
    LocationPermission permission;
    final getDate= await _localData.getLatestUpdate();
    latestUpdate.value =  timeago.format(getDate);

    latestPosition.value =  await _localData.getLatestPosition() ?? '-';

    
    if (internetStatus.value == ConnectifityStatus.online) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Failed!', 'Location service unavailable');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.defaultDialog(
            title: 'Access denied',
            middleText: 'we need your location data to get weather data around you',
            barrierDismissible: false,
            confirm: ElevatedButton(
              onPressed: () async => await Geolocator.openLocationSettings(),
              child: Text('Open app seting'),
            ),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.defaultDialog(
            title: 'Access denied',
            middleText: 'we need your location data to get weather data around you',
            barrierDismissible: false,
            confirm: ElevatedButton(
              onPressed: () async => await Geolocator.openLocationSettings(),
              child: Text('Open app seting'),
            ),
          );

          return;
      }

      final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      final address =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (address.length > 0) {
        placemark.value = address.first;
        _localData.setLatestPosition(address.first.locality ?? '-');
      }

      final result = await _getTodayNetwork(location);
      result.fold(
        (l) => print(l),
        (r) {
          todayWeather.value = r;
          active.value = r.current;
        },
      );
    } else {
      final result = await _getTodayLocal(NoParams());

      result.fold((l) {
        if (active.value == null) {
          Get.snackbar('Data empty', 'data not found in offline mode',
              duration: 5.seconds);
        }

        print(l.message);
      }, (r) {
        Get.snackbar('Data offline', 'You are in offline mode',
            duration: 5.seconds);
        active.value = r.current;
        todayWeather.value = r;
      });
    }
  }
}
