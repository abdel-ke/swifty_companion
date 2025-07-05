import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/constants/constant.dart';
import 'package:swifty_companion/models/ranking.dart';
import 'package:swifty_companion/views/Skeletonizer/Skeletonizer_rank_page.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/drawer.dart';
import 'package:swifty_companion/widgets/profile_page/user_card.dart';

class RankingList extends StatefulWidget {
  const RankingList({super.key});

  @override
  MyRankingListState createState() => MyRankingListState();
}

class MyRankingListState extends State<RankingList> {
  List<Ranking> data = [];
  int page = 1;
  bool isLoading = false;
  final ScrollController _controller =
      ScrollController(); // Declare and initialize _controller

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final promo = Provider.of<MyProvider>(context, listen: false).promo;
      final city = promo.split(' ')[0];
      final selectedPromo = promo.split(' ')[1];
      late final int cursusId;
      switch (city) {
        case 'Khouribga':
          cursusId = KHOURIBGAID;
          break;
        case 'BenGuerir':
          cursusId = BENGURIRID;
          break;
        case 'Tetouan':
          cursusId = MEDID;
          break;
        default:
          cursusId = RABATID;
          break;
      }
      List<Ranking> newData = await Provider.of<MyProvider>(
        context,
        listen: false,
      ).auth.fetchPromo(cursusId, city, selectedPromo, page);
      setState(() {
        data.addAll(newData);
        page++;
        isLoading = false;
      });
    } catch (e) {
      print('error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Ranking List'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Change this value as needed
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 230,
          ),
          itemCount: data.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == data.length) {
              return const SkeletonizerCardUser();
            } else {
              return CardUser(data: data[index], index: index);
            }
          },
          controller:
              _controller..addListener(() {
                if (!isLoading && _controller.position.extentAfter < 20) {
                  _loadData();
                }
              }),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
