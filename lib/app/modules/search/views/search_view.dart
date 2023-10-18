import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController _controller = Get.find<HomeController>();

  final List<String> suggestions = [];

  @override
  void initState() {
    super.initState();
    loadSuggestions();
  }

  void loadSuggestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedSuggestions = prefs.getStringList('suggestions');

    if (savedSuggestions != null) {
      setState(() {
        suggestions.addAll(savedSuggestions);
      });
    }
  }

  void saveSuggestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('suggestions', suggestions);
  }

  void _onSuggestionSelected(String suggestion) {
    _searchController.text = suggestion;
    // Perform any action when a suggestion is selected here.
  }

  bool isSearchEmpty = true;

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 1,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(69, 158, 158, 158),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchController,
                  onChanged: (value) {
                    handleSearch(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          suggestions.add(_searchController.text);
                          saveSuggestions();
                        }
                      },
                      icon: Icon(Icons.search),
                    ),
                    prefixIcon: isSearchEmpty
                        ? null
                        : IconButton(
                            onPressed: cancelSearch,
                            icon: Icon(Icons.close),
                          ),
                    hintText: 'Search...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromARGB(190, 255, 153, 0),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color.fromARGB(10, 158, 158, 158),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  return suggestions.where(
                    (suggestion) => suggestion
                        .toLowerCase()
                        .contains(pattern.toLowerCase()),
                  );
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete"),
                              content:
                                  Text("Do you want to delete this search?"),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                                TextButton(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      suggestions.remove(suggestion);
                                      saveSuggestions();
                                    });
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.close),
                    ),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _onSuggestionSelected(suggestion.toString());
                },
              ),
            ),
            isSearchEmpty
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(4.0),
                          child: Image.network(imageList[index]),
                        );
                      },
                    ),
                  )
                : Text("Search results go here"),
          ],
        ),
      ),
    );
  }

  List<String> imageList = [
    "https://th.bing.com/th/id/R.7ca3681c4fb0c8adcc1ab9bdd4572655?rik=2Gru%2fWwVxbLLdA&pid=ImgRaw&r=0",
    "https://th.bing.com/th/id/R.7ca3681c4fb0c8adcc1ab9bdd4572655?rik=2Gru%2fWwVxbLLdA&pid=ImgRaw&r=0",
    "https://th.bing.com/th/id/R.7ca3681c4fb0c8adcc1ab9bdd4572655?rik=2Gru%2fWwVxbLLdA&pid=ImgRaw&r=0"
    // Your image URLs here
  ];

  void handleSearch(String value) {
    setState(() {
      isSearchEmpty = value.isEmpty;
    });
  }

  void cancelSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
    _searchController.clear();
    setState(() {
      isSearchEmpty = true;
    });
  }
}
