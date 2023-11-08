import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty_companion/widgets/projects_list.dart';
import 'package:swifty_companion/widgets/skills_list.dart';
import 'package:swifty_companion/widgets/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        userInfo(data, context),
        infoC(data),
        Projects(projects: data!.projects),
        const SizedBox(height: 10),
        SkillsList(skills: data!.skills),
        const SizedBox(height: 15),
      ],
    );
  }
}

Widget userInfo(data, context) => Container(
      color: const Color.fromRGBO(33, 90, 22, 0.7),
      child: Column(
        children: [
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(data!.imageUrl),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.black.withOpacity(0.6),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const Icon(Icons.person, color: Colors.white),
                Text(data!.fullName,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis),
                Text(data!.login, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          infoA(data),
          const SizedBox(height: 10),
          infoB(data, context),
          const SizedBox(height: 10),
          levelLinear(data),
          const SizedBox(height: 15),
        ],
      ),
    );

Widget levelLinear(data) => LinearPercentIndicator(
      animation: true,
      lineHeight: 24.0,
      barRadius: const Radius.circular(3),
      animationDuration: 1000,
      percent: double.parse(data!.level.toString().split(".")[1]) / 100,
      center: Text(
        '${data!.level.toString()}%',
        style: const TextStyle(color: Colors.white),
      ),
      progressColor: const Color.fromRGBO(33, 90, 22, 0.7),
      backgroundColor: Colors.black.withOpacity(0.6),
    );

Widget infoA(data) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.black.withOpacity(0.6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  'Wallet',
                  style: TextStyle(color: Colors.green),
                ),
                Text(data!.wallet.toString(),
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
            Column(
              children: [
                // const SizedBox(height: 2),
                const Text('Evaluation points',
                    style: TextStyle(color: Colors.green)),
                Text(data!.correctionPoint.toString(),
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
            // ignore: prefer_const_constructors
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Cursus', style: TextStyle(color: Colors.green)),
                const Text('42 cursus', style: TextStyle(color: Colors.white)),
              ],
            ),
            Column(
              children: [
                const Text('Grade', style: TextStyle(color: Colors.green)),
                Text(data!.grade.toString(),
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );

int date(String date) {
  DateTime now = DateTime.now();
  DateTime bk = DateTime.parse(date);
  return bk.difference(now).inDays;
}

Widget infoB(data, context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.black.withOpacity(0.6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data!.location != '-' ? 'Available' : 'Unavailable',
                style: const TextStyle(color: Colors.white, fontSize: 24)),
            Text(data!.location,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 50),
            if (data!.blackholedAt != "null") blackHole(data),
          ],
        ),
      ),
    );
/* 
You've been absorbed by the Black Hole.
 */
Color colorsBH(blackHole) {
  return blackHole >= 42
      ? const Color.fromRGBO(33, 90, 22, 1)
      : blackHole >= 15
          ? Colors.amber.shade600
          : Colors.red;
}

Widget blackHole(data) {
  int blackHole = date(data!.blackholedAt) + 1;
  if (blackHole < 0) {
    return const Column(
      children: [
        Text(
          'Black Hole absorption',
          style: TextStyle(color: Colors.red),
        ),
        Text(
          'You\'ve been absorbed by the Black Hole.',
          style: TextStyle(color: Colors.red, fontSize: 26),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  return Column(
    children: [
      Text('Black Hole absorption',
          style: TextStyle(
            color: colorsBH(blackHole),
          )),
      Text('$blackHole days',
          style: TextStyle(color: colorsBH(blackHole), fontSize: 22)),
    ],
  );
}

Widget infoC(data) => Container(
      color: Colors.black.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (data!.phone != "hidden")
            UserInfo(title: data!.phone, icon: Icons.phone),
          UserInfo(title: data!.email, icon: Icons.email),
          UserInfo(title: data!.city, icon: Icons.location_on),
        ],
      ),
    );
