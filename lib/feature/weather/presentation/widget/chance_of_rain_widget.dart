import 'package:flutter/material.dart';
import 'package:test_weather_app/core/utils/app_colors.dart';
import 'package:test_weather_app/core/utils/app_icons.dart';
import 'package:test_weather_app/core/widget/app_svg_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChanceOfRainWidget extends StatelessWidget {
  final int cloud;

  const ChanceOfRainWidget({
    Key? key,
    required this.cloud,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSvgIcon(
          asset: AppIcons.rain,
          customerSize: Size(21.2.r, 19.r),
        ),
        SizedBox(height: 5.w),
        Text(
          '$cloud%',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 13.sp,
          ),
        ),
        Text(
          'Chance of rain',
          style: TextStyle(
            color: AppColors.blueLight20,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}