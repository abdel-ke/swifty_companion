import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/profile_page/my_image_profile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User data = context.watch<MyProvider>().me;
    final myCoalition = context.watch<MyProvider>().myCoalition;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: myCoalition.color),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/myuser');
                        },
                        child: MyImageProfile(imageUrl: data.imageUrl),
                      ),
                      Text(data.fullName, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: const Text('Ranking'),
                  leading: const Icon(Icons.emoji_events),
                  children: [
                    ...generation.entries
                        .map<ExpansionTile>((entry) {
                          return ExpansionTile(
                            leading: const Icon(Icons.home),
                            title: Text(entry.key),
                            children: (() {
                              final entriesList = entry.value.entries.toList();
                              entriesList.sort((a, b) => a.key.compareTo(b.key));
                              return entriesList.map<ListTile>((e) {
                                return ListTile(
                                  onTap: () {
                                    context.read<MyProvider>().setPromo(
                                      '${entry.key} ${e.value}',
                                    );
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                      context,
                                      '/ranking',
                                    );
                                  },
                                  title: Text('${e.key} (${e.value})'),
                                );
                              }).toList();
                            })(),
                          );
                        }),
                  ],
                ),
                // ExpansionTile(
                //   title: const Text('Clusters'),
                //   leading: const Icon(Icons.group),
                //   children: [
                //     ListTile(
                //       title: const Text('Khouribga'),
                //       leading: const Icon(Icons.group),
                //       onTap: () {
                //         // Navigator.pushNamed(context, '/clusters');
                //         Navigator.pop(context);
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const KHClusters(),
                //           ),
                //         );
                //       },
                //     ),
                //     ListTile(
                //       title: const Text('Ben Guerir'),
                //       leading: const Icon(Icons.group),
                //       onTap: () {
                //         // Navigator.pushNamed(context, '/clusters');
                //         Navigator.pop(context);
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const BgCluster(),
                //           ),
                //         );
                //       },
                //     ),
                //     ListTile(
                //       title: const Text('Tetouan'),
                //       leading: const Icon(Icons.group),
                //       onTap: () {
                //         // Navigator.pushNamed(context, '/clusters');
                //         Navigator.pop(context);
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const MedCluster(),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
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
