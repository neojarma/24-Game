import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/values/assets.dart';
import '../../global_widgets/operator_widget.dart';

class Operator {
  static List<Widget> firstRowOperator(controller) {
    List<Map<String, dynamic>> result = [
      {
        "icon": FontAwesomeIcons.xmark,
        "function": () => controller.setUserAnswer('*')
      },
      {
        "icon": FontAwesomeIcons.divide,
        "function": () => controller.setUserAnswer('/')
      },
      {
        "icon": FontAwesomeIcons.plus,
        "function": () => controller.setUserAnswer('+')
      },
      {
        "icon": FontAwesomeIcons.minus,
        "function": () => controller.setUserAnswer('-')
      },
    ];
    return result.map(
      (item) {
        if (item['image'] != null) {
          return OperatorsWidget(
            function: item['function'],
            image: item['image'],
          );
        }

        if (item['longPressFunction'] != null) {
          return OperatorsWidget(
            function: item['function'],
            icon: item['icon'],
            onLongPressFunction: item['longPressFunction'],
          );
        }

        return OperatorsWidget(
          function: item['function'],
          icon: item['icon'],
        );
      },
    ).toList();
  }

  static List<Widget> secondRowOperator(controller) {
    List<Map<String, dynamic>> result = [
      {"image": '(', "function": () => controller.setUserAnswer('(')},
      {"image": ')', "function": () => controller.setUserAnswer(')')},
      {
        "icon": FontAwesomeIcons.deleteLeft,
        "function": () => controller.deleteUserAnswer(),
        "longPressFunction": () => controller.reset()
      },
    ];
    return result.map(
      (item) {
        if (item['image'] != null) {
          return OperatorsWidget(
            function: item['function'],
            image: item['image'],
          );
        }

        if (item['longPressFunction'] != null) {
          return OperatorsWidget(
            function: item['function'],
            image: deleteIcon,
            onLongPressFunction: item['longPressFunction'],
          );
        }

        return OperatorsWidget(
          function: item['function'],
          icon: item['icon'],
        );
      },
    ).toList();
  }
}
