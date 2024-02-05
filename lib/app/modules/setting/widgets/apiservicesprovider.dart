import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  static final String BASE_URL = "https://www.ibm.com/downloads/cas/GJ5QVQ7X";

  static Future<String> loadPDF() async {
    var response = await http.get(Uri.parse(BASE_URL)); // Convert String to Uri

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    await file.writeAsBytes(response.bodyBytes, flush: true); // Use await here
    return file.path;
  }
}
