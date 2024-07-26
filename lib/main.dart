import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/routes.dart';
import 'package:swifty_companion/utils/functions.dart';
import 'package:swifty_companion/views/clusters/kh_clusters.dart';
import 'package:swifty_companion/views/home_page.dart';
import 'package:swifty_companion/views/login_page/login_page.dart';
import 'package:swifty_companion/views/profile_page/my_profile.dart';
import 'package:swifty_companion/views/ranking_page/ranking_list.dart';
import 'package:swifty_companion/views/search_page/search_user.dart';
import 'package:swifty_companion/views/profile_page/user_profile.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/themes/dark_theme.dart';
import 'package:swifty_companion/themes/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  secretId = await getSecretId();
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
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          body: HomePage(),
        ),
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
            Provider.of<MyProvider>(context, listen: false)
                .auth
                .helper
                .disconnect();
            Navigator.pushNamed(context, '/login');
          },
        )
      ],
    );
  }
}
