import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/utils/auth.dart';
import 'package:swifty_companion/utils/storage.dart';

class HOMEPAGE extends StatefulWidget {
  const HOMEPAGE({super.key});

  @override
  State<HOMEPAGE> createState() => _HOMEPAGEState();
}

class _HOMEPAGEState extends State<HOMEPAGE> {
  late Future<User> futureUser;
  @override
  void initState() {
    super.initState();
    checkStorage();
    futureUser = fetchUser();
  }

  checkStorage() async {
    if (await MyStorage().read('AccessToken') == null) {
      print('im in initstate');
      authorization();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              print('hasError: ${snapshot.error}');
              return const Text('Error');
            }
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data!.login),
                  Text(snapshot.data!.fullName),
                  Text(snapshot.data!.email),
                  Text(snapshot.data!.location),
                  Image.network(snapshot.data!.imageUrl),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
