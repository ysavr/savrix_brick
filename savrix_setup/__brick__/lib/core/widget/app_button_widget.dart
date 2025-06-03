import 'package:flutter/material.dart';

import '../../utils/colors/hex_colors.dart';
import '../../utils/style/text_style.dart';

class AppButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final double? width;
  final double? height;
  final bool isActive;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? horizontalPadding;
  final double radius;

  const AppButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isActive = true,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.horizontalPadding,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isActive && !isLoading) onTap();
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: (isActive && !isLoading)
              ? backgroundColor ?? HexColor(appColor049CFB)
              : HexColor(appColor6F788B),
          borderRadius: BorderRadius.circular(radius),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              HexColor('FFFFF'),
              HexColor('FFFFF'),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppTextStyle.openSans16().copyWith(
                    color: (isActive && !isLoading)
                        ? textColor ?? Colors.white
                        : HexColor(appColorF7FAFD),
                    fontWeight: FontWeight.w600),
              ),
              isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: HexColor(neutral950),)),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
