import 'package:shared_preferences/shared_preferences.dart';

Future<String> getThemeFromSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  return sharedPref.getString('theme') ?? 'defaultTheme'; // Provide a default theme
}

Future<void> setThemeInSharedPref(String val) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setString('theme', val);
}

