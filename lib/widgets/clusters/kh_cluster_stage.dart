import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/helper/cluster_data.dart';
import 'package:swifty_companion/helper/functions.dart';
import 'package:swifty_companion/pages/profile_page/profile_info.dart';
import 'package:swifty_companion/widgets/profile_page/my_image_profile.dart';

class ClusterStage extends StatelessWidget {
  const ClusterStage({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width - 20;
    final double heightSize = MediaQuery.of(context).size.height - 150;

    return FutureBuilder(
        future: fetchClusters(clustersSvgUrl[index], KHOURIBGAID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> jsonObject =
                json.decode(snapshot.data.toString());
            List<dynamic> images = jsonObject["svg"]["image"];
            List text = jsonObject["svg"]["text"];
            List<dynamic> viewBoxValues = jsonObject["svg"]["viewBox"]
                .split(' ')
                .map((str) => double.parse(str))
                .toList();
            return InteractiveViewer(
              minScale: 0.1,
              maxScale: 3.0,
              child: Stack(
                children: [
                  ...text.map((e) => _buildTextPositioned(
                      e, viewBoxValues, widthSize, heightSize)),
                  ...images.map((e) => _buildImagePositioned(
                      e, viewBoxValues, widthSize, heightSize, context)),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.green,),
          );
          // return SvgPicture.asset(
          //   clustersSvg[index],
          //   colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          // );
        });
  }

  Positioned _buildTextPositioned(dynamic e, List<dynamic> viewBoxValues,
      double widthSize, double heightSize) {
    List lastTwoNumbers = getLastTwoNumber(e["transform"]);
    final double left =
        calculatePosition(lastTwoNumbers[0], viewBoxValues[2], widthSize);
    final double top = calculatePosition(lastTwoNumbers[1], viewBoxValues[3],
        heightSize);
    if (lastTwoNumbers.length >= 2) {
      return Positioned(
        left: left,
        top: top,
        child: Text(
          e["\$t"],
          style: const TextStyle(fontSize: 8),
        ),
      );
    }
    return Positioned(child: Container());
  }

  Positioned _buildImagePositioned(dynamic e, List<dynamic> viewBoxValues,
      double widthSize, double heightSize, BuildContext context) {
    final double left = calculatePosition(e["x"], viewBoxValues[2], widthSize);
    final double top = calculatePosition(e["y"], viewBoxValues[3], heightSize);
    final double width = calculateSize(e["width"], viewBoxValues[2], widthSize);
    final double height = calculateSize(e["height"], viewBoxValues[3],
        heightSize);// ;
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: e["xlink:href"] != ""
          ? GestureDetector(
              onTap: () {
                displayProfile(context, e["xlink:href"]);
              },
              child: MyImageProfile(
                imageUrl: e["xlink:href"],
                width: width,
                height: height,
                radius: 0,
                size: height,
                circle: false,
              ))
          : Container(
              color: Colors.white,
            ),
    );
  }

  double calculatePosition(String value, double viewBoxValue, double size) {
    return (double.parse(value) / viewBoxValue) * size;
  }

  double calculateSize(String value, double viewBoxValue, double size) {
    return (double.parse(value) / viewBoxValue) * size;
  }

  void displayProfile(BuildContext context, String url) {
    final filename = url;
    RegExp regExp = RegExp(r'small_(.*?)\.');
    Match? match = regExp.firstMatch(filename);
    String? login;
    if (match != null && match.groupCount >= 1) {
      login = match.group(1);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileInfo(
            login: login!,
          ),
        ),
      );
    }
  }
}
