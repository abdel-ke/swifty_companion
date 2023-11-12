import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/search_user.dart';
import 'package:swifty_companion/utils/token.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLogged = false;
  @override
  void initState() {
    super.initState();
    userInfo();
  }

  userInfo() async {
    final tokenInfo = await checkToekn();
    debugPrint(tokenInfo.toString());
    setState(() {
      isLogged = tokenInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged == false) {
      return const SafeArea(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      return SearchPage();
    }
  }
}
