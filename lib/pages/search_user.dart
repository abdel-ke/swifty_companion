import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/pages/user_profile.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/drawer.dart';
import 'package:swifty_companion/widgets/my_button.dart';
import 'package:swifty_companion/widgets/my_textfield.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  fetchMe() async {
    try {
      User fetchMe =
          await Provider.of<MyProvider>(context, listen: false).auth.fetchMe();
      try {
        if (context.mounted) {
          Coalition myCoalition =
              await Provider.of<MyProvider>(context, listen: false)
                  .auth
                  .fetchCoalition(fetchMe.login);
          context.read<MyProvider>().setMyCoalition(myCoalition);
        }
      } catch (e) {
        print('error to load your coalition $e');
      }
      if (context.mounted) {
        context.read<MyProvider>().setMe(fetchMe);
      }
    } catch (e) {
      print(e);
      print('error: can\'t load your info');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMe();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<MyProvider>().controller;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/42_Logo.png',
            width: 200,
            height: 200,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            onSubmitted: (String? value) {
              search(context, user.text.trim().toString());
            },
            controller: user,
            hintText: 'User login',
            margin: 42,
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              onTap: () => search(context, user.text.trim().toString()),
              title: 'Search'),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Swifty Companion',
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.logout),
      //     onPressed: () {
      //       context.watch<MyProvider>().auth.helper.disconnect();
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => const LoginPage()));
      //     },
      //   )
      // ],
    );
  }

  void search(BuildContext context, String login) async {
    if (login.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      try {
        final futureCoalition =
            await Provider.of<MyProvider>(context, listen: false)
                .auth
                .fetchCoalition(login);
        if (!context.mounted) return;
        final futureUser = await Provider.of<MyProvider>(context, listen: false)
            .auth
            .fetchUser(login);
        if (!context.mounted) return;
        context.read<MyProvider>().setFutureUser(futureUser);
        context.read<MyProvider>().setFutureCoalition(futureCoalition);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const UserProfile()));
      } catch (e) {
        print(e);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'User not found',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }
}
