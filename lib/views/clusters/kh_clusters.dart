import 'package:flutter/material.dart';
import 'package:swifty_companion/widgets/clusters/kh_cluster_stage.dart';
import 'package:swifty_companion/widgets/drawer.dart';

class KHClusters extends StatelessWidget {
  const KHClusters({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Clusters'),
          bottom: TabBar(
            physics: const NeverScrollableScrollPhysics(),
            labelColor: Theme.of(context).appBarTheme.foregroundColor,
            indicatorColor: Colors.blue,
            tabs: const <Widget>[
              Tab(text: 'E1'),
              Tab(text: 'E2'),
              Tab(text: 'E3'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ClusterStage(index: 0),
            ClusterStage(index: 1),
            ClusterStage(index: 2),
          ],
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}
