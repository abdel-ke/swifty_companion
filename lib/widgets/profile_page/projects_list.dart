import 'package:flutter/material.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:timeago/timeago.dart' as timeago;

class Projects extends StatelessWidget {
  Projects({super.key, required this.projects, required this.grade});
  final List<Project> projects;
  final String grade;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return projects.isEmpty
        ? const SizedBox(
            height: 150,
            child: Center(child: Text('No Projects data available')))
        : Container(
            color: Theme.of(context).colorScheme.primary,
            height: 250,
            child: ListView.builder(
              itemCount: projects.length,
              controller: _controller,
              itemBuilder: (context, index) {
                if (projects[index].cursusIds == 21) {
                  return Card(
                    color: Theme.of(context).colorScheme.background,
                    child: ListTile(
                      title: Text(projects[index].name),
                      subtitle: timeAgo(projects[index].markedAt),
                      trailing: projDetail(index),
                    ),
                  );
                } else if (projects[index].cursusIds != 21 &&
                    grade == "Novice") {
                  return Card(
                    color: Theme.of(context).colorScheme.background,
                    child: ListTile(
                      title: Text(projects[index].name),
                      trailing: projDetail(index),
                    ),
                  );
                }
                return null;
              },
            ));
  }

  Text timeAgo(String markedAt) {
    if (markedAt != "Unavailable") {
      return Text(timeago.format(DateTime.parse(markedAt)));
    } else {
      return const Text('');
    }
  }

  Text projDetail(int index) {
    if (projects[index].status == "finished") {
      return Text(
        '${projects[index].finalMark.toString()}%',
        style: TextStyle(
            color: projects[index].validated
                ? Colors.green.shade800
                : Colors.red.shade800),
      );
    } else {
      return Text(
        "In progress",
        style: TextStyle(color: Colors.green.shade800),
      );
    }
  }
}
