import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/pages/home_page.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/search_user.dart';
import 'package:swifty_companion/utils/storage.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: HomePage(),
        // ),
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/search': (context) => SearchPage(),
      }
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Swifty Companion'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            MyStorage().delete('AccessToken');
            Navigator.pushNamed(context, '/login');
          },
        )
      ],
    );
  }
}
