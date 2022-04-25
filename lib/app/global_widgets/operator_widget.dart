import 'package:card_game/app/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OperatorsWidget extends StatelessWidget {
  const OperatorsWidget(
      {Key? key,
      required this.function,
      this.icon,
      this.image,
      this.onLongPressFunction})
      : super(key: key);

  final VoidCallback function;
  final IconData? icon;
  final String? image;
  final VoidCallback? onLongPressFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPressFunction,
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: (onLongPressFunction != null) ? kSoftBlueColor : kGreyColor,
          borderRadius: BorderRadius.circular(5),
          border: (onLongPressFunction != null)
              ? Border.all(color: kGreyColor, width: 3)
              : null,
        ),
        child: (onLongPressFunction != null)
            ? SizedBox(
                height: 21,
                width: 69,
                child: Image.asset(image!),
              )
            : (image != null)
                ? SizedBox(
                    width: 18.7,
                    height: 24,
                    child: Text(
                      image!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : FaIcon(
                    icon,
                    color: Colors.white,
                  ),
      ),
    );
  }
}
