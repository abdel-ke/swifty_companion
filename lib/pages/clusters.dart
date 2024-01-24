import 'package:flutter/material.dart';
import 'package:swifty_companion/widgets/drawer.dart';

// final map = {
//   "e1": [

//   ],
// };

final E1 = [
  [
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['e1r10p15', 'e1r10p14', 'e1r10p13', 'e1r10p12', 'e1r10p11'],
    ['e1r9p15', 'e1r9p14', 'e1r9p13', 'e1r9p12', 'e1r9p11'],
    ['e1r8p15', 'e1r8p14', 'e1r8p13', 'e1r8p12', 'e1r8p11'],
    ['e1r7p15', 'e1r7p14', 'e1r7p13', 'e1r7p12', 'e1r7p11'],
    ['e1r6p15', 'e1r6p14', 'e1r6p13', 'e1r6p12', 'e1r6p11'],
    ['e1r5p15', 'e1r5p14', 'e1r5p13', 'e1r5p12', 'e1r5p11'],
    ['e1r4p15', 'e1r4p14', 'e1r4p13', 'e1r4p12', 'e1r4p11'],
    ['e1r3p15', 'e1r3p14', 'e1r3p13', 'e1r3p12', 'e1r3p11'],
    ['e1r2p15', 'e1r2p14', 'e1r2p13', 'e1r2p12', 'e1r2p11'],
    ['', '', '', '', ''],
  ],
  [
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['', '', '', '', ''],
    ['e1r9p10', 'e1r9p9', 'e1r9p8', 'e1r9p7', 'e1r9p6'],
    ['e1r8p10', 'e1r8p9', 'e1r8p8', 'e1r8p7', 'e1r8p6'],
    ['e1r7p10', 'e1r7p9', 'e1r7p8', 'e1r7p7', 'e1r7p6'],
    ['e1r6p10', 'e1r6p9', 'e1r6p8', 'e1r6p7', 'e1r6p6'],
    ['e1r5p10', 'e1r5p9', 'e1r5p8', 'e1r5p7', 'e1r5p6'],
    ['e1r4p10', 'e1r4p9', 'e1r4p8', 'e1r4p7', 'e1r4p6'],
    ['e1r3p10', 'e1r3p9', 'e1r3p8', 'e1r3p7', 'e1r3p6'],
    ['e1r2p10', 'e1r2p9', 'e1r2p8', 'e1r2p7', 'e1r2p6'],
    ['', '', '', '', ''],
  ],
  [
    ['e1r13p5', 'e1r13p4', 'e1r13p3', 'e1r13p2', 'e1r13p1'],
    ['e1r12p5', 'e1r12p4', 'e1r12p3', 'e1r12p2', 'e1r12p1'],
    ['e1r11p5', 'e1r11p4', 'e1r11p3', 'e1r11p2', 'e1r11p1'],
    ['e1r10p5', 'e1r10p4', 'e1r10p3', 'e1r10p2', 'e1r10p1'],
    ['e1r9p5', 'e1r9p4', 'e1r9p3', 'e1r9p2', 'e1r9p1'],
    ['e1r8p5', 'e1r8p4', 'e1r8p3', 'e1r8p2', 'e1r8p1'],
    ['e1r7p5', 'e1r7p4', 'e1r7p3', 'e1r7p2', 'e1r7p1'],
    ['e1r6p5', 'e1r6p4', 'e1r6p3', 'e1r6p2', 'e1r6p1'],
    ['e1r5p5', 'e1r5p4', 'e1r5p3', 'e1r5p2', 'e1r5p1'],
    ['e1r4p5', 'e1r4p4', 'e1r4p3', 'e1r4p2', 'e1r4p1'],
    ['e1r3p5', 'e1r3p4', 'e1r3p3', 'e1r3p2', 'e1r3p1'],
    ['e1r2p5', 'e1r2p4', 'e1r2p3', 'e1r2p2', 'e1r2p1'],
    ['e1r1p5', 'e1r1p4', 'e1r1p3', 'e1r1p2', 'e1r1p1'],
  ],
];

class Clusters extends StatelessWidget {
  const Clusters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clusters'),
      ),
      body: Row(
        children: [
          const SizedBox(width: 10,),
          range(),
          const SizedBox(width: 10,),
          range(),
          const SizedBox(width: 10,),
          range(),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }

  Column range() {
    return Column(
          children: [
            SizedBox(
              height: 25,
              child: Row(children: [
                SizedBox(
                  child: Image.asset('assets/images/3b3.jpeg'),
                ),
                SizedBox(
                  child: Image.asset('assets/images/3b3.jpeg'),
                ),
                SizedBox(
                  child: Image.asset('assets/images/3b3.jpeg'),
                ),
                SizedBox(
                  child: Image.asset('assets/images/3b3.jpeg'),
                ),
                SizedBox(
                  child: Image.asset('assets/images/3b3.jpeg'),
                ),
              ]),
            ),
          ],
        );
  }
}
