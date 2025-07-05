import 'package:flutter/material.dart';
import 'package:swifty_companion/widgets/clusters/med_cluster_stage.dart';
import 'package:swifty_companion/widgets/drawer.dart';

class MedCluster extends StatelessWidget {
  const MedCluster({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Tetouan Clusters'),
          bottom: TabBar(
            physics: const NeverScrollableScrollPhysics(),
            labelColor: Theme.of(context).appBarTheme.foregroundColor,
            indicatorColor: Colors.blue,
            tabs: const <Widget>[
              Tab(text: 'E1'),
              Tab(text: 'E2'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            MedClusterStage(index: 0),
            MedClusterStage(index: 1),
          ],
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}
