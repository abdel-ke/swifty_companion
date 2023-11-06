import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/utils/auth.dart';

class ProfileWidget extends StatefulWidget {
  String user;
  ProfileWidget({super.key, required this.user});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator()
                );
            }
            if (snapshot.hasError) {
              print('Error occured while fetching data from API 42: ${snapshot.error}');
              return const Text(
                  'Error occured while fetching data from API 42');
            }
            if (snapshot.hasData) {
              // final width = MediaQuery.of(context).size.width;
              // final height = MediaQuery.of(context).size.height;
              return Container(
                color: Colors.greenAccent[100],
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(snapshot.data!.imageUrl),
                    ),
                    // Image.network(snapshot.data!.imageUrl, width: width / 4)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.greenAccent[200],
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text('Wallet'),
                                    Text(snapshot.data!.wallet.toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // const SizedBox(height: 2),
                                    const Text('Evaluation points'),
                                    Text(snapshot.data!.correctionPoint.toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Grade'),
                                    Text(snapshot.data!.grade.toString()),
                                  ],
                                ),
                              ],
                            )
                          ),
                          Text(snapshot.data!.fullName),
                          Text(snapshot.data!.login),
                          // Text(snapshot.data!.email),
                          Text(snapshot.data!.location),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 1000,
                              percent: double.parse(
                                      snapshot.data!.level.toString().split(".")[1]) /
                                  100,
                              center: Text('${snapshot.data!.level.toString()}%'),
                              // linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
