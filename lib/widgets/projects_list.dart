import 'package:flutter/material.dart';
import 'package:swifty_companion/models/User.dart';

class Projects extends StatelessWidget {
  const Projects({super.key, required this.projects});
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            // DateTime marked_at = DateTime.parse(projects[index].marked_at);
            // print("Marked at: ${marked_at.day}/${marked_at.month}/${marked_at.year}");
            // final marked_at = DateTime.parse(projects[index].markedAt);
            // print(marked_at.day);
            if (projects[index].cursusIds == 21) {
              return Card(
                color: Colors.grey.shade200,
                child: ListTile(
                  title: Text(projects[index].name),
                  subtitle: Text(projects[index].markedAt),
                  // subtitle: Text(projects[index].markedAt != "Unavailable" ?
                  //     "Marked at: ${marked_at.day}/${marked_at.month}/${marked_at.year}" : "Unavailable"),
                  trailing: projDetail(index),
                ),
              );
            } else if (projects[index].cursusIds == 9) {
              return Card(
                color: Colors.grey.shade200,
                child: ListTile(
                  title: Text(projects[index].name),
                  trailing: projDetail(index),
                ),
              );
            }
          },
        ));
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
