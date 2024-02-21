import 'package:cloud_firestore/cloud_firestore.dart';
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
    return const Text('');
  }
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

Future<String> getSecretId() async {
  final db = FirebaseFirestore.instance;
  final result = await db.collection("intra").get();
  final secretId = await result.docs.first.data()["secretId"];
  return secretId;
}
