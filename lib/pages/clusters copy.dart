import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Clusters extends StatelessWidget {
  const Clusters({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cluster'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'E1',
              ),
              Tab(
                text: 'E2',
              ),
              Tab(
                text: 'E3',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SvgPicture.asset(
                semanticsLabel: 'A red up arrow',
                '/assets/svg/khouribga-cluster-e1.svg'),
            FittedBox(
              child: SvgPicture.asset('/assets/svg/khouribga-cluster-e2.svg'),
            ),
            FittedBox(
              child: SvgPicture.asset('/assets/svg/khga-cluster-e3.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
