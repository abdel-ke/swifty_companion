import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:swifty_companion/widgets/profile_page/user_info.dart';

class SkeletonizerProfile extends StatelessWidget {
  const SkeletonizerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Skeletonizer(
            enabled: true,
            child: Column(
              children: <Widget>[
                SkeletonizerUserInfo(context),
                SkeletonizerInfoC(context),
                Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: 250,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Theme.of(context).colorScheme.background,
                          child: const ListTile(
                            title: Text('project Name'),
                            trailing: Text('in progress'),
                          ),
                        );
                      },
                    )),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget SkeletonizerUserInfo(context) => Container(
      child: Column(
        children: [
          const SizedBox(height: 42),
          const CircleAvatar(radius: 50),
          const SizedBox(height: 10),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('there is an text'),
                  Text('there is an text'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          SkeletonizerInfoA(context),
          const SizedBox(height: 10),
          SkeletonizerInfoB(),
          const SizedBox(height: 10),
        ],
      ),
    );


Widget SkeletonizerInfoA(context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text('Wallet'),
                Text('₳'),
              ],
            ),
            Column(
              children: [
                Text('Evaluation points'),
                Text('7'),
              ],
            ),
            Column(
              children: [
                Text('Grade'),
                Text('member'),
              ],
            ),
          ],
        ),
      ),
    );

Widget SkeletonizerInfoB() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: double.infinity,
        height: 250,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unavailable'),
            Text('days left'),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
/* 
  You've been absorbed by the Black Hole.
*/
Widget SkeletonizerInfoC(context) => Container(
      color: Theme.of(context).colorScheme.secondary,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          UserInfo(title: 'email.email.com', icon: Icons.email_outlined, color: Colors.red),
          UserInfo(
              title: 'Location', icon: Icons.location_on_outlined, color: Colors.red),
        ],
      ),
    );
