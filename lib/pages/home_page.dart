// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/search_user.dart';
import 'package:swifty_companion/utils/token.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    userInfo();
  }

  userInfo() async {
    final tokenInfo = await checkToekn();
    pushPage(tokenInfo);
  }

  pushPage(tokenInfo) {
    if (tokenInfo == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [CircularProgressIndicator()],
    );
  }
}
