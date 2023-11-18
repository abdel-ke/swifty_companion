import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/search_user.dart';
import 'package:swifty_companion/utils/provider.dart';

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
    // userInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userInfo();
  }

  userInfo() async {
    // final tokenInfo = await checkToekn();
    try {
      final tokenInfo = await context.read<MyProvider>().auth.checkToken();
      setState(() {
        isLogged = tokenInfo;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged == false) {
      return const SafeArea(
          child: Center(
        child: LoginPage(),
        // child: CircularProgressIndicator(),
      ));
    } else {
      return SearchPage();
    }
  }
}
