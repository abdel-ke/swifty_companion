import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/pages/generation_list.dart';
import 'package:swifty_companion/utils/generation.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.data, required this.coalition});
  final User data;
  final Coalition coalition;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: coalition.color,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(data.imageUrl),
                ),
                Text(data.fullName,
                    style: TextStyle(color: coalition.color),
                    overflow: TextOverflow.ellipsis),
                Text(data.login, style: TextStyle(color: coalition.color)),
              ],
            ),
          ),
          ...generation.entries.map<ExpansionTile>(
            (entry) {
              return ExpansionTile(
                title: Text(entry.key),
                children: entry.value.map<ListTile>((e) {
                  return ListTile(
                    onTap: () {
                      debugPrint(e);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GenerationList(promo: '${entry.key} $e')));
                    },
                    title: Text(e),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
