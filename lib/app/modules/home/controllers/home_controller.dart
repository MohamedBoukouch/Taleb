import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_lik.dart';
import 'package:taleb/app/data/remot/testdata.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  Crud _crud = Crud();
  TestData testData = TestData(Get.find());

  List data = [];
  // late StatusRequest statusRequest;

  // getData() async {
  //   // statusRequest = StatusRequest.loading;
  //   var response = await testData.getData();
  // statusRequest = handlingData(response);
  //   // if (StatusRequest.success == statusRequest) {
  //     data.addAll(response);
  //   // }
  //   update();
  //   @override
  //   onInit() {
  //     getData();
  //     super.onInit();
  //   }
  // }

  final count = 0.obs;
  @override
  void onInit() {
    // Showpub();
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

  Future Showpub() async {
    // statusRequest = StatusRequest.loading;
    var response = await testData.getData();
    if (response['status'] == "success") {
      print("success");
      return response['data'];
    } else {
      print("error");
    }
    // }
    // if (response['status'] == "success") {
    //   data.addAll(response['data']);
    //   print(response['status']);
    //   print(data);
    // } else {
    //   print("error");
    // }
  }
}
