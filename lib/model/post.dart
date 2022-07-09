import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postUrl;
  bool isVerified;
  Post({required this.postUrl, this.isVerified = false});

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      postUrl: snapshot['postUrl'],
      isVerified: snapshot['isVerified'],
    );
  }

  Map<String, dynamic> toJson() => {
        'postUrl': postUrl,
        'isVerified': isVerified,
      };
}
