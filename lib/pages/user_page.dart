import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/utils/auth.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UserPage extends StatefulWidget {
  final String user;
  const UserPage({super.key, required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<User> futureUser;
  @override
  void initState() {
    super.initState();
    setState(() {
      futureUser = fetchUser(widget.user.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swifty Companion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text(
                      'Error occured while fetching data from API 42');
                }
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.login),
                      Text(snapshot.data!.fullName),
                      Text(snapshot.data!.email),
                      Text(snapshot.data!.location),
                      Text(snapshot.data!.level.toString()),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2500,
                          percent: double.parse(snapshot.data!.level.toString().split(".")[1]) / 100,
                          center: Text('${snapshot.data!.level.toString()}%'),
                          // linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.green,
                        ),
                      ),
                      Image.network(snapshot.data!.imageUrl),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
