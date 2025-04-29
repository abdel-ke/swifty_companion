import 'package:flutter/material.dart';

class User {
  final String email;
  final String login;
  final String fullName;
  final String imageUrl;
  final String location;
  final double level;
  final int correctionPoint;
  final int wallet;
  final String grade;
  final String city;
  final String phone;
  final String blackholedAt;
  final bool alumni;
  final List<Project> projects;
  final List<Skills> skills;

  User.empty()
    : email = '',
      login = '',
      fullName = '',
      imageUrl = '',
      location = '',
      level = 0.0,
      correctionPoint = 0,
      wallet = 0,
      grade = '',
      city = '',
      phone = '',
      blackholedAt = '',
      alumni = false,
      projects = [],
      skills = [];

  User({
    required this.email,
    required this.login,
    required this.fullName,
    required this.imageUrl,
    required this.location,
    required this.level,
    required this.correctionPoint,
    required this.wallet,
    required this.grade,
    required this.city,
    required this.phone,
    required this.blackholedAt,
    required this.projects,
    required this.skills,
    required this.alumni,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // int index = json['cursus_users']
    //     .indexWhere((element) => element['grade'] == 'Member');

    // if (index == -1) {
    //   index = json['cursus_users']
    //       .indexWhere((element) => element['grade'] == 'Student');
    // }

    // if (index == -1) {
    //   index = json['cursus_users']
    //       .indexWhere((element) => element['grade'] == 'Transcender');
    // }

    // if (index == -1) {
    //   index = json['cursus_users']
    //       .indexWhere((element) => element['grade'] == 'Learner');
    // }

    // if (index == -1) {
    //   index = json['cursus_users']
    //       .indexWhere((element) => element['grade'] == null);
    // }
    // if length is 2 set index to 1 insted set it to 0
    int index = 0;
    if (json['cursus_users'].length == 2) {
      index = 1;
    }
    return User(
      email: json['email'] ?? "Unavailable",
      login: json['login'] ?? "Unavailable",
      fullName: json['usual_full_name'] ?? "Unavailable",
      imageUrl: json['image']['link'] ?? "Unavailable",
      location: json['location'] ?? '-',
      level: json['cursus_users'][index]['level'] ?? 0,
      grade: json['cursus_users'][index]['grade'] ?? "Novice",
      blackholedAt: json['cursus_users'][index]['blackholed_at'] ?? "null",
      correctionPoint: json['correction_point'] ?? 0,
      wallet: json['wallet'] ?? 0,
      city: json['campus'][0]['city'] ?? "Unavailable",
      phone: json['phone'] ?? "-",
      alumni: json['alumni?'],
      projects:
          (json['projects_users'] as List).map((projectJson) {
            return Project.fromJson(projectJson);
          }).toList(),
      skills:
          (json['cursus_users'][index]['skills'] as List)
              .map((skillJson) => Skills.fromJson(skillJson))
              .toList(),
    );
  }

  static List<User> fromListJson(List<dynamic> jsonList) {
    return jsonList.map((user) => User.fromJson(user)).toList();
  }
}

class Project {
  int finalMark;
  bool validated;
  String name;
  String markedAt;
  String status;
  int cursusIds;

  Project({
    required this.finalMark,
    required this.validated,
    required this.name,
    required this.markedAt,
    required this.status,
    required this.cursusIds,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      finalMark: json['final_mark'] ?? 0,
      validated: json['validated?'] ?? false,
      name: json['project']['name'] ?? "Unavailable",
      markedAt: json['marked_at'] ?? "Unavailable",
      status: json['status'] ?? "null",
      // cursusIds: json['cursus_ids'][0] ?? 0,
      cursusIds:
          (json['cursus_ids'] as List).isNotEmpty ? json['cursus_ids'][0] : 0,
      // cursusIds: (json['cursus_ids'] as List).firstWhere((_) => true, orElse: () => 0),
    );
  }
}

class Skills {
  int id;
  String name;
  double level;

  Skills({required this.id, required this.name, required this.level});
  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      id: json['id'] ?? 0,
      name: json['name'] ?? "undefined",
      level: json['level'] ?? 0.0,
    );
  }
}

class Coalition {
  String coverUrl;
  Color color;

  Coalition.empty() : coverUrl = 'null', color = const Color(0xff02cdd1);

  Coalition({required this.coverUrl, required this.color});

  factory Coalition.fromJson(json) {
    if (json.isEmpty) {
      return Coalition(coverUrl: "null", color: const Color(0xff02cdd1));
    }
    return Coalition(
      coverUrl: json[0]['cover_url'] ?? "null",
      color:
          (json[0]['color'] != null && json[0]['color'].isNotEmpty)
              ? Color(
                int.parse('FF${json[0]['color'].substring(1)}', radix: 16),
              )
              : const Color(0xff02cdd1),
    );
  }
}

class SearchUser {
  String login;
  String imageUrl;

  SearchUser({required this.login, required this.imageUrl});

  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      login: json['login'] ?? "Unavailable",
      imageUrl: json['image']['link'] ?? "Unavailable",
    );
  }

  static List<SearchUser> fromListJson(List<dynamic> jsonList) {
    return jsonList.map((user) => SearchUser.fromJson(user)).toList();
  }
}
