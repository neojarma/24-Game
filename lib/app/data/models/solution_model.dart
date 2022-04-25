import 'package:card_game/app/data/models/cards_model.dart';

class SolutionModel {
  final bool solution;
  final String equation;
  CardsModel? cardModel;

  SolutionModel(
      {required this.solution, required this.equation, this.cardModel});
}
