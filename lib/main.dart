import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/helper/functions.dart';
import 'package:swifty_companion/pages/clusters/clusters.dart';
import 'package:swifty_companion/pages/home_page.dart';
import 'package:swifty_companion/pages/login_page/login_page.dart';
import 'package:swifty_companion/pages/profile_page/my_profile.dart';
import 'package:swifty_companion/pages/ranking_page/ranking_list.dart';
import 'package:swifty_companion/pages/search_page/search_user.dart';
import 'package:swifty_companion/pages/profile_page/user_profile.dart';
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
          routes: {
            '/login': (context) => const LoginPage(),
            '/search': (context) => const SearchPage(),
            '/user': (context) => const UserProfile(),
            '/myuser': (context) => const MyProfile(),
            '/ranking': (context) => const RankingList(),
            '/cluster': (context) => const KHClusters(),
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
