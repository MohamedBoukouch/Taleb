import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/main.dart';

import '../../../data/const_link.dart';

class FavoritController extends GetxController {
  //TODO: Implement NotificationController
  Crud _crud = Crud();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  List<dynamic> FavoriteList = [];

  Future SelectFavorit() async {
    var response = await _crud.postRequest(linkselectfavorit, {
      "id_user": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("success");
      // return FavoriteList.assignAll(response['data']);
      return response['data'];
    } else {
      print("error");
    }
  }
}
