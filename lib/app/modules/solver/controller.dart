import 'package:card_game/app/data/provider/api_game_solution.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SolverController extends GetxController with StateMixin {
  var indexOption = 0.obs;
  var inputtedNumbers = [].obs;

  List<String> option = ['4 Cards', '6 Cards'];

  var solution = ''.obs;
  var error = 'Please enter your number';

  late List<TextEditingController> textFieldControllers;

  @override
  void onInit() {
    generateTextControllers();

    change('empty', status: RxStatus.empty());

    super.onInit();
  }

  void calculate() async {
    int length = (indexOption.value == 0) ? 4 : 6;
    // check if there is a null value
    for (var index = 0; index < length; index++) {
      var tempController = textFieldControllers[index];
      if (tempController.text.isEmpty) {
        change('error', status: RxStatus.error());
        solution.value = 'Please enter your number';
        return;
      }
    }

    FocusManager.instance.primaryFocus?.unfocus();
    change('loading', status: RxStatus.loading());

    List<int> numbers = [];
    for (var index = 0; index < length; index++) {
      var tempController = textFieldControllers[index];
      numbers.add(int.parse(tempController.text));
    }

    final possibleSolution = await getSolution(numbers);
    solution.value = 'Solution : $possibleSolution';
    change('success', status: RxStatus.success());

    reset();
  }

  void reset() {
    for (var controller in textFieldControllers) {
      controller.clear();
    }
  }

  Future<String> getSolution(List<int> numbers) async {
    return await SolutionProvider.getSolution(numbers).then((cardModel) {
      if (!cardModel.solution) return 'No Solution';

      return cardModel.equation;
    }).catchError((err) => 'No Solution');
  }

  void generateTextControllers() {
    textFieldControllers = List.generate(6, (index) => TextEditingController());
  }

  void updateIndex(int index) {
    indexOption.value = index;
  }

  void setNumbers(String number) => inputtedNumbers.add(int.tryParse(number));
}
