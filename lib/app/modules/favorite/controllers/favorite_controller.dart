import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/main.dart';

class FavoriteController extends GetxController {
  //TODO: Implement FavoriteController

  Crud _crud = Crud();
  List<dynamic> FavoriteList = [];

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

  Future SelectFavorit() async {
    var response = await _crud.postRequest(linkselectfavorit, {
      "user_id": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("success");
      FavoriteList.assignAll(response['data']);
      return response['data'];
    } else {
      print("error");
    }
  }
}
