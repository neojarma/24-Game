import 'package:card_game/app/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/text_theme.dart';
import '../../core/values/assets.dart';
import '../../global_widgets/large_custom_button.dart';
import 'controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logoWithText),
              SizedBox(
                height: Get.height / 7,
              ),
              LargeCustomButton(
                color: kSemiBlackColor,
                title: 'Play Game',
                textStyle: kButtonTextStyle,
                function: controller.handlePage,
              ),
              const SizedBox(
                height: 24.0,
              ),
              LargeCustomButton(
                color: Colors.white,
                borderColor: kSemiBlackColor,
                title: 'How To Play',
                textStyle: kButtonTextStyle.copyWith(color: kSemiBlackColor),
                function: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
