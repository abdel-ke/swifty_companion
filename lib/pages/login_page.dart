import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/search_user.dart';
import 'package:swifty_companion/utils/auth.dart';
import 'package:swifty_companion/widgets/my_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    pushPage(ret) {
      if (ret == true) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage()));
      } else {
        Navigator.pop(context);
      }
    }

    checkAuthorization() async {
      final ret = await authorization();
      pushPage(ret);
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/42_Logo.png', width: 200,),
          MyButton(onTap: checkAuthorization, title: 'Sign in with 42'),
        ],
      ),
    );
  }
}
