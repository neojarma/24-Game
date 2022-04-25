import 'package:flutter/material.dart';
import '../data/models/operator_model.dart';

class OperatorBuilder extends StatelessWidget {
  const OperatorBuilder({
    Key? key,
    required this.controller,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Operator.firstRowOperator(controller),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Operator.secondRowOperator(controller),
        )
      ],
    );
  }
}
