import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';

class Projects extends StatelessWidget {
  const Projects({super.key, required this.projects});
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return 
        Card(
          child: ListTile(
            title: Text(projects[index].name),
            subtitle: Text(projects[index].finalMark.toString()),
          ),
        );
      },
    );
  }
}
