final Map<String, List<String>> generation = {
  'Khouribga': [
    '1st promo 10/2018',
    '2nd promo 04/2019',
    '3rd promo 10/2019',
    '4th promo 10/2021',
    '5th promo 10/2022',
    '6th promo 10/2023',
  ],
  'BenGuerir': [
    '1st promo 10/2019',
    '2nd promo 10/2021',
    '3rd promo 10/2022',
    '4th promo 10/2023',
  ],
  'Med': [
    '1st promo 10/2021',
  ],
};


final promo = {
  "Khouribga": {
    "1st": "2018-10-02T22:00:00.000Z,2018-10-04T01:32:41.658Z",
    "2nd": "2019-03-24T23:00:00.000Z,2019-03-28T00:00:00.000Z",
    "3rd": "2019-10-16T00:00:00.000Z,2019-10-17T00:00:00.000Z",
    "4th": "2021-11-01T00:00:00.000Z,2021-12-01T00:00:00.000Z",
    "5th": "2022-10-05T07:00:00.000Z,2022-10-08T07:00:00.000Z",
    "6th": "2023-10-30T08:37:00.000Z,2023-11-01T08:37:00.000Z",
  },
  "BenGuerir": {
    "1st": "2019-10-09T07:37:00.000Z,2019-10-12T00:00:00.000Z",
    "2nd": "2021-11-01T08:00:00.000Z,2021-11-10T00:00:00.000Z",
    "3rd": "2022-10-05T00:00:00.000Z,2022-10-08T00:00:00.000Z",
    "4th": "2023-10-30T08:37:00.000Z,2023-11-01T08:37:00.000Z",
  },
  "Med": {
    "1st": "2022-09-28T07:00:00.000Z,2022-09-30T08:00:00.000Z",
  }
};

class Ranking {
  final String grade;
  final double level;
  final String blackholedAt;
  final String login;
  final String fullName;
  final String imageUrl;
  final String location;
  final bool alumni;

  Ranking({
    required this.grade,
    required this.level,
    required this.blackholedAt,
    required this.login,
    required this.fullName,
    required this.imageUrl,
    required this.location,
    required this.alumni,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
      grade: json["grade"] ?? "null",
      level: json["level"] ?? 0.0,
      blackholedAt: json["blackholed_at"] ?? "null",
      login: json["user"]["login"] ?? "null",
      fullName: json["user"]["usual_full_name"] ?? "null",
      imageUrl: json["user"]["image"]["link"] ?? "3b3",
      location: json["user"]["location"] ?? "null",
      alumni: json['user']['alumni?'] ?? false,
    );
  }

  static List<Ranking> fromListJson(List<dynamic> listJson) {
    List<Ranking> rankings = [];
    for (Map<String, dynamic> json in listJson) {
      rankings.add(Ranking.fromJson(json));
    }
    return rankings;
  }
}
