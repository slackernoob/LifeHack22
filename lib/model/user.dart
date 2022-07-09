class User {
  final String email;
  final String uid;
  final num points;

  const User({required this.email, required this.uid, required this.points});

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "points": points,
      };
}
