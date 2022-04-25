import 'package:card_game/app/data/models/solution_model.dart';
import 'package:get/get.dart';

abstract class SolutionProvider {
  static final _instance = GetConnect();

  static Future<SolutionModel> getSolution(List<int> numbers) {
    final filteredList = numbers
        .toString()
        .removeAllWhitespace
        // only allow numbers and [,]
        .replaceAll(RegExp('[^0-9,]'), '');

    return _instance
        // Response : {"solution":true,"equation":"(1+2)*((3+4)+(6-5))"}
        .get('https://24-game-api.vercel.app/game?numbers=$filteredList')
        .then(
          (value) => SolutionModel(
            solution: value.body['solution'],
            equation: value.body['equation'] ?? '',
          ),
        );
  }
}
