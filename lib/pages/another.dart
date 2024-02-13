import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/helper/cluster_data.dart';
import 'package:xml2json/xml2json.dart';

class Another extends StatelessWidget {
  const Another({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchClusters(clustersSvgUrl[0]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String xmlString = snapshot.data.toString();
            xmlString = xmlString.replaceAll(RegExp(r'<g\b[^>]*?>'), '');
            xmlString = xmlString.replaceAll(RegExp(r'</g>'), '');
            final myTransformer = Xml2Json();
            myTransformer.parse(xmlString);
            final jsonString = myTransformer.toGData();
            Map<String, dynamic> jsonObject = json.decode(jsonString);
            // g[0].g[9].image[2]

            List<dynamic> images = jsonObject["svg"]["image"];
            // Clipboard.setData(ClipboardData(text: jsonString));
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Stack(
                children: [
                  Container(
                    color: Colors.red,
                    width: 600,
                  ),
                  ...images.map((e) {
                    return Positioned(
                      left: double.parse(e["x"]),
                      top: double.parse(e["y"]) * 0.80,
                      width: double.parse(e["width"]),
                      height: double.parse(e["height"]),
                      child: e["xlink:href"] != ""
                          ? Image.network(
                              e["xlink:href"],
                              fit: BoxFit.cover,
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
          return Padding(
              padding: const EdgeInsets.all(18.0),
              // child: svgProvider.Svg(snapshot.data),
              child: SvgPicture.network(
                clustersSvgUrl[0],
                placeholderBuilder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ));
        });
  }
}
