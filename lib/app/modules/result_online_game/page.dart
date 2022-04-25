import 'package:card_game/app/modules/result_online_game/widget/builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class ResultPage extends GetView<ResultController> {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResultBuilder(),
    );
  }
}
