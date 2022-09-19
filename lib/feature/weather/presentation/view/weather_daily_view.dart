import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_weather_app/core/utils/app_colors.dart';
import 'package:test_weather_app/core/utils/app_icons.dart';
import 'package:test_weather_app/core/utils/number_2_time.dart';
import 'package:test_weather_app/core/widget/app_svg_icon.dart';
import 'package:test_weather_app/feature/weather/domain/entities/daily_weather.dart';
import 'package:test_weather_app/feature/weather/presentation/controller/weather_daily_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_weather_app/feature/weather/presentation/widget/chance_of_rain_widget.dart';
import 'package:test_weather_app/feature/weather/presentation/widget/humidity_widget.dart';
import 'package:test_weather_app/feature/weather/presentation/widget/wind_speed_widget.dart';

class WeatherDailyView extends GetView<WeatherDailyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          Container(
            height: 357.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(65.r),
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColors.blueLight60,
                    blurRadius: 20.h,
                    spreadRadius: 10.h),
                BoxShadow(
                    color: AppColors.blueLight10,
                    blurRadius: 2.h,
                    spreadRadius: 1.h),
              ],
              gradient: Gradient.lerp(
                const LinearGradient(
                  colors: [
                    AppColors.white,
                    AppColors.blueLight10,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                const LinearGradient(
                  colors: [
                    AppColors.blueLight10,
                    AppColors.blueLight60,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                1,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppSvgIcon(
                              asset: AppIcons.menuIcon,
                              size: 35.sp,
                            ),
                            AppSvgIcon(
                              asset: AppIcons.verticalMenu,
                              customerSize: Size(2.h, 17.h),
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.calendar5,
                                color: AppColors.white,
                                size: 16.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                '7 Days',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 150.h,
                          child: Image.network(
                            'http://openweathermap.org/img/wn/10n@2x.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          (() {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.active.value != null
                                      ? number2Time(
                                          number: controller.active.value!.dt,
                                          type: TimeType.day)
                                      : '--',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${controller.active.value?.temp.max ?? 0}/',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 40.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${controller.active.value?.temp.min ?? 0}\u00B0',
                                        style: TextStyle(
                                          color: AppColors.blueLight20,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '${controller.active.value?.weather[0].description ?? '--'}',
                                  style: TextStyle(
                                    color: AppColors.blueLight20,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => WindSpeedWidget(
                            windSpeed:
                                controller.active.value?.wind_speed ?? 0.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => HumidityWidget(
                            humidity: controller.active.value?.humidity ?? 0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(() => ChanceOfRainWidget(
                            cloud: controller.active.value?.clouds ?? 0)),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.h),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(36.w, 20.h, 36.w, 0),
              child: Obx(
                () => Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(60),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(),
                  },
                  children: controller.dailyWeather
                      .map((element) => _buildRowTable(element))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildRowTable(DailyWeather dailyWeather) {
    return TableRow(

      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            number2Time(number: dailyWeather.dt, type: TimeType.day),
            style: TextStyle(
              color: AppColors.gray20,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 60.r,
              height: 60.r,
              child: Image.network(
                'http://openweathermap.org/img/wn/${dailyWeather.weather.first.icon}@2x.png',
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter,
              ),
            ),
            Expanded(
              child: Text(
                dailyWeather.weather.first.description,
                style: TextStyle(
                  color: AppColors.gray20,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ),
          ],
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: '${dailyWeather.temp.max}\u00B0',
                    style: const TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  TextSpan(
                    text: ' ${dailyWeather.temp.min}\u00B0',
                    style: const TextStyle(
                      color: AppColors.blueLight20,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
