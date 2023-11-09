import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/utils/auth.dart';
import 'package:swifty_companion/widgets/profile_screen.dart';

class ProfileWidget extends StatefulWidget {
  String user;
  ProfileWidget({super.key, required this.user});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late Future<User> futureUser;
  @override
  void initState() {
    super.initState();
    setState(() {
      futureUser = fetchUser2(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            print(
                'Error occured while fetching data from API 42: ${snapshot.error}');
            return const Text('Error occured while fetching data from API 42');
          }
          if (snapshot.hasData) {
            return ProfileScreen(
              data: snapshot.data,
            );
          }
          return const Text('No data found');
        });
  }
}
