import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/search_user.dart';
import 'package:swifty_companion/providers/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isLogged = 0;
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
        if (tokenInfo == false) {
          isLogged = 1;
        } else {
          isLogged = 2;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged == 0) {
      return const SafeArea(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    } else if (isLogged == 1) {
      return const LoginPage();
    }
    return SearchPage();
  }
}
