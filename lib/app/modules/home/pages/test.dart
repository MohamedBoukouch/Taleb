import 'package:flutter/material.dart';

class StringToArrayExample extends StatefulWidget {
  @override
  _StringToArrayExampleState createState() => _StringToArrayExampleState();
}

class _StringToArrayExampleState extends State<StringToArrayExample> {
  String inputString = "med";
  List<String> charArray = [];
  // int listSize = charArray.length;
  void splitString() {
    charArray = inputString.split('');
    int listSize = charArray.length;
    print(listSize);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      splitString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Original String:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              inputString,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                print(charArray);
                splitString();
              },
              child: Text(
                'Array of Characters:',
                style: TextStyle(fontSize: 18),
              ),
            ),

            // prin(),
            // Text(
            //   charArray.join(''), // Join characters with a comma and space
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}
