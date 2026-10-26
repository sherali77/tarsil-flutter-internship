class Comment {
  String name = "";
  String email = "";
  String body = "";
  Comment({required this.name, required this.email, required this.body});
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}
