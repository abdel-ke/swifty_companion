import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/utils/provider.dart';
import 'package:swifty_companion/widgets/card_user.dart';

class GenerationList extends StatelessWidget {
  const GenerationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final User data = context.watch<MyProvider>().futureUser;
    final String promo = context.watch<MyProvider>().promo;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          title: Text(promo),
          foregroundColor: Colors.grey.shade800,
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          itemCount: 35,
          itemBuilder: (context, index) => CardUser(data: data),
        )
        // drawer: MyDrawer(data: data, coalition: coalition),
        );
  }
}
