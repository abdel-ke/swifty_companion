import 'package:flutter/material.dart';

class GenerationList extends StatelessWidget {
  const GenerationList(
      {super.key,
      required this.promo,});
  final String promo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: Text(promo),
        foregroundColor: Colors.grey.shade800,
      ),
      body: Center(child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(promo),
          ],
        )

        )),
      // drawer: MyDrawer(data: data, coalition: coalition),
    );
  }
}
