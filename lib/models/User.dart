class User {
  String email;
  String login;
  String fullName;
  String imageUrl;
  String location;
  double level;
  int correctionPoint;
  int wallet;
  String grade;

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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? "Unavailable",
      login: json['login'] ?? "Unavailable",
      fullName: json['usual_full_name'] ?? "Unavailable",
      imageUrl: json['image']['versions']['small'] ?? "Unavailable",
      location: json['location'] ?? 'Unavailable',
      level: json['cursus_users'][1]['level'] ?? 0,
      grade: json['cursus_users'][1]['grade'] ?? "Unavailable",
      correctionPoint: json['correction_point'] ?? 0,
      wallet: json['wallet'] ?? 0,
    );
  }
}
