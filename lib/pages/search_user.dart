import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/user_page.dart';
import 'package:swifty_companion/utils/storage.dart';
import 'package:swifty_companion/widgets/my_button.dart';
import 'package:swifty_companion/widgets/my_textfield.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController user = TextEditingController();

  search(context) {
    if (user.text.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserPage(user: user.text)));
      // user.clear();
    }
  }

  onSubmitted(String value, BuildContext context) {
    search(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          MyTextField(
              // onSubmitted: onSubmitted,
              controller: user,
              hintText: 'User login',
              margin: 25),
          const SizedBox(
            height: 10,
          ),
          MyButton(onTap: () => search(context), title: 'Search'),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Swifty Companion'),
      actions: [
        IconButton(
            onPressed: () async {
              final token = await MyStorage().read('AccessToken');
              final refresh = await MyStorage().read('RefreshToken');
              print('token: $token');
              print('refresh: $refresh');
            },
            icon: const Icon(Icons.remove_red_eye_outlined)),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            MyStorage().delete('AccessToken');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        )
      ],
    );
  }
}
