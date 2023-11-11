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
  final List<Project> projects;
  final List<Skills> skills;

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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    int index = json['cursus_users']
        .indexWhere((element) => element['grade'] == 'Member');

    if (index == -1) {
      index = json['cursus_users']
          .indexWhere((element) => element['grade'] == 'Student');
    }

    if (index == -1) {
      index = json['cursus_users']
          .indexWhere((element) => element['grade'] == 'Learner');
    }

    if (index == -1) {
      index = json['cursus_users']
          .indexWhere((element) => element['grade'] == null);
    }
    return User(
      email: json['email'] ?? "Unavailable",
      login: json['login'] ?? "Unavailable",
      fullName: json['usual_full_name'] ?? "Unavailable",
      imageUrl: json['image']['versions']['small'] ?? "Unavailable",
      location: json['location'] ?? '-',
      level: json['cursus_users'][index]['level'] ?? 0,
      grade: json['cursus_users'][index]['grade'] ?? "Novice",
      blackholedAt: json['cursus_users'][index]['blackholed_at'] ?? "null",
      correctionPoint: json['correction_point'] ?? 0,
      wallet: json['wallet'] ?? 0,
      city: json['campus'][0]['city'] ?? "Unavailable",
      phone: json['phone'] ?? "-",
      projects: (json['projects_users'] as List)
          .map((projectJson) => Project.fromJson(projectJson))
          .toList(),
      skills: (json['cursus_users'][index]['skills'] as List)
          .map((skillJson) => Skills.fromJson(skillJson))
          .toList(),
    );
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
      status: json['status'],
      cursusIds: json['cursus_ids'][0] ?? 0,
    );
  }
}

class Skills {
  int id;
  String name;
  double level;

  Skills({
    required this.id,
    required this.name,
    required this.level,
  });
  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
        id: json['id'] ?? 0,
        name: json['name'] ?? "undefined",
        level: json['level'] ?? 0.0);
  }
}

class Coalition {
  String coverUrl;
  Color color;
  Coalition({
    required this.coverUrl,
    required this.color,
  });

  factory Coalition.fromJson(json) {
    if (json.isEmpty) {
      return Coalition(
          coverUrl:
              "https://profile.intra.42.fr/assets/background_login-a4e0666f73c02f025f590b474b394fd86e1cae20e95261a6e4862c2d0faa1b04.jpg",
          color: const Color(0xff02cdd1));
    }
    return Coalition(
      coverUrl: json[0]['cover_url'] ??
          "https://profile.intra.42.fr/assets/background_login-a4e0666f73c02f025f590b474b394fd86e1cae20e95261a6e4862c2d0faa1b04.jpg",
      color: (json[0]['color'] != null && json[0]['color'].isNotEmpty)
          ? Color(int.parse('FF${json[0]['color'].substring(1)}', radix: 16))
          : const Color(0xff02cdd1),
    );
  }
}
