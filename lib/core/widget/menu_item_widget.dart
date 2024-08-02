import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/config.dart';

class MenuItemWidget extends StatelessWidget {
  final double? size;
  final VoidCallback onPressed;
  final String label;
  final String icon;
  final List<Color> colors;

  const MenuItemWidget(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.icon,
      required this.colors,
      this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: size ?? 46.w,
            height: size ?? 46.h,
            padding: Dimensions.kPaddingAllSmall,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: colors.first.withOpacity(.5),
              ),
              gradient: LinearGradient(
                colors: [
                  colors.first.withOpacity(.2),
                  colors.last.withOpacity(.2)
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                transform: const GradientRotation(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.first.withOpacity(.1),
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
              borderRadius: Dimensions.kBorderRadiusAllSmaller,
            ),
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(appColor.gray500, BlendMode.srcIn),
            ),
          ),
          Dimensions.kVerticalSpaceSmaller,
          Text(
            label,
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
