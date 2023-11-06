import 'package:flutter/material.dart';
import 'package:swifty_companion/widgets/profile.dart';

class UserPage extends StatefulWidget {
  final String user;
  const UserPage({super.key, required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swifty Companion'),
        elevation: 0,
      ),
      body: Column(
        children: [
        ProfileWidget(user: widget.user),
      ],),
    );
  }
}
