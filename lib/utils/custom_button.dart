import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double borderWidth;
  final double textPadding;
  final double iconSize;
  final double borderRadius;
  final String label;
  final IconData? icon;
  final Color color;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final bool useGradient;
  final bool circleIcon;
  final bool enabled;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    this.textColor = Colors.white,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.label,
    this.icon,
    this.color = CustomColors.primaryColor,
    this.useGradient = true,
    this.borderColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 8,
    this.circleIcon = true,
    this.iconSize = 0.08,
    this.textPadding = 8,
     this.enabled=true,  this.iconColor=Colors.white,  this.borderWidth=1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startColor = color;
    final endColor = useGradient ? color.withOpacity(0.5) : color;

    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: !useGradient ? Border.all(color: borderColor,width: borderWidth) : null,
            borderRadius: BorderRadius.circular(borderRadius),
            color: enabled?(!useGradient ? color : null):Colors.grey,
            gradient: enabled?(useGradient
                ? LinearGradient(
                    colors: [startColor, endColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                  )
                : null):null),
        height: height,
        width: width,constraints:const BoxConstraints(maxHeight: 45,minHeight: 40),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          onPressed:enabled? onPressed:null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              if (icon != null && circleIcon )
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: iconColor),
                  ),
                  child: Icon(
                    icon,
                    size: iconSize*width,
                    color: iconColor,
                  ),
                ),
              if (icon != null && !circleIcon)
                Icon(
                  icon,
                  size: (iconSize)*width,
                  color: iconColor,
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: textPadding),
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: textColor, fontWeight: fontWeight),
                ),
              ),
            ],
          ),
        ));
  }
}
