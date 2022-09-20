import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:test_weather_app/core/enum/connectifity_status.dart';
import 'package:test_weather_app/core/usecase/usecase.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/week_weather.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_daily_weather_local_usecase.dart';
import 'package:test_weather_app/feature/weather/domain/usecase/get_daily_weather_network_usecase.dart';

class WeatherDailyController extends GetxController {
  final _getDailyNetwork = Get.find<GetDailyWeatherNetworkUsecase>();
  final _getDailyLocal = Get.find<GetDailyWeatherLocalUsecase>();
  final RxList<DailyWeather> dailyWeather = <DailyWeather>[].obs;
  
  final Rxn<DailyWeather> active = Rxn();

   final Rx<ConnectifityStatus> internetStatus = ConnectifityStatus.offline.obs;
  
  
  @override
  void onInit() {
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


    initData();
    // TODO: implement onInit
    super.onInit();
  }

   Future<void> initData() async {
    bool serviceEnabled;
    LocationPermission permission;
    if(internetStatus.value == ConnectifityStatus.online) {

   
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
   } else {
    final result = await _getDailyLocal(NoParams());

      result.fold((l) {
        if(active.value == null) {
          Get.snackbar('Data empty', 'data not found in offline mode', duration: 5.seconds);
        }

        print(l.message);
      }, (r) {
        Get.snackbar('Data offline','You are in offline mode', duration: 5.seconds);
        active.value = r.first;
        dailyWeather.value = r;
      });
   }
  }
}