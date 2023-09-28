import 'package:get/get.dart';
import 'package:taleb/app/config/function/handlingData.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_lik.dart';
import 'package:taleb/app/data/remot/testdata.dart';
import 'package:taleb/app/data/statusRequest.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  // Crud _crud = Crud();
  TestData testData = TestData(Get.find());

  List data = [];
  late StatusRequest statusRequest=StatusRequest.success ;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await testData.getData();
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      data.addAll(response['data']);
    }
    update();
    @override
    onInit() {
      getData();
      super.onInit();
    }
  }

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}
