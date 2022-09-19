import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_weather_app/core/utils/app_colors.dart';
import 'package:test_weather_app/core/utils/app_icons.dart';
import 'package:test_weather_app/core/widget/app_svg_icon.dart';

class WindSpeedWidget extends StatelessWidget {
  final double windSpeed;

  const WindSpeedWidget({Key? key, required this.windSpeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSvgIcon(
          asset: AppIcons.wind,
          customerSize: Size(37.r, 19.r),
        ),
        SizedBox(height: 5.w),
        Text(
          '$windSpeed kmph',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 13.sp,
          ),
        ),
        Text(
          'Wind',
          style: TextStyle(
            color: AppColors.blueLight20,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}