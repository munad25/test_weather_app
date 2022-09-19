import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppSvgIcon extends StatelessWidget {
  final String asset;
  final double? size;
  final Size? customerSize;
  final Color? color;
  const AppSvgIcon({
    Key? key,
    required this.asset,
    this.size,
    this.customerSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customerSize?.height ?? size ?? 24.r,
      width: customerSize?.width ?? size ?? 24.r,
      child: SvgPicture.asset(
        asset,
        fit: BoxFit.fill,
        color: color,
      ),
    );
  }
}
