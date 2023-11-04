import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/user_page.dart';
import 'package:swifty_companion/widgets/my_button.dart';
import 'package:swifty_companion/widgets/my_textfield.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          MyTextField(controller: user, hintText: 'User login', margin: 25),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              onTap: () {
                if (user.text.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserPage(user: user.text)));
                  // user.clear();
                }
              },
              title: 'Search'),
        ],
      ),
    );
  }
}
