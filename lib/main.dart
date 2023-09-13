import 'package:flutter/material.dart';
import 'package:taleb/app/data/theme.dart';
import 'package:taleb/app/modules/home.dart';
import 'package:taleb/app/services/sharedPref.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData theme = appThemeLight;
  @override
  void initState() {
    super.initState();
    updateThemeFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: MyHomePage(title: 'Home', changeTheme: setTheme),
    );
  }

  setTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      setState(() {
        theme = appThemeDark;
      });
    } else {
      setState(() {
        theme = appThemeLight;
      });
    }
  }

  void updateThemeFromSharedPref() async {
    String themeText = await getThemeFromSharedPref();
    if (themeText == 'light') {
      setTheme(Brightness.light);
    } else {
      setTheme(Brightness.dark);
    }
  }
}
