import 'package:flutter/material.dart';
import 'package:swifty_companion/pages/user_page.dart';
import 'package:swifty_companion/widgets/my_button.dart';
import 'package:swifty_companion/widgets/my_textfield.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swifty Companion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // await MyStorage().delete('AccessToken');
              // ignore: use_build_context_synchronously
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          MyTextField(controller: user, hintText: 'User login', margin: 25),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              onTap: () async {
                if (user.text.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserPage(user: user.text)));
                  // user.clear();
                }
              },
              title: 'Search'),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
