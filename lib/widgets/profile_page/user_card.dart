import 'package:flutter/material.dart';
import 'package:swifty_companion/helper/functions.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/pages/profile_page/profile_info.dart';
import 'package:swifty_companion/pages/profile_page/user_profile.dart';
import 'package:swifty_companion/widgets/custom_image.dart';

class CardUser extends StatelessWidget {
  const CardUser({super.key, required this.data, required this.index});
  final Ranking data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileInfo(login: data.login)));
      },
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  displayImage(context, data.imageUrl);
                },
                child: CustomImage(imageUrl: data.imageUrl)),
              if (data.alumni)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('Alumni',
                      style: TextStyle(
                          fontSize: 16, color: Colors.green.shade500)),
                ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      data.login,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text('level: ${data.level.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, color: Colors.green.shade500)),
                  ],
                ),
              ),
              Text(data.location == 'null' ? '-' : data.location),
              if (data.blackholedAt != "null") blackHole(data),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(8.0), 
                  margin: const EdgeInsets.only(right: 8),// Adjust as needed
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: (index + 1) > 99 ? 8 : 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
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
