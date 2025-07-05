import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/routes.dart';
import 'package:swifty_companion/utils/functions.dart';
import 'package:swifty_companion/views/home_page.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/themes/dark_theme.dart';
import 'package:swifty_companion/themes/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  secretId = await getSecretId();
  promo = await getPromo();
  generation = await getGenerations();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MyProvider())],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: HomePage()),
        routes: routes,
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Swifty Companion'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Provider.of<MyProvider>(
              context,
              listen: false,
            ).auth.helper.disconnect();
            Navigator.pushNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
