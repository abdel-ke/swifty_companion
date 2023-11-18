import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/pages/user_profile.dart';
import 'package:swifty_companion/utils/generation.dart';

class CardUser extends StatelessWidget {
  const CardUser({super.key, required this.data});
  final Ranking data;

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
                        backgroundImage: NetworkImage(data.imageUrl[0]),
                      ),
                      Text(data.login[0]),
                      Text('Level: ${data.level.toString()}', style: TextStyle(fontSize: 16, color: Colors.green.shade700)),
                      LinearPercentIndicator(
                        animation: false,
                        lineHeight: 18.0,
                        width: 170,
                        alignment: MainAxisAlignment.center,
                        barRadius: const Radius.circular(3),
                        percent: double.parse(
                                data.level![0].toStringAsFixed(2).split(".")[1]) /
                            100,
                        center: Text(
                          '${data.level.toString()}%',
                          style: const TextStyle(color: Colors.white),
                        ),
                        progressColor: Colors.green.shade700,
                        backgroundColor: Colors.black.withOpacity(0.6),
                      ),
                      if (data.blackholedAt != "null")
                        blackHole(data),
                        // Text(date(data.blackholedAt).toString()),
                      Text(data.location[0] == '-' ? 'Unavailable' : data.location[0]),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '4',
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 15),
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
            'Black Hole.',
            style: TextStyle(color: Colors.red, fontSize: 26),
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