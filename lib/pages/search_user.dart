import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/user_profile.dart';
import 'package:swifty_companion/utils/auth.dart';
import 'package:swifty_companion/utils/storage.dart';
import 'package:swifty_companion/widgets/my_button.dart';
import 'package:swifty_companion/widgets/my_textfield.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController user = TextEditingController();

  void search(context) async {
    if (user.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        final futureCoalition = await fetchCoalition(user.text.trim().toLowerCase());
        final futureUser = await fetchUser(user.text.trim().toLowerCase());
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfile(data: futureUser, coalition: futureCoalition, controller: user)));
      } catch (e) {
        debugPrint('ERROR: $e');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('User not found', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/42_Logo.png', width: 200, height: 200),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            onSubmitted: (String? value) {
              search(context);
            },
            controller: user,
            hintText: 'User login',
            margin: 42,
          ),
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
      backgroundColor: Colors.blueGrey[900],
      actions: [
        IconButton(
            onPressed: () async {
              final token = await MyStorage().read('AccessToken');
              final refresh = await MyStorage().read('RefreshToken');
              debugPrint('token: $token');
              debugPrint('refresh: $refresh');
              // Coalition cola = await fetchCoalition('abddel-ke');
              // debugPrint('coalition: ${cola.color}');
            },
            icon: const Icon(Icons.remove_red_eye_outlined)),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            MyStorage().delete('AccessToken');
            MyStorage().delete('RefreshToken');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        )
      ],
    );
  }
}
