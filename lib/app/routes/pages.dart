import 'package:card_game/app/modules/dashboard/binding.dart';
import 'package:card_game/app/modules/dashboard/page.dart';
import 'package:card_game/app/modules/casual_game_mode/page.dart';
import 'package:card_game/app/modules/casual_gameplay/binding.dart';
import 'package:card_game/app/modules/casual_gameplay/page.dart';
import 'package:card_game/app/modules/game_mode/page.dart';
import 'package:card_game/app/modules/lobby/binding.dart';
import 'package:card_game/app/modules/lobby/page.dart';
import 'package:card_game/app/modules/online_gameplay/binding.dart';
import 'package:card_game/app/modules/online_gameplay/page.dart';
import 'package:card_game/app/modules/online_mode/binding.dart';
import 'package:card_game/app/modules/online_mode/page.dart';
import 'package:card_game/app/modules/rematch/binding.dart';
import 'package:card_game/app/modules/rematch/page.dart';
import 'package:card_game/app/modules/result_online_game/binding.dart';
import 'package:card_game/app/modules/result_online_game/page.dart';
import 'package:card_game/app/modules/waiting/binding.dart';
import 'package:get/get.dart';

import '../modules/waiting/page.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
      children: [
        GetPage(
          transition: Transition.cupertino,
          name: Routes.GAME_MODE,
          page: () => const GameModePage(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: Routes.CASUAL_GAME_MODE,
          page: () => const CasualGameModePage(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: Routes.CASUAL_GAMEPLAY,
          page: () => const GameplayPage(),
          binding: GameplayBinding(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: Routes.ONLINE,
          page: () => const OnlineModePage(),
          binding: OnlineModeBinding(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: Routes.LOBBY,
          page: () => const LobbyPage(),
          binding: LobbyBinding(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: Routes.WAITING,
          page: () => const WaitingPage(),
          binding: WaitingBinding(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: Routes.ONLINE_GAMEPLAY,
          page: () => const OnlineGameplayPage(),
          binding: OnlineGameplayBinding(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: Routes.RESULT,
          page: () => const ResultPage(),
          binding: ResultBinding(),
        ),
        GetPage(
          name: Routes.REMATCH,
          page: () => const RematchPage(),
          binding: RematchBinding(),
        )
      ],
    )
  ];
}
