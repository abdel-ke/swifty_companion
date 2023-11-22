Map<String, Object> obj = {
  "title": "Dart Tutorial",
  "description": "Way to parse Json",
  "author": {"name": "bezkoder", "age": 30},
  "tags": [
    {"name": "dart", "quantity": 12},
    {"name": "flutter", "quantity": 25}
  ]
};

class Tutorial {
  final String title;
  final String descrip;
  final User author;
  final List<Tags> tags;
  Tutorial({
    required this.title,
    required this.descrip,
    required this.author,
    required this.tags,
  });

  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      title: json['title'],
      descrip: json['description'],
      author: User.fromJson(json['author']),
      tags: Tags.fromListJsom(json["tags"]),
      // tags: (json['tags'] as List).map((e) => Tags.fromJson(e)).toList());
    );
  }

  display() {
    print('{');
    print('\t"title": "$title",');
    print('\t"description": "$descrip",');
    print('\t"author": {');
    print('\t\t"name": "${author.name}",');
    print('\t\t"age": "${author.age}",');
    print('\t}');
    print('\t"tags": {');
    for (var element in tags) {
      print('\t{');
      print('\t\t"name": "${element.name}"');
      print('\t\t"quantity": "${element.quantity}"');
      print('\t},');
    }
    print('}');
  }
}

class User {
  final String name;
  final int age;
  User({
    required this.name,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], age: json['age']);
  }
}

class Tags {
  final String name;
  final int quantity;

  Tags({
    required this.name,
    required this.quantity,
  });
  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(name: json['name'], quantity: json['quantity']);
  }

  static List<Tags> fromListJsom(List<dynamic> listJson) {
    List<Tags> tags = [];
    for (var elem in listJson) {
      tags.add(Tags.fromJson(elem));
    }
    return tags;
  }
}

void main() {
  Tutorial t = Tutorial.fromJson(obj);
  t.display();
}
