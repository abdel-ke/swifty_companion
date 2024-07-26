import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/utils/functions.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:swifty_companion/views/profile_page/user_profile.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/drawer.dart';
import 'package:swifty_companion/widgets/profile_page/my_image_profile.dart';
import 'package:swifty_companion/widgets/profile_page/projects_list.dart';
import 'package:swifty_companion/widgets/profile_page/skills_list.dart';
import 'package:swifty_companion/widgets/profile_page/user_info.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final me = context.watch<MyProvider>().me;
    final coalition = context.watch<MyProvider>().myCoalition;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: coalition.color,
          elevation: 0,
          title: Text(
            me.fullName,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_search_outlined),
              onPressed: () {
                context.read<MyProvider>().auth.helper.disconnect();
                Navigator.pushNamed(context, '/search');
              },
            ),
            IconButton(
              icon: const Icon(Icons.launch),
              onPressed: () async {
                final Uri url =
                    Uri.parse('https://profile.intra.42.fr/users/${me.login}');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                userInfo(context, me, coalition),
                infoC(me, coalition),
                Projects(
                  projects: me.projects,
                  grade: me.grade,
                ),
                SkillsList(skills: me.skills),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        // drawer: const MyDrawer());
        drawer: const MyDrawer());
  }
}

Widget userInfo(context, data, Coalition coalition) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: coalition.coverUrl != "null"
              ? CachedNetworkImageProvider(coalition.coverUrl)
              : const AssetImage('assets/images/default_cover.jpeg')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 42),
          GestureDetector(
            // onTap: () => displayImage(context, data.imageUrl, blur: false),
            onTap: () => displayImage(context, data.imageUrl),
            child: MyImageProfile(imageUrl: data.imageUrl),
          ),
          const SizedBox(height: 10),
          if (data.alumni) alumni(),
          Container(
            color: Colors.black.withOpacity(0.8),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data!.fullName,
                      style: TextStyle(color: coalition.color),
                      overflow: TextOverflow.ellipsis),
                  Text(data!.login, style: TextStyle(color: coalition.color)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          infoA(data, coalition),
          const SizedBox(height: 10),
          infoB(data, context),
          const SizedBox(height: 10),
          levelLinear(data, coalition),
          const SizedBox(height: 15),
        ],
      ),
    );

Widget alumni() => Column(
      children: [
        Container(
          color: Colors.black.withOpacity(0.8),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Alumni',
                    style:
                        TextStyle(fontSize: 16, color: Colors.green.shade500))
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );

Widget levelLinear(data, Coalition coalition) => LinearPercentIndicator(
      animation: true,
      lineHeight: 24.0,
      barRadius: const Radius.circular(3),
      animationDuration: 1000,
      percent: double.parse(data.level.toStringAsFixed(2).split(".")[1]) / 100,
      center: Text(
        '${data!.level.toStringAsFixed(2)}%',
        style: const TextStyle(color: Colors.white),
      ),
      progressColor: coalition.color,
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
                Text('Evaluation points',
                    style: TextStyle(color: coalition.color)),
                Text(data!.correctionPoint.toString(),
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
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

Widget infoB(data, context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
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
      ? const Color.fromARGB(255, 26, 152, 1)
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
      color: Colors.black.withOpacity(0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (data!.phone != "hidden")
            UserInfo(
                title: data!.phone,
                icon: Icons.phone_android_outlined,
                color: coalition.color),
          UserInfo(
              title: data!.email,
              icon: Icons.email_outlined,
              color: coalition.color),
          UserInfo(
              title: data!.city,
              icon: Icons.location_on_outlined,
              color: coalition.color),
        ],
      ),
    );
