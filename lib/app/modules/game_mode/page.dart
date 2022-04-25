import 'package:card_game/app/core/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/text_theme.dart';
import '../../core/values/colors.dart';
import '../../global_widgets/large_custom_button.dart';
import '../../routes/pages.dart';

class GameModePage extends StatelessWidget {
  const GameModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(miniIcon),
              SizedBox(
                height: Get.height / 8,
              ),
              Text(
                'Select Mode',
                textAlign: TextAlign.center,
                style: kTitlePageTextStyle.copyWith(color: kSemiBlackColor),
              ),
              SizedBox(
                height: Get.height / 12,
              ),
              LargeCustomButton(
                color: kLightGreenColor,
                title: 'Casual Mode',
                textStyle: kButtonTextStyle,
                function: () => Get.toNamed(Routes.CASUAL_GAME_MODE),
              ),
              const SizedBox(
                height: 24.0,
              ),
              LargeCustomButton(
                color: kPinkColor,
                title: 'Battle With Friend',
                textStyle: kButtonTextStyle,
                function: () => Get.toNamed(Routes.ONLINE),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
