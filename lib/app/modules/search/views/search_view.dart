import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  final List<String> suggestions = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grape",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Peach",
    "Pear",
    "Pineapple",
    "Strawberry",
    "Watermelon",
  ];
  void _onSuggestionSelected(String suggestion) {
    _searchController.text = suggestion;
    // You can perform any action when a suggestion is selected here.
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
        selectedindex: 1,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search...',
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
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    _onSuggestionSelected(suggestion.toString());
                  },
                ),
                // Add other content below the search field if needed
              ],
            ),
          ),
        ));
  }
}
