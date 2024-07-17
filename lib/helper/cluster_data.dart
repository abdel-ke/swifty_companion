import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

Future<Map<String, dynamic>> fetchPosts(String url) async {
  final res = await http.get(
    Uri.parse(url),
    headers: {'Cookie': dotenv.env['COOKIE'].toString()},
  );
  String data = res.body.substring(0, res.body.length - 1);
  data = data.replaceAll("var campus_locations = ", "");
  final Map<String, dynamic> clusterData = await json.decode(data);
  return clusterData;
}

String addImageLinksToSVG(String svgString, rectImageMap) {
  rectImageMap.forEach((item, value) {
    var rectId = item;
    var imageUrl = value['image'];
    var regex = RegExp(
      '<image\\s+[^>]*id="$rectId"[^>]*(?:/)?>(?:</image>)?',
    );
    var match = regex.firstMatch(svgString);
    if (match != null) {
      var xAttr = RegExp('x="([^"]*)"').firstMatch(match.group(0).toString());
      var yAttr = RegExp('y="([^"]*)"').firstMatch(match.group(0).toString());
      var widthAttr =
          RegExp('width="([^"]*)"').firstMatch(match.group(0).toString());
      var heightAttr =
          RegExp('height="([^"]*)"').firstMatch(match.group(0).toString());
      svgString = svgString.replaceAll(
        regex,
        '<image id="$rectId" xlink:href="$imageUrl" preserveAspectRatio="xMidYMid slice" ${xAttr != null ? 'x="${xAttr.group(1)}" ' : ''}${yAttr != null ? 'y="${yAttr.group(1)}" ' : ''}${widthAttr != null ? 'width="${widthAttr.group(1)}" ' : ''}${heightAttr != null ? 'height="${heightAttr.group(1)}" ' : ''}/>',
      );
    }
  });
  svgString = svgString.replaceAll(RegExp('<\\?xml.*\\?>'), '');
  svgString = svgString.replaceAll(
    '<style type="text/css">',
    '<style type="text/css">\nrect{fill:#f1f2f3;stroke:#000;}',
  );
  return svgString;
}

Future<String> fetchClusters(String url, int compusId) async {
  final clusterSvg = await http.get(Uri.parse(url)); // fetch cluster svg
  final Map<String, dynamic> clusterData =
      await fetchPosts("https://www.42tools.me/api/deprecated_locations/$compusId"); // fetch cluster data of users connected
  String xmlString = addImageLinksToSVG(clusterSvg.body, clusterData);
  xmlString = xmlString.replaceAll(RegExp(r'<g\b[^>]*?>'), '');
  xmlString = xmlString.replaceAll(RegExp(r'</g>'), '');
  final myTransformer = Xml2Json();
  myTransformer.parse(xmlString);
  final jsonString = myTransformer.toGData();
  return jsonString;
}

 