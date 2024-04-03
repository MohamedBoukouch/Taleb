import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';
import 'package:taleb/app/modules/search/widgets/ZoomSuggestion.dart';
import 'package:taleb/app/modules/search/widgets/suggestion_form.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  // final HomeController _controller = Get.find<HomeController>();
  final HomeController _controller = Get.put(HomeController());

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
  bool isSearching = false;
  String vile = "Agadir";
  List lisdata = [];

  checksearch(val) {
    if (val == "") {
      isSearching = false;
    }
  }

  onsearchitem() {
    isSearching = true;
  }

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
                    checksearch(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (_searchController.text.isNotEmpty) {
                          if (suggestions.contains(_searchController.text)) {
                          } else {
                            suggestions.add(_searchController.text);
                            saveSuggestions();
                          }

                          onsearchitem();
                          try {
                            await _controller.Search(_searchController.text);
                            setState(() {});
                          } catch (e) {
                            print("ddd");
                          }
                          _searchController.clear();
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
            isSearching == false
                ? Expanded(
                    child: FutureBuilder(
                      future: _controller.Showpub("bac"),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SpinKitCircle(
                              color: Color.fromARGB(255, 246, 154, 7),
                              size: 60,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Image.asset(
                              Appimages.error,
                              width: AppConstant.screenWidth * .8,
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: Center(child: Text("No data available")),
                          );
                        } else {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 1, bottom: 1),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      ZoomSuggestion(
                                        link:
                                            "${_controller.ListPicturesPub[index]['link']}",
                                        is_liked: _controller
                                            .ListPicturesPub[index]['liked'],
                                        is_favorit: _controller
                                            .ListPicturesPub[index]['favorite'],
                                        numberlike:
                                            _controller.ListPicturesPub[index]
                                                ['numberlike'],
                                        numbercomment:
                                            _controller.ListPicturesPub[index]
                                                ['numbercomment'],
                                        id_publication:
                                            "${_controller.ListPicturesPub[index]['id']}",
                                        localisation:
                                            " ${_controller.ListPicturesPub[index]['localisation']}",
                                        timeAgo:
                                            "  ${_controller.ListPicturesPub[index]['date']}",
                                        titel:
                                            "${_controller.ListPicturesPub[index]['titel']}",
                                        description:
                                            "${_controller.ListPicturesPub[index]['description']}",
                                        postImage:
                                            "${_controller.ListPicturesPub[index]['file']}",
                                      ),
                                    );
                                  },
                                  child: suggestion(
                                      inputImage:
                                          "${snapshot.data[index]['file']}"),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    // child:
                  )
                : _controller.listdata.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _controller.listdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PostCard(
                              link: "${_controller.listdata[index]['link']}",
                              is_liked: _controller.listdata[index]['liked'],
                              is_favorit: _controller.listdata[index]
                                  ['favorite'],
                              numberlike: _controller.listdata[index]
                                  ['numberlike'],
                              numbercomment: _controller.listdata[index]
                                  ['numbercomment'],
                              id_publication:
                                  "${_controller.listdata[index]['id']}",
                              localisation:
                                  " ${_controller.listdata[index]['localisation']}",
                              timeAgo:
                                  "  ${_controller.listdata[index]['date']}",
                              titel: "${_controller.listdata[index]['titel']}",
                              description:
                                  "${_controller.listdata[index]['description']}",
                              postImage:
                                  "${_controller.listdata[index]['file']}",
                            );
                          },
                        ),
                      )
                    : Expanded(child: Text("Aucun résultat pour "))
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
