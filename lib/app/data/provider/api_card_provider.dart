import 'dart:math';

import 'package:get/get.dart';
import '../models/cards_model.dart';

abstract class CardProvider {
  // we need to create [GetConnect()] instance to access get() method
  static final _instance = GetConnect();

  static Future<CardsModel> getDeck(int drawCard) async {
    late List<Map<String, dynamic>> listOfCards = [];
    late int remainingCards;

    // try to parsing the data from API
    final String deckId =
        await _requestDeck().then((value) => value.body['deck_id'].toString());

    final List<dynamic> cards = await _drawCards(deckId, drawCard).then(
      (value) {
        remainingCards = value.body['remaining'];
        return value.body['cards'];
      },
    );

    // map the list of cards that we get from API,
    cards.map((card) {
      int value;

      // change the value, if it's King, Queen, Jack we change the value to 10
      if (card['value'] == 'KING' ||
          card['value'] == 'QUEEN' ||
          card['value'] == 'JACK') {
        value = 10;

        // if the value is ACE we change the value to 11
      } else if (card['value'] == 'ACE') {
        value = 11;

        // assign the local value variable with value from API response
      } else {
        value = int.parse(card['value']);
      }

      return {
        'image': card['image'],
        'value': value,
        'visible': true,
        'id': _generateRandomId(),
      };
      // add mapped card to listofcard list
    }).forEach(
      (element) {
        listOfCards.add(element);
      },
    );

    // return result
    return CardsModel(
      deckId: deckId,
      remainingCards: remainingCards,
      listOfCards: listOfCards,
    );
  }

  // random id for every single card
  static String _generateRandomId() => (Random().nextInt(900) + 100).toString();

  // Response : {"success": true, "deck_id": "zygd35i5cz3d", "remaining": 52, "shuffled": true}
  static Future<Response> _requestDeck() => _instance
      .get('https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1');

  // Response : {"success": true, "deck_id": "66mcp0vww5t2", "cards": [{"code": "6C", "image": "https://deckofcardsapi.com/static/img/6C.png", "images": {"svg": "https://deckofcardsapi.com/static/img/6C.svg", "png": "https://deckofcardsapi.com/static/img/6C.png"}, "value": "6", "suit": "CLUBS"}], "remaining": 50}
  static Future<Response> _drawCards(String deckId, int count) => _instance
      .get('https://deckofcardsapi.com/api/deck/$deckId/draw/?count=$count');
}
