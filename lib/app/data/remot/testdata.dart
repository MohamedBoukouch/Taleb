import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_lik.dart';

class TestData {
  Crud crud;
  TestData(this.crud);

  getData() async {
    var response = await crud.postRequest(linkshowpubli, {});
    return response.fold((left) => left, (right) => right);
  }
}
