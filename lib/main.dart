import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/pages/home_page.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/search_user.dart';
import 'package:swifty_companion/pages/user_profile.dart';
import 'package:swifty_companion/utils/provider.dart';
import 'package:swifty_companion/utils/storage.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Scaffold(
            body: HomePage(),
          ),
          routes: {
            '/login': (context) => const LoginPage(),
            '/search': (context) => SearchPage(),
            '/user': (context) => UserProfile(),
          }),
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
