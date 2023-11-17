import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/User.dart';
import 'package:swifty_companion/pages/generation_list.dart';
import 'package:swifty_companion/utils/generation.dart';
import 'package:swifty_companion/utils/provider.dart';

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
                      context.read<MyProvider>().setPromo(e);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const GenerationList()));
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
