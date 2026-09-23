class User {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  final String id;
  final String username;
  final String email;
  final String password;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['user'] as String,
      email: json['email'] as String,
      password: json['senha'] as String,
    );
  }
}
