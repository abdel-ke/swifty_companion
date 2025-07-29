import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String selected = "current"; // Default value for the dropdown menu
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
      print('selected: $selected');
      
      if (selected == 'current') {
        // For current students, load one page at a time
        List<Ranking> newData = await Provider.of<MyProvider>(
          context,
          listen: false,
        ).auth.fetchPromo(cursusId, city, selectedPromo, page);
        
        setState(() {
          data.addAll(newData);
          page++;
          isLoading = false;
        });
        
        print('Loaded page ${page - 1}: ${newData.length} items. Total: ${data.length}');
      } else {
        // For alumni, keep fetching until we get empty data
        while (true) {
          List<Ranking> newData = await Provider.of<MyProvider>(
            context,
            listen: false,
          ).auth.fetchAlumniPromo(cursusId, city, selectedPromo, page);
          
          // Break if no more data
          if (newData.isEmpty) {
            print('No more alumni data available at page $page');
            break;
          }
          
          setState(() {
            data.addAll(newData);
            page++;
          });
          
          print('Loaded alumni page ${page - 1}: ${newData.length} items. Total: ${data.length}');
          
          // Optional: Add a small delay to prevent overwhelming the server
          await Future.delayed(const Duration(milliseconds: 100));
        }
        
        setState(() {
          isLoading = false;
        });
        
        print('Finished loading all alumni data. Total items: ${data.length}');
        
        Clipboard.setData(
          ClipboardData(text: 'Alumni data loaded: ${jsonEncode(data)}'),
        );
      }
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
        child: Column(
          children: [
            Row(
              children: [
                DropdownMenu(
                  initialSelection: 'current',
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'alumni', label: 'Alumni'),
                    DropdownMenuEntry(value: 'current', label: 'Current'),
                  ],
                  onSelected: (value) {
                    if (value == 'alumni' && selected != 'alumni') {
                      setState(() {
                        selected = 'alumni';
                        data.clear();
                        page = 1;
                        isLoading = false;
                      });
                      _loadData();
                    } else if (value == 'current' && selected != 'current') {
                      setState(() {
                        selected = 'current';
                        data.clear();
                        page = 1;
                        isLoading = false;
                      });
                      _loadData();
                    }
                  },
                ),
                const Spacer(),
                Text(selected == 'alumni' ? data.length.toString(): '',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
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
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
