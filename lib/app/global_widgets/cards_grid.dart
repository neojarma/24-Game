import 'package:card_game/app/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardsGrid extends StatelessWidget {
  const CardsGrid(
      {Key? key,
      required this.controller,
      required this.cards,
      required this.gridCount})
      : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final List<Map<String, dynamic>> cards;

  /// 2 for 4 cards, and 3 for 6 cards
  final int gridCount;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: (gridCount == 2)
            ? const EdgeInsets.fromLTRB(10, 15, 10, 0)
            : const EdgeInsets.only(top: 25, right: 10, left: 10),
        decoration: BoxDecoration(
          color: kSemiBlackColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          childAspectRatio: gridCount == 2 ? 1 : 2 / 3,
          crossAxisCount: gridCount,
          crossAxisSpacing: gridCount == 2 ? 0 : 13,
          mainAxisSpacing: 18,
          children: cards
              .map<GestureDetector>(
                (card) => GestureDetector(
                  onTap: () {
                    // change the visibility of the card to false
                    card['visible'] =
                        controller.setUserAnswer(card['value'].toString());

                    // add clicked card id to list, to keep track remaining card
                    controller.addSelectedCard(card['id'], card['visible']);
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 170),
                    opacity: (card['visible'] == true) ? 1 : 0,
                    child: Image.network(
                      card['image'],
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SpinKitPulse(
                          color: Colors.white,
                          size: 30,
                        );
                      },
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
