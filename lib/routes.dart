import 'package:get/get.dart';

import 'core/constant/app_routes.dart';
import 'view/screens/directory_screens.dart';
import 'view/screens/home.dart';
import 'view/screens/one_game.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: AppRoutes.home, page: () => const Home()),
  GetPage(
    name: AppRoutes.directoryScreens,
    page: () => const DirectoryScreens(),
    arguments: String,
  ),
  GetPage(name: AppRoutes.oneGame, page: () => const OneGame()),
];
