import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:taleb/app/modules/setting/widgets/apiservicesprovider.dart';
import 'package:taleb/app/modules/setting/widgets/pdf_form.dart';

class ConcoureContent extends StatefulWidget {
  @override
  _ConcoureContentState createState() => _ConcoureContentState();
}

class _ConcoureContentState extends State<ConcoureContent> {
  String? localPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiServiceProvider.loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "concores",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        // margi:n: EdgeInsets.all(10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 1),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return PdfForm();
            }),
      ),
    );
  }
}
