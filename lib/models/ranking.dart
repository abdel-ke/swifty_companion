final dateStirng = [
  "",
  "2018-10-02T22:00:00.000Z,2018-10-04T01:32:41.658Z",
  "2019-03-24T23:00:00.000Z,2019-03-28T00:00:00.000Z",
  "2019-10-16T00:00:00.000Z,2019-10-17T00:00:00.000Z",
  "2021-11-01T00:00:00.000Z,2021-12-01T00:00:00.000Z",
  "2019-10-09T07:37:00.000Z,2019-10-12T00:00:00.000Z",
  "2021-11-01T08:00:00.000Z,2021-11-10T00:00:00.000Z",
  "2022-10-01T00:00:00.000Z,2022-10-29T00:00:00.000Z",
  "2022-09-01T00:00:00.000Z,2022-09-29T08:00:00.000Z",
];

class Ranking {
  final List<String>? grade;
  final List<double>? level;
  final List<String> blackholedAt;
  final List<String> login;
  final List<String> fullName;
  final List<String> imageUrl;
  final List<String> location;
  Ranking({
    required this.grade,
    required this.level,
    required this.blackholedAt,
    required this.login,
    required this.fullName,
    required this.imageUrl,
    required this.location,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
        grade: json["grade"] as List<String>,
        level: json["level"] as List<double>,
        blackholedAt: json["blackholed_at"] as List<String>,
        login: json["user"]["login"] as List<String>,
        fullName: json["user"]["usual_full_name"] as List<String>,
        imageUrl: json["user"]["image"]["versions"]["medium"]["imageUrl"] as List<String>,
        location: json["user"]["location"] as List<String>,
        );
  }
}
