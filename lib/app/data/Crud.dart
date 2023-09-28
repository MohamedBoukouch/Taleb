import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:taleb/app/config/function/checkInternet.dart';
import 'dart:convert';

import 'package:taleb/app/data/statusRequest.dart';

class Crud {
  // getRequest(String url) async {
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var responsebody = jsonDecode(response.body);
  //       return responsebody;
  //     } else {
  //       print("Error ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error Catch $e");
  //   }
  // }

  // postRequest(String url,Map data) async {
  //   try {
  //     var response = await http.post(Uri.parse(url),body:data);
  //     if (response.statusCode == 200) {
  //       var responsebody = jsonDecode(response.body);
  //       return responsebody;
  //     } else {
  //       print("Error ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error Catch $e");
  //   }
  // }

  Future<Either<StatusRequest, Map>> postRequest(String url, Map data) async {
    try {
      if ( chekInternet()==true) {
        var response = await http.post(Uri.parse(url), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          print(responsebody);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
