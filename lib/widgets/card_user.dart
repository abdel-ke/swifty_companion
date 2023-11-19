import 'package:flutter/material.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/pages/user_profile.dart';
import 'package:swifty_companion/utils/generation.dart';

class CardUser extends StatelessWidget {
  const CardUser({super.key, required this.data, required this.index});
  final Ranking data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data.imageUrl),
                    ),
                    Text(data.login),
                    Text('Level: ${data.level.toString()}',
                        style: TextStyle(
                            fontSize: 16, color: Colors.green.shade700)),
                    // LinearPercentIndicator(
                    //   animation: false,
                    //   lineHeight: 18.0,
                    //   width: 170,
                    //   alignment: MainAxisAlignment.center,
                    //   barRadius: const Radius.circular(3),
                    //   percent: double.parse(
                    //           data.level.toStringAsFixed(2).split(".")[1]) /
                    //       100,
                    //   center: Text(
                    //     '${data.level.toString()}%',
                    //     style: const TextStyle(color: Colors.white),
                    //   ),
                    //   progressColor: Colors.green.shade700,
                    //   backgroundColor: Colors.black.withOpacity(0.6),
                    // ),
                    if (data.blackholedAt != "null") blackHole(data),
                    // Text(date(data.blackholedAt).toString()),
                    if (data.location != 'null')
                      Text(
                        data.location,
                      ),
                    // Text(data.location == '-' ? 'Unavailable' : data.location),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      (index + 1).toString(),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ],
            )));
  }

  Widget blackHole(data) {
    int blackHole = date(data!.blackholedAt) + 1;
    if (blackHole < 0) {
      return const Column(
        children: [
          Text(
            'BH',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    return Column(
      children: [
        Text('$blackHole days left',
            style: TextStyle(color: colorsBH(blackHole), fontSize: 16)),
      ],
    );
  }
}
