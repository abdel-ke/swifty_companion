import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/pages/user_profile.dart';
import 'package:swifty_companion/utils/generation.dart';
import 'package:swifty_companion/widgets/card_user.dart';

class GenerationList extends StatelessWidget {
  const GenerationList({
    super.key,
    required this.promo,
    required this.data,
  });
  final String promo;
  final User data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          title: Text(promo),
          foregroundColor: Colors.grey.shade800,
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 35,
          // itemBuilder: (context, index) => CardUser(data: data),
          itemBuilder: (context, index) => CardUser(data: data),
        )
        // drawer: MyDrawer(data: data, coalition: coalition),
        );
  }
}
