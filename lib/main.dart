import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/pages/home_page.dart';
import 'package:swifty_companion/pages/login_page.dart';
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Swifty Companion'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await MyStorage().delete('AccessToken');
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            )
          ],
        ),
        body: const HomePage(),
      )
    );
  }
}
