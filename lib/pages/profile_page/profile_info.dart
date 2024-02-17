import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:swifty_companion/pages/Skeletonizer/skeletonizer_profile.dart';
import 'package:swifty_companion/pages/profile_page/user_profile.dart';
import 'package:swifty_companion/providers/provider.dart';
import 'package:swifty_companion/widgets/profile_page/projects_list.dart';
import 'package:swifty_companion/widgets/profile_page/skills_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key, required this.login});
  final String login;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late User data = User.empty();
  late Coalition coalition = Coalition.empty();
  bool isLoading = true;

  loadUser() async {
    try {
      User user = await Provider.of<MyProvider>(context, listen: false)
          .auth
          .fetchUser(widget.login);
      if (!context.mounted) return;
      Coalition coal = await Provider.of<MyProvider>(context, listen: false)
          .auth
          .fetchCoalition(widget.login);
      if (context.mounted) {
        setState(() {
          data = user;
          coalition = coal;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      print('error: can\'t load user info');
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // return const Center(child: CircularProgressIndicator());
      return const SkeletonizerProfile();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: coalition.color,
        elevation: 0,
        title: Text(
          data.fullName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.launch),
            onPressed: () async {
              final Uri url = Uri.parse(
                  'https://profile.intra.42.fr/users/${widget.login}');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              userInfo(context, data, coalition),
              infoC(data, coalition),
              Projects(
                projects: data.projects,
                grade: data.grade,
              ),
              SkillsList(skills: data.skills),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
