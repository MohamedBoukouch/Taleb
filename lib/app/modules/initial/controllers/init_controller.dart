import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/main.dart';

class InitController extends GetxController {
  //TODO: Implement InitController
  Crud _crud = Crud();

  List<dynamic> List_Active_Notification = [];
  final count = 0.obs;
  @override
  void onInit() {
    List_Active_Notification;
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
}
