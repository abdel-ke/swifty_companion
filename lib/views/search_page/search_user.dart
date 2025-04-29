import 'package:flutter/material.dart';
import 'package:swifty_companion/widgets/my_button.dart';
import 'package:swifty_companion/widgets/search_delegate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/42_Logo.png',
            width: 200,
            height: 200,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              // onTap: () => search(context, user.text.trim().toString()),
              onTap: () async {
                await showSearch(
                    context: context, delegate: CustomSearchDelegate());
              },
              title: 'Search'),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Swifty Companion',
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
    );
  }
}
