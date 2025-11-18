class User {
  final int? id;
  final String name;
  final String email;

  User({this.id, required this.name, required this.email});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    name: json['name'] as String,
    email: json['email'] as String,
  );
}

