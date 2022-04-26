import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_game/app/core/values/assets.dart';
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
                    // prevent user from input same card
                    if (controller.selectedCardId.contains(card['id'])) {
                      return;
                    }

                    // change the visibility of the card to false
                    card['visible'] =
                        controller.setUserAnswer(card['value'].toString());

                    // add clicked card id to list, to keep track remaining card
                    controller.addSelectedCard(card['id'], card['visible']);
                  },
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut.flipped,
                    transitionBuilder: __transitionBuilder,
                    layoutBuilder: (widget, list) =>
                        Stack(children: [widget!, ...list]),
                    duration: const Duration(milliseconds: 500),
                    child: card['visible'] ? frontCard(card) : backCard(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (const ValueKey(true) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget backCard() {
    return Center(
      key: const ValueKey('Front'),
      child: Container(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.white,
            // offset: Offset(-1.5, 1.5),
            blurRadius: 1.5,
            spreadRadius: 2,
          )
        ], borderRadius: BorderRadius.circular(5)),
        child: Image.asset(backOfCard),
      ),
    );
  }

  Widget frontCard(Map<String, dynamic> card) {
    return Center(
      key: const ValueKey('Back'),
      child: CachedNetworkImage(
        imageUrl: card['image'],
        placeholder: (context, string) => const SpinKitPulse(
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
