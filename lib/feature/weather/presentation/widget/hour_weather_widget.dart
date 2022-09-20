import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_weather_app/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_weather_app/core/utils/number_2_time.dart';
import 'package:test_weather_app/feature/weather/domain/entities/hourly_weather.dart';

class HourWeatherWidget extends StatelessWidget {
  final HourlyWeather weather;
  final Function()? onPressed;
  final bool? active;
  const HourWeatherWidget({
    Key? key,
    this.onPressed,
    this.active,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(27.r),
            gradient: active ?? false ? AppColors.mainBgGradien() : null,
            border: Border.all(
              color: AppColors.gray90,
              style: active ?? false ? BorderStyle.none : BorderStyle.solid,
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
                child: CachedNetworkImage(
                            errorWidget: (context, url, error) => Icon(Iconsax.gallery_slash, color: AppColors.white, size: 40.sp,),
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter,
                            imageUrl:
                                'http://openweathermap.org/img/wn/${weather.weather.first.icon}@2x.png',
                          ),
              ),
              Text(
                number2Time(number: weather.dt, type: TimeType.hours),
                style: TextStyle(
                  color: active ?? false ? AppColors.white : AppColors.gray20,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
