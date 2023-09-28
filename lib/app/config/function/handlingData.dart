import 'package:taleb/app/data/statusRequest.dart';

handlingData(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
