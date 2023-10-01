import 'package:taleb/app/data/statusRequest.dart';

handlingData(response) {
  if (response['status']=='error' ) {
    return  StatusRequest.serverfailure;
  } else {
    return StatusRequest.success;
  }
}
