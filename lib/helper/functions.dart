import 'package:flutter/material.dart';

int date(String date) {
  if (date == 'null') return -1;
  DateTime now = DateTime.now();
  DateTime bk = DateTime.parse(date);
  return bk.difference(now).inDays;
}

Text timeAgo2(String markedAt) {
  try {
    final difference = DateTime.now().difference(DateTime.parse(markedAt));
    final years = (difference.inDays / 365).round();
    if (years > 0) {
      return Text('$years years ago');
    }
    final months = (difference.inDays / 30).round();
    if (months > 0) {
      return Text('$months months ago');
    }
    final days = (difference.inHours / 24).round();
    if (days > 0) {
      return Text('$days days ago');
    }
    final hours = (difference.inHours).round();
    if (hours > 0) {
      return Text('$hours hours ago');
    }
    final minutes = (difference.inMinutes).round();
    if (minutes > 0) {
      return Text('$minutes minutes ago');
    }
    return const Text('just now');
  } catch (e) {
    print('e: $e');
    return const Text('');
  }
}

String addImageLinksToSVGs(String svgData, Map<String, dynamic> clusterData) {
  clusterData.forEach((key, value) {
    print('start');
    final id = key;
    final imageUrl = value['image'];
    print('id: $id');
    print('imageUrl: $imageUrl');
    RegExp imageId = RegExp(
      '<image\\s+[^>]*id="$id"[^>]*(?:/)?>(?:</image>)?',
    );
    final match = imageId.firstMatch(svgData);
    print('match: $match');
    final xlinkHref = RegExp('xlink:href="[^"]*"');
    final xlinkHrefMatch =
        xlinkHref.firstMatch('xlinkHrefMatch: xlink:href="$imageUrl"');
    // print('xlinkHrefMatch: ${xlinkHrefMatch![0]}');
    print('END');
    final newMatch =
        match![0]!.replaceFirst(xlinkHref, xlinkHrefMatch![0].toString());
    svgData.replaceFirst(match[0].toString(), newMatch);
  });
  print('done');
  return svgData;
}


List getLastTwoNumber(String str) {
  // Define a regular expression pattern to match numbers
  RegExp regex = RegExp(r'\b\d+\b');

  // Find all matches in the string
  List<RegExpMatch> matches = regex.allMatches(str).toList();

  // Get the last two matches
  if (matches.length >= 2) {
    String secondLast = matches[matches.length - 2].group(0)!;
    String last = matches[matches.length - 1].group(0)!;
    return [secondLast, last];
  }
  return [];
}
