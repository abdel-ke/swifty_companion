import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/pages/clusters.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/my_image_profile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User data = context.watch<MyProvider>().me;
    final myCoalition = context.watch<MyProvider>().myCoalition;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: myCoalition.color,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyImageProfile(imageUrl: data.imageUrl),
                      Text(data.fullName, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                ...generation.entries.map<ExpansionTile>(
                  (entry) {
                    return ExpansionTile(
                      leading: const Icon(Icons.home),
                      title: Text(entry.key),
                      children: entry.value.map<ListTile>((e) {
                        return ListTile(
                          onTap: () {
                            context
                                .read<MyProvider>()
                                .setPromo('${entry.key} $e');
                            Navigator.pop(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const RankingList()));
                            Navigator.pushNamed(context, '/ranking');
                          },
                          title: Text(e),
                        );
                      }).toList(),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Cluster'),
                  leading: const Icon(Icons.group),
                  onTap: () {
                    // Navigator.pushNamed(context, '/clusters');
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Clusters(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              context.read<MyProvider>().auth.helper.disconnect();
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
