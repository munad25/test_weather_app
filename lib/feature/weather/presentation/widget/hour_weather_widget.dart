import 'package:flutter/material.dart';
import 'package:test_weather_app/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_weather_app/core/utils/number_2_time.dart';
import 'package:test_weather_app/feature/weather/domain/entities/hourly_weather.dart';

class HourWeatherWidget extends StatelessWidget {
  final HourlyWeather weather;
  const HourWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27.r),
          border: Border.all(
            color: AppColors.gray90,
          )),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${weather.temp}\u00B0',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Image.network(
                'http://openweathermap.org/img/wn/${weather.weather.first.icon}@2x.png',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '${number2Time(number: weather.dt, type: TimeType.hours)}',
              style: TextStyle(
                color: AppColors.gray20,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}