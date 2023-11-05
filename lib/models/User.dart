class User {
  String email;
  String login;
  // String firstName;
  // String lastName;
  String fullName;
  String imageUrl;
  String location;
  double level;

  User(
      {required this.email,
      required this.login,
      // required this.firstName,
      // required this.lastName,
      required this.fullName,
      required this.imageUrl,
      required this.location,
      required this.level
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      login: json['login'],
      // firstName: json['first_name'],
      // lastName: json['last_name'],
      fullName: json['usual_full_name'],
      imageUrl: json['image']['versions']['small'],
      location: json['location'] ?? 'Unavailable',
      level: json['cursus_users'][1]['level'],
    );
  }
}
