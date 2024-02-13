import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/helper/cluster_data.dart';
import 'package:swifty_companion/helper/functions.dart';
import 'package:swifty_companion/pages/profile_info.dart';

class ClusterStage extends StatelessWidget {
  const ClusterStage({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    const double horizental = 0.60;
    const double vertical = 0.70;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: fetchClusters(clustersSvgUrl[index]),
        builder: (context, snapshot) {
          print('width: $width');
          print('height: $height');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
          if (snapshot.hasData) {
            // Map<String, dynamic> jsonObject = await json.decode(jsonString);
            Map<String, dynamic> jsonObject =
                json.decode(snapshot.data.toString());
            // Clipboard.setData(ClipboardData(text: snapshot.data.toString()));
            // print('typeof: ${jsonObject.runtimeType}');
            String viewBox = jsonObject["svg"]["viewBox"];
            final splited = viewBox.split(' ');
            print('|width: ${splited[2]}|');
            print('|height: ${splited[3]}|');
            List<dynamic> images = jsonObject["svg"]["image"];
            List text = jsonObject["svg"]["text"];
            return InteractiveViewer(
              minScale: 0.1,
              maxScale: 3.0,
              child: Stack(
                children: [
                  ...text.map((e) {
                    List lastTwoNumbers = getLastTwoNumber(e["transform"]);
                    if (lastTwoNumbers.length >= 2) {
                      return Positioned(
                        left: double.parse(lastTwoNumbers[0]) * horizental,
                        top: double.parse(lastTwoNumbers[1]) * vertical,
                        child: Text(e["\$t"]),
                      );
                    }
                    return Container();
                  }),
                  ...images.map((e) {
                    return Positioned(
                      left: double.parse(e["x"]) * horizental,
                      top: double.parse(e["y"]) * vertical,
                      width: double.parse(e["width"]) * horizental,
                      height: double.parse(e["height"]) * vertical,
                      child: e["xlink:href"] != ""
                          ? GestureDetector(
                              onTap: () {
                                final filename = e["xlink:href"];
                                RegExp regExp = RegExp(r'small_(.*?)\.');
                                Match? match = regExp.firstMatch(filename);
                                String? login;
                                if (match != null && match.groupCount >= 1) {
                                  login = match.group(1);
                                  // Navigator.pushNamed(context, '/profile',
                                  //     arguments: login);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileInfo(
                                        login: login!,
                                      ),
                                    ),
                                  );
                                }
                                print('Extracted Text: $login');
                              },
                              child: Image.network(
                                e["xlink:href"],
                                fit: BoxFit.cover,
                                width: double.parse(e["width"]) * horizental,
                                height: double.parse(e["height"]) * vertical,
                              ),
                            )
                          : Container(
                              color: Colors.white,
                            ),
                    );
                  }),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        });
  }
}
