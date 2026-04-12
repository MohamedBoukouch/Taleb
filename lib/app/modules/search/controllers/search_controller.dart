import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController
  final Crud _crud = Crud();

  final count = 0.obs;

  void increment() => count.value++;
}
