class CardsModel {
  String deckId;
  int remainingCards;
  List<Map<String, dynamic>> listOfCards = [];

  CardsModel(
      {required this.deckId,
      required this.remainingCards,
      required this.listOfCards});
}
