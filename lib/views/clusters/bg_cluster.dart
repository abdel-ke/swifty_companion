import 'package:flutter/material.dart';
import 'package:swifty_companion/widgets/clusters/bg_cluster_stage.dart';
import 'package:swifty_companion/widgets/drawer.dart';

class BgCluster extends StatelessWidget {
  const BgCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Ben Guerir Clusters'),
          bottom: TabBar(
            physics: const NeverScrollableScrollPhysics(),
            labelColor: Theme.of(context).appBarTheme.foregroundColor,
            indicatorColor: Colors.blue,
            tabs: const <Widget>[
              Tab(text: 'E1'),
              Tab(text: 'E2'),
              Tab(text: 'C3'),
              Tab(text: 'C4'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            BGClusterStage(index: 0),
            BGClusterStage(index: 1),
            BGClusterStage(index: 2),
            BGClusterStage(index: 3),
          ],
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}
