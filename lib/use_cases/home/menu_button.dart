
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/custom_colors.dart';
class MenuButton extends StatelessWidget {
  final double width;
  final double iconSize;
  final String label;
  final IconData? icon;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final bool useGradient;
  final bool isMob;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const MenuButton({
    Key? key,
    this.textColor = Colors.white,
    required this.width,
    required this.onPressed,
    required this.label,
    this.icon,
    this.color = CustomColors.red,
    this.useGradient = true,
    this.borderColor = Colors.white,
    this.fontWeight = FontWeight.w500,  this.iconSize=5,  this.isMob=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Sizer(
      builder: (context, orientation, deviceType) {

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,surfaceTintColor: color,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              shadowColor: Colors.transparent),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding:  EdgeInsets.only(right:width*0.04 ),
                  child: Icon(
                    icon,
                    size: (iconSize/70)*width,
                    color: textColor,
                  ),
                ),
              Text(
                label,
                style:isMob? Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: textColor, fontWeight: fontWeight):
                Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: textColor, fontWeight: fontWeight),
              ),

            ],
          ),
        );
      }
    );
  }
}
