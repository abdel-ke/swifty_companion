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
    print('tokenInfo: $tokenInfo');
    pushPage(tokenInfo);
  }

  pushPage(tokenInfo) {
    if (tokenInfo == 'Unauthorized' || tokenInfo == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 80,
          width: 350,
          child: Text(
            '42',
            style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
          )),
      // child: MyButton(onTap: userInfo, title: 'Check token')),
    );
    // return Text('Home Page');
  }
}
