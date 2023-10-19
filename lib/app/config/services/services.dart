import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taleb/firebase_options.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<MyServices> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
