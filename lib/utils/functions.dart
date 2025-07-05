import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/views/profile_page/profile_info.dart';
import 'package:swifty_companion/providers/provider.dart';

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
  final result = await db.collection("intra").doc("credentials").get();
  final secretId = await result.data()?["secretId"] ?? "defaultSecretId";
  return secretId;
}

Future<Map<String, Map<String, dynamic>>> getPromo() async {
  try {
    final db = FirebaseFirestore.instance;
    
    // Define campus documents to fetch
    final campusIds = ['khouribga', 'BenGuerir', 'Tetouan', 'Rabat'];
    final campusNames = ['Khouribga', 'BenGuerir', 'Tetouan', 'Rabat'];
    
    // Fetch all documents in parallel for better performance
    final futures = campusIds.map((id) => 
      db.collection("intra").doc(id).get()
    ).toList();
    
    final snapshots = await Future.wait(futures);
    
    // Check if all documents exist
    if (snapshots.every((snapshot) => snapshot.exists)) {
      // Build the result map
      final promoData = <String, Map<String, dynamic>>{};
      
      for (int i = 0; i < snapshots.length; i++) {
        final data = snapshots[i].data() as Map<String, dynamic>;
        promoData[campusNames[i]] = data;
      }
      return promoData;
    } else {
      final missingDocs = <String>[];
      for (int i = 0; i < snapshots.length; i++) {
        if (!snapshots[i].exists) {
          missingDocs.add(campusIds[i]);
        }
      }
      print('Error: Missing documents: ${missingDocs.join(', ')}');
      return defaultPromo;
    }
  } catch (e) {
    print('Error fetching promo data: $e');
    return defaultPromo;
  }
}

Future<Map<String, Map<String, dynamic>>> getGenerations() async {
  try {
    final db = FirebaseFirestore.instance;
    final result = db.collection("generations");
    final khouribga = await result.doc("Khouribga").get();
    final benGuerir = await result.doc("BenGuerir").get();
    final tetouan = await result.doc("Tetouan").get();
    final rabat = await result.doc("Rabat").get();

    if (khouribga.exists && benGuerir.exists && tetouan.exists && rabat.exists) {
      final generation = {
        'Khouribga': khouribga.data() as Map<String, dynamic>,
        'BenGuerir': benGuerir.data() as Map<String, dynamic>,
        'Tetouan': tetouan.data() as Map<String, dynamic>,
        'Rabat': rabat.data() as Map<String, dynamic>,
      };
      print('Generations data loaded successfully: $generation');
      return generation;
    } else {
      print('Error: One or more documents do not exist');
      return defaultGeneration;
    }
  } catch (e) {
    print('Error fetching generations data: $e');
    return defaultGeneration;
  }
}

void search(BuildContext context, String login) async {
  if (login.isNotEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      await Provider.of<MyProvider>(
        context,
        listen: false,
      ).auth.fetchUser(login);
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileInfo(login: login)),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'User not found',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }
}
