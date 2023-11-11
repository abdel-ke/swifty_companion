import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/widgets/projects_list.dart';
import 'package:swifty_companion/widgets/skills_list.dart';
import 'package:swifty_companion/widgets/user_info.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key, required this.data, required this.coalition,
  required this.controller
  });
  User data;
  Coalition coalition;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.clear();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                userInfo(context, data, coalition),
                infoC(data, coalition),
                Projects(
                  projects: data.projects,
                  grade: data.grade,
                ),
                const SizedBox(height: 10),
                SkillsList(skills: data.skills),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget userInfo(context, data, Coalition coalition) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(coalition.coverUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 42),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(data!.imageUrl),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.black.withOpacity(0.8),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Icon(Icons.person, color: Colors.white),
                  Text(data!.fullName,
                      style: TextStyle(color: coalition.color),
                      overflow: TextOverflow.ellipsis),
                  Text(data!.login, style: TextStyle(color: coalition.color)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          infoA(data, coalition),
          const SizedBox(height: 10),
          infoB(data, context),
          const SizedBox(height: 10),
          levelLinear(data, coalition),
          const SizedBox(height: 15),
        ],
      ),
    );

Widget levelLinear(data, Coalition coalition) => LinearPercentIndicator(
      animation: true,
      lineHeight: 24.0,
      barRadius: const Radius.circular(3),
      animationDuration: 1000,
      percent: double.parse(data!.level.toString().split(".")[1]) / 100,
      center: Text(
        '${data!.level.toString()}%',
        style: const TextStyle(color: Colors.white),
      ),
      progressColor: coalition.color,
      // progressColor: const Color.fromRGBO(33, 90, 22, 0.7),
      backgroundColor: Colors.black.withOpacity(0.6),
    );

Widget infoA(data, Coalition coalition) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.black.withOpacity(0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'Wallet',
                  style: TextStyle(color: coalition.color),
                ),
                Text('${data!.wallet.toString()} ₳',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
            Column(
              children: [
                // const SizedBox(height: 2),
                Text('Evaluation points',
                    style: TextStyle(color: coalition.color)),
                Text(data!.correctionPoint.toString(),
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
            // ignore: prefer_const_constructors
            // Column(
            //   // ignore: prefer_const_literals_to_create_immutables
            //   children: [
            //     Text('Cursus', style: TextStyle(color: coalition.color)),
            //     const Text('42 cursus', style: TextStyle(color: Colors.white)),
            //   ],
            // ),
            Column(
              children: [
                Text('Grade', style: TextStyle(color: coalition.color)),
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
          color: Colors.black.withOpacity(0.8),
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

Widget infoC(data, Coalition coalition) => Container(
      // color: Colors.grey.shade200,
      color: Colors.black.withOpacity(0.9),
      // margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (data!.phone != "hidden")
            UserInfo(title: data!.phone, icon: Icons.phone_android_outlined, color: coalition.color),
          UserInfo(title: data!.email, icon: Icons.email_outlined, color: coalition.color),
          UserInfo(title: data!.city, icon: Icons.location_on_outlined, color: coalition.color),
        ],
      ),
    );
