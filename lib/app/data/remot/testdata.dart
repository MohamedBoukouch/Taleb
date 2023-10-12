import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_lik.dart';

class TestData {
  Crud crud;
  TestData(this.crud);

  getData() async {
    var response = await crud.getRequest(linkshowpubli);
    return response;
  }

  // Addcomment(int id_user, int id_publication, String text) async {
  //   var response = await crud.postRequest(linkaddcomment, {
  //     "id_user": id_user,
  //     "id_publication": id_publication,
  //     "text": text,
  //   });
  //   return response;
  // }
}
