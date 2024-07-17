import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:swifty_companion/pages/Skeletonizer/skeletonizer_profile.dart';
import 'package:swifty_companion/pages/login_page/login_page.dart';
import 'package:swifty_companion/pages/profile_page/my_profile.dart';
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userInfo();
  }

  userInfo() async {
    try {
      final tokenInfo = await context.read<MyProvider>().auth.checkToken();
      if (tokenInfo == true) {
        if (!context.mounted) return;
        User me = await context.read<MyProvider>().auth.fetchMe();
        if (!context.mounted) return;
        context.read<MyProvider>().setMe(me);
        Coalition myCoalition =
            await context.read<MyProvider>().auth.fetchCoalition(me.login);
        if (!context.mounted) return;
        context.read<MyProvider>().setMyCoalition(myCoalition);
      }
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
    // if (isLogged == 0) {
    //   return const SkeletonizerProfile();
    // } 
    // else
    // if (isLogged == 1) {
    //   return const LoginPage();
    // }
    // return const MyProfile();
      return const LoginPage();
  }
}
