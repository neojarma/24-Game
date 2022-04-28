import 'package:card_game/app/global_widgets/medium_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../core/theme/text_theme.dart';
import '../../core/values/assets.dart';
import '../../core/values/colors.dart';
import 'controller.dart';

class SolverPage extends GetView<SolverController> {
  const SolverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 80,
              ),
              Image.asset(miniIcon),
              SizedBox(
                height: Get.height / 13,
              ),
              Text(
                '24 Game Solver',
                textAlign: TextAlign.center,
                style: kTitlePageTextStyle.copyWith(
                  color: kSemiBlackColor,
                ),
              ),
              Text(
                'Enter your numbers below',
                textAlign: TextAlign.center,
                style: kHeading2TextStyle.copyWith(
                  color: kLightGrey,
                ),
              ),
              SizedBox(
                height: Get.height / 13,
              ),
              Obx(
                () => Row(
                  children: chipsCardsOptions(),
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: textFieldBuilder(),
                ),
              ),
              SizedBox(
                height: Get.height / 20,
              ),
              controller.obx(
                (state) => Text(
                  controller.solution.value,
                  style: kHeading2TextStyle.copyWith(
                    color: kGreenColor,
                  ),
                ),
                onLoading: const SpinKitThreeBounce(
                  size: 20,
                  color: Colors.black,
                ),
                onEmpty: const SizedBox.shrink(),
                onError: (str) => Text(
                  controller.error,
                  style: kHeading2TextStyle.copyWith(
                    color: kPinkColor,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 30,
              ),
              MediumCustomButton(
                title: 'Calculate',
                color: kLightGreenColor,
                function: controller.calculate,
                textStyle: kButtonTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> textFieldBuilder() {
    return List.generate(
      (controller.indexOption.value == 0) ? 4 : 6,
      (index) {
        return SizedBox(
          width: Get.width / 10,
          child: TextField(
            controller: controller.textFieldControllers[index],
            maxLength: 2,
            keyboardType: TextInputType.number,
            autofocus: true,
            onTap: () {
              final localController = controller.textFieldControllers[index];
              localController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: localController.text.length,
              );
            },
            decoration: const InputDecoration(
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kLightGreenColor),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> chipsCardsOptions() {
    return List.generate(
      controller.option.length,
      (index) => Row(
        children: [
          ChoiceChip(
            label: Text(
              controller.option[index],
            ),
            selected: controller.indexOption.value == index,
            onSelected: (_) => controller.updateIndex(index),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
