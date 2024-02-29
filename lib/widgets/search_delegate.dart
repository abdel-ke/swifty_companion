import 'package:flutter/material.dart';
import 'package:swifty_companion/helper/functions.dart';
import 'package:swifty_companion/models/authentication.dart';
import 'package:swifty_companion/models/user.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buidlSuggest();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buidlSuggest();
  }

  FutureBuilder<dynamic> buidlSuggest() {
    return FutureBuilder(
      future: Authentication().fetchSearchedUser(query),
      builder: (context, snapshot) {
        if (snapshot.data == false) {
          return const Center(
            child: Text('User not found'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetshing data'),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text('No locations found for $query'),
          );
        }
        // debugPrint('data: ${snapshot.data}');
        final List<SearchUser> listUsers = snapshot.data;
        return ListView.builder(
            itemCount: listUsers.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  search(context, listUsers[index].login);
                },
                leading:
                    CircleAvatar(backgroundImage: NetworkImage(listUsers[index].imageUrl)),
                title: Text(listUsers[index].login),
                    // Text(listUsers[index].login),
              );
            });
      },
    );
  }
}