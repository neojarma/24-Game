// ignore_for_file: prefer_final_fields

import 'package:card_game/app/data/models/online_battle.dart';
import 'package:card_game/app/data/provider/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../core/values/strings.dart';
import '../../routes/pages.dart';

class OnlineGameplayController extends GetxController with StateMixin {
  final Map<String, dynamic> prevArgs = Get.arguments;
  late final OnlineBattle onlineBattle;

  late final String roomId;
  late final String opponentName;
  late final String currentPlayer;

  final int gridCount = 2;

  late final List<Map<String, dynamic>> cards = [];

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

  get userAnswerStatus => _userAnswerStatus.value;

  set setTime(int setTime) => _timeValue.value = setTime;

  @override
  void onInit() {
    assignValueFromPrevArgs();

    fetchData();

    // _createDeckForGame();

    super.onInit();
  }

  void redirectToResultScreen(String winner) {
    _controllerTime.onExecute.add(StopWatchExecute.stop);
    var time = StopWatchTimer.getDisplayTime(
      _timeValue.value,
      hours: false,
      minute: true,
      second: true,
      milliSecond: false,
    );

    final isWinning = (winner == opponentName) ? false : true;

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => Get.offNamedUntil(
        Routes.RESULT,
        ModalRoute.withName(Routes.GAME_MODE),
        arguments: {'is_winning': isWinning, 'finish_time': time},
      ),
    );
  }

  void assignValueFromPrevArgs() {
    roomId = prevArgs['room_id'];
    opponentName = prevArgs['opponent'];
    currentPlayer = prevArgs['current_player'];
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

  void _changeCardVisibilityById(String cardId, bool condition) {
    for (var card in onlineBattle.cards) {
      if (card['id'] == cardId) {
        card['visible'] = condition;
        refresh();
        return;
      }
    }
  }

  String getUserAnswer() => _userAnswer.join('');

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

  void handleUserAnswer() async {
    // user must input valid value, and use all the cards
    if (_userAnswer.length == 1 || _selectedCardId.length != 5) {
      _userAnswerStatus.value = uncompletedOperations;
      return;
    }

    // is valid equation?
    bool answer = _interprestAnswer();

    if (answer) {
      FirebaseProvider.gameEnded(roomId, currentPlayer);

      reset();

      return;
    }

    reset();
    _userAnswerStatus.value = wrongAnswer;
  }

  void reset() {
    // change all the card to visible
    for (var card in onlineBattle.cards) {
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

  void addSelectedCard(String value, bool valid) {
    // if it's true, something happen in setUserAnswer() method
    // user click more than 1 card in a row
    if (valid) return;

    _selectedCardId.add(value);
  }

  bool setUserAnswer(String input) {
    int lastValueofArray = _userAnswer.length - 1;

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

  void _initializeTimeController() {
    // set stream
    timerStream = _controllerTime.rawTime;

    // start timer
    _controllerTime.onExecute.add(StopWatchExecute.start);
  }

  // fetch data from firebase
  void fetchData() async {
    final data = await FirebaseProvider.fetchLobby(roomId);
    final json = data.data();

    json!['cards'].forEach((card) => cards.add(card));

    onlineBattle = OnlineBattle.fromJson(json, cards);

    change('OK', status: RxStatus.success());
    _initializeTimeController();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> gameStream() {
    return FirebaseProvider.gameStream(roomId);
  }

  Future<bool> handleOnWillPop() async {
    Get.defaultDialog<bool>(
      title: exitDialogTitle,
      middleText: exitConfirmation,
      textConfirm: dialogConfirm,
      textCancel: dialogCancel,
      onConfirm: () => FirebaseProvider.gameEnded(roomId, opponentName),
      // continue the timer
      onCancel: () => _controllerTime.onExecute.add(StopWatchExecute.start),
    );
    return false;
  }
}
