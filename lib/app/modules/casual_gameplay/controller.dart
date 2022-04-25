// ignore_for_file: prefer_final_fields

import 'package:card_game/app/core/values/strings.dart';
import 'package:card_game/app/data/enums/game_enums.dart';
import 'package:card_game/app/data/models/solution_model.dart';
import 'package:card_game/app/data/provider/api_card_provider.dart';
import 'package:card_game/app/data/provider/api_game_solution.dart';
import 'package:card_game/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:get/get.dart';
import 'package:function_tree/function_tree.dart';

class GameplayController extends GetxController with StateMixin {
  late final int _gridCount;
  late final SolutionModel _deck;
  // get previous argument from previous page
  final GameMode _prevPageArgs = Get.arguments;
  late final String titleGameMode;

  // keep track user input
  RxList<String> _userAnswer = [''].obs;
  // keep track user selected card
  RxList<String> _selectedCardId = [''].obs;

  // keep track timer in milliSecond
  RxInt _timeValue = 0.obs;

  RxString _userAnswerStatus = gameStart.obs;
  final int _targetNumber = 24;

  final _controllerTime = StopWatchTimer();
  // ignore: prefer_typing_uninitialized_variables
  late final timerStream;

  @override
  void onInit() {
    titleGameMode =
        (_prevPageArgs == GameMode.fourCardMode) ? fourCardMode : sixCardMode;

    _createDeckForGame();

    super.onInit();
  }

  String get userAnswerStatus => _userAnswerStatus.value;

  SolutionModel get deck => _deck;

  int get gridCount => _gridCount;

  set setTime(value) => _timeValue.value = value;

  Future<bool> handleOnWillPop() async {
    // pause the timer
    _controllerTime.onExecute.add(StopWatchExecute.stop);

    Get.defaultDialog<bool>(
      title: exitDialogTitle,
      middleText: exitConfirmation,
      textConfirm: dialogConfirm,
      confirmTextColor: Colors.white,
      textCancel: dialogCancel,
      onConfirm: () => Get.offNamedUntil(
        Routes.GAME_MODE,
        ModalRoute.withName(Routes.DASHBOARD),
      ),
      // continue the timer
      onCancel: () => _controllerTime.onExecute.add(StopWatchExecute.start),
    );
    return false;
  }

  String getUserAnswer() => _userAnswer.join('');

  void addSelectedCard(String value, bool valid) {
    // if it's true, something happen in setUserAnswer() method
    // user click more than 1 card in a row
    if (valid) return;

    _selectedCardId.add(value);
  }

  void deleteUserAnswer() {
    // it does not make sense to delete nothing
    if (_userAnswer.length == 1) return;

    String lastUserAnswerValue = _userAnswer[_userAnswer.length - 1];

    int? isNumber = int.tryParse(lastUserAnswerValue);

    // if the last user value not a number
    if (isNumber == null) {
      // easily delete the array
      _userAnswer.removeLast();
      return;
    }

    // delete the stats of array cards
    String cardId = _selectedCardId[_selectedCardId.length - 1];
    _changeCardVisibilityById(cardId, true);
    _selectedCardId.removeLast();
    _userAnswer.removeLast();
  }

  void handleUserAnswer() async {
    // user must input valid value, and use all the cards
    if (_prevPageArgs == GameMode.fourCardMode) {
      if (_userAnswer.length == 1 || _selectedCardId.length != 5) {
        _userAnswerStatus.value = uncompletedOperations;
        return;
      }
    } else {
      if (_userAnswer.length == 1 || _selectedCardId.length != 7) {
        _userAnswerStatus.value = uncompletedOperations;
        return;
      }
    }

    // is valid equation?
    bool answer = _interprestAnswer();

    if (answer) {
      _controllerTime.onExecute.add(StopWatchExecute.stop);
      var time = StopWatchTimer.getDisplayTime(
        _timeValue.value,
        hours: false,
        minute: (_timeValue.value > 60000 ? true : false),
        second: true,
        milliSecond: false,
      );
      String timeFinish =
          (_timeValue.value < 60000) ? '$time seconds' : '$time minutes';
      Get.defaultDialog(
        title: dialogWhenCorrect,
        middleText: 'Finish time : $timeFinish\n\nPlay Again?',
        textConfirm: dialogConfirm,
        textCancel: dialogCancel,
        confirmTextColor: Colors.white,
        onConfirm: _playAgain,
        onCancel: () => Get.offNamedUntil(
          Routes.GAME_MODE,
          ModalRoute.withName(Routes.GAME_MODE),
        ),
        // prevent dialog being pop
        onWillPop: () async => false,
      );

      // update correct answer status
      _userAnswerStatus.value = correctAnswer;
      reset();
      return;
    }

    reset();
    _userAnswerStatus.value = wrongAnswer;
  }

  void _playAgain() {
    Get.offNamedUntil(
      Routes.CASUAL_GAMEPLAY,
      ModalRoute.withName(Routes.CASUAL_GAME_MODE),
      arguments: _prevPageArgs,
    );
  }

  void _changeCardVisibilityById(String cardId, bool condition) {
    for (var card in _deck.cardModel!.listOfCards) {
      if (card['id'] == cardId) {
        card['visible'] = condition;
        refresh();
        return;
      }
    }
  }

  // this method used for set user answer from input user
  // return from this method used to set the visibility of each card
  bool setUserAnswer(String input) {
    int lastValueofArray = _userAnswer.length - 1;

    // if (lastValueofArray == -1) return true;

    // try to parse the last number in list
    // if its null, then is not a number
    int? latesValue = int.tryParse(_userAnswer[lastValueofArray]);
    // user input value
    int? userInput = int.tryParse(input);

    // condition if the latest value is a number,
    // and the new user input is not a number
    // basically it's just prevent user from inputting number without operator
    if (latesValue != null && userInput == null) {
      _userAnswer.add(input);
      refresh();
      // change the visibility of the card to false
      return false;
    }

    // prevent user from inputting the same operator
    RegExp regexOperator = RegExp('[*/+-]');
    String latestValueBeforeParsing = _userAnswer[lastValueofArray];
    if (regexOperator.hasMatch(latestValueBeforeParsing) &&
        regexOperator.hasMatch(input)) return true;

    // if the latest value is not a number, we can add the operation
    if (latesValue == null) {
      _userAnswer.add(input);
      refresh();
      // change the visibility of the card to false
      return false;
    }

    return true;
  }

  bool _interprestAnswer() {
    bool isInputValid = false;
    // try to parse user answer, if there is an exception
    // we can throw it away and return false
    try {
      isInputValid = _userAnswer.join().interpret() == _targetNumber;
      return isInputValid;
    } catch (e) {
      _userAnswerStatus.value = wrongAnswer;
    }
    return isInputValid;
  }

  void reset() {
    // change all the card to visible
    for (var card in _deck.cardModel!.listOfCards) {
      card['visible'] = true;
    }

    // reset the user answer list
    _userAnswer.value = [''];

    // reset user answer status result
    _userAnswerStatus.value = '';

    // reset clickedCardId list
    _selectedCardId.value = [''];
    refresh();
  }

  void _initializeTimeController() {
    // set stream
    timerStream = _controllerTime.rawTime;

    // start timer
    _controllerTime.onExecute.add(StopWatchExecute.start);
  }

  void _createDeckForGame() {
    if (_prevPageArgs == GameMode.fourCardMode) {
      _gridCount = 2;
      // request deck and draw random 4 card
      _requestDeck(4);
      return;
    }

    _gridCount = 3;
    // request deck and draw random 4 card
    _requestDeck(6);
    return;
  }

  void _requestDeck(int drawCard) {
    CardProvider.getDeck(drawCard).then((cardModel) async {
      // to call solution method, we need a list of int
      // we can get list of number from card model value
      final List<int> numbers = [];
      for (var card in cardModel.listOfCards) {
        numbers.add(card['value']);
      }

      // after we get the list of int, we can call solution method
      final deck = await SolutionProvider.getSolution(numbers);

      // we assign new result model with card model
      deck.cardModel = cardModel;

      // guaranted that the question has a solution
      if (deck.solution == false) {
        _requestDeck(drawCard);
        change('loading', status: RxStatus.loading());
        return;
      }

      _deck = deck;

      // change status to success
      change('OK', status: RxStatus.success());
      _initializeTimeController();
      return;
    });
  }
}
