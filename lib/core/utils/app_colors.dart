import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color bgColor = Color(0xff000918);
  static const Color white = Color(0xffffffff);
  static const Color gray20 = Color(0xff687B92);
  static const Color gray90 = Color(0xff272727);
  static const Color blueLight10 = Color(0xff82DAF4);
  static const Color blueLight20 = Color(0xff82B5F8);
  static const Color blueLight60 = Color(0xff126CF4);
  static const Color yellowLight = Color(0xffFFF30F);

  static Gradient? mainBgGradien() {
    return Gradient.lerp(
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
    );
  }
}
