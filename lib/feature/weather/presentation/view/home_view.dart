import 'package:calendar_time/calendar_time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_weather_app/config/routes/app_route.dart';
import 'package:test_weather_app/core/utils/app_colors.dart';
import 'package:test_weather_app/core/utils/app_icons.dart';
import 'package:test_weather_app/core/utils/number_2_time.dart';
import 'package:test_weather_app/core/widget/app_svg_icon.dart';
import 'package:test_weather_app/feature/weather/domain/entities/current_weather.dart';
import 'package:test_weather_app/feature/weather/domain/entities/weather.dart';
import 'package:test_weather_app/feature/weather/presentation/controller/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_weather_app/feature/weather/presentation/widget/chance_of_rain_widget.dart';
import 'package:test_weather_app/feature/weather/presentation/widget/hour_weather_widget.dart';
import 'package:test_weather_app/feature/weather/presentation/widget/humidity_widget.dart';
import 'package:test_weather_app/feature/weather/presentation/widget/wind_speed_widget.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
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
                                  Icons.location_on,
                                  color: AppColors.white,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Obx(
                                  () => Text(
                                    controller.placemark.value?.locality ?? '-',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.white),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 6.r,
                            width: 6.r,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.yellowLight),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Updated 10min ago',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      if (controller.todayWeather.value != null) {
                        final icon = controller
                            .todayWeather.value!.current.weather.first.icon;
                        return SizedBox(
                          height: 150.h,
                          width: 150.h,
                          child: Image.network(
                            'http://openweathermap.org/img/wn/$icon@2x.png',
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter,
                          ),
                        );
                      }

                      return SizedBox(
                        height: 150.h,
                        width: 150.h,
                      );
                    }),
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${controller.todayWeather.value?.current.temp ?? 0}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 70.sp,
                              ),
                            ),
                            TextSpan(
                              text: '\u00B0',
                              style: TextStyle(
                                color: AppColors.blueLight20,
                                fontWeight: FontWeight.w700,
                                fontSize: 100.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.todayWeather.value?.current.weather.first
                                .description ??
                            '-',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.todayWeather.value != null) {
                        return Text(
                          number2Time(
                            number: controller.todayWeather.value!.current.dt,
                            type: TimeType.date,
                          ),
                          style: TextStyle(
                            color: AppColors.blueLight20,
                            fontSize: 12.sp,
                          ),
                        );
                      }
                      return Text(
                        '-, --,--,----',
                        style: TextStyle(
                          color: AppColors.blueLight20,
                          fontSize: 12.sp,
                        ),
                      );
                    }),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => WindSpeedWidget(
                              windSpeed: controller
                                      .todayWeather.value?.current.wind_speed ??
                                  0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => HumidityWidget(
                              humidity: controller
                                      .todayWeather.value?.current.humidity ??
                                  0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => ChanceOfRainWidget(
                              cloud: controller
                                      .todayWeather.value?.current.clouds ??
                                  0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 38.h),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              height: 183.h,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 39.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoute.WEATHER_DAILY),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '7 days',
                                style: TextStyle(
                                  color: AppColors.gray20,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                Iconsax.arrow_right_3,
                                color: AppColors.gray20,
                                size: 12.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.sp),
                  Expanded(
                    child: Obx(
                      () {
                        if (controller.todayWeather.value != null) {
                          final hourList =
                              controller.todayWeather.value!.hourly;
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: hourList.length,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 34.w),
                                    HourWeatherWidget(weather: hourList[index]),
                                  ],
                                );
                              }
                              return HourWeatherWidget(
                                  weather: hourList[index]);
                            },
                          );
                        }

                        return SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}






