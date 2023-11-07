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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? "Unavailable",
      login: json['login'] ?? "Unavailable",
      fullName: json['usual_full_name'] ?? "Unavailable",
      imageUrl: json['image']['versions']['small'] ?? "Unavailable",
      location: json['location'] ?? '-',
      level: json['cursus_users'][1]['level'] ?? 0,
      grade: json['cursus_users'][1]['grade'] ?? "Unavailable",
      blackholedAt: json['cursus_users'][1]['blackholed_at'] ?? "null",
      correctionPoint: json['correction_point'] ?? 0,
      wallet: json['wallet'] ?? 0,
      city: json['campus'][0]['city'] ?? "Unavailable",
      phone: json['phone'] ?? "-",
      // projects: List<Project>.from(
      //     json['projects_users'].map((x) => Project.fromJson(x))),
      projects: (json['projects_users'] as List)
          .map((projectJson) => Project.fromJson(projectJson))
          .toList(),
    );
  }
}

class Project {
  int finalMark;
  bool validated;
  String name;
  String markedAt;

  Project({
    required this.finalMark,
    required this.validated,
    required this.name,
    required this.markedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      finalMark: json['final_mark'] ?? 0,
      validated: json['validated?'] ?? false,
      name: json['project']['name'] ?? "Unavailable",
      markedAt: json['marked_at'] ?? "Unavailable",
    );
  }
}