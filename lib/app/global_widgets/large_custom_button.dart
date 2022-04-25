import 'package:flutter/material.dart';

class LargeCustomButton extends StatelessWidget {
  const LargeCustomButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.function,
      required this.textStyle,
      this.borderColor})
      : super(key: key);

  final String title;
  final Color color;
  final VoidCallback function;
  final TextStyle textStyle;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 63,
        child: Center(
          child: Text(
            title,
            style: textStyle,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 3)
              : null,
        ),
      ),
    );
  }
}
