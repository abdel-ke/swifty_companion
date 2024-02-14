import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/pages/profile_info.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/my_button.dart';
import 'package:swifty_companion/widgets/my_textfield.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<MyProvider>().controller;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
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
          MyTextField(
            onSubmitted: (String? value) {
              search(context, user.text.trim().toString());
            },
            controller: user,
            hintText: 'User login',
            margin: 42,
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              onTap: () => search(context, user.text.trim().toString()),
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

  void search(BuildContext context, String login) async {
    if (login.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        await Provider.of<MyProvider>(context, listen: false)
            .auth
            .fetchUser(login);
        if (!context.mounted) return;
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileInfo(login: login)));
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'User not found',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }
}
