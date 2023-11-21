import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/pages/ranking_list.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/custom_image.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User data = context.watch<MyProvider>().futureUser;
    final coalition = context.watch<MyProvider>().futureCoalition;
  
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
                // CircleAvatar(
                //   radius: 50,
                //   backgroundImage: NetworkImage(data.imageUrl),
                // ),
                CustomImage(imageUrl: data.imageUrl),
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
                      context.read<MyProvider>().setPromo('${entry.key} $e');
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const GenerationList()));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidget()));
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
