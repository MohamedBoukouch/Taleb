import 'package:get/get.dart';

class FavoriController extends GetxController {
  Map isfavorite = {};

  setFavorit(id, val) {
    isfavorite[id] = val;
    update();
  }
}
