import 'package:flutter/material.dart';
import 'package:swifty_companion/views/login_page/login_page.dart';
import 'package:swifty_companion/views/search_page/search_user.dart';
import 'package:swifty_companion/views/profile_page/user_profile.dart';
import 'package:swifty_companion/views/profile_page/my_profile.dart';
import 'package:swifty_companion/views/ranking_page/ranking_list.dart'; 
import 'package:swifty_companion/views/clusters/kh_clusters.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => const LoginPage(),
  '/search': (context) => const SearchPage(),
  '/user': (context) => const UserProfile(),
  '/myuser': (context) => const MyProfile(),
  '/ranking': (context) => const RankingList(),
  '/cluster': (context) => const KHClusters(),
};
