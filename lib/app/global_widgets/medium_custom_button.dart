import 'package:flutter/material.dart';

class MediumCustomButton extends StatelessWidget {
  const MediumCustomButton(
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
        width: 251,
        height: 50,
        child: Center(
          child: Text(
            title,
            style: textStyle,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: color,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 3)
              : null,
        ),
      ),
    );
  }
}
