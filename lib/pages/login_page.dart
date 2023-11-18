import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/utils/provider.dart';
import 'package:swifty_companion/widgets/my_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    pushPage(ret) {
      if (ret == true) {
        Navigator.pushNamed(context, '/search');
      }
    }

    checkAuthorization() async {
      final tokenInfo = await context.read<MyProvider>().auth.checkToken();
      pushPage(tokenInfo);
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/42_Logo.png', width: 200,),
          MyButton(onTap: checkAuthorization, title: 'Sign in with intra 42'),
        ],
      ),
    );
  }
}
