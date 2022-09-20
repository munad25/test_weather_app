import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_weather_app/config/routes/app_pages.dart';
import 'package:test_weather_app/config/theme/app_themes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await GetStorage.init();

  runApp(
    ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) => GetMaterialApp(
              getPages: AppPages.getPages,
              initialRoute: AppPages.initialRoute,
              theme: AppThemes.light,
              debugShowCheckedModeBanner: false,
            )),
  );
}
