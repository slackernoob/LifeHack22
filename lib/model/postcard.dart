import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap['photoUrl'],
              fit: BoxFit.cover,
            ),
          ),
          widget.snap['isVerified']
              ? Icon(
                  Icons.verified,
                  color: Colors.blue[500],
                )
              : Icon(Icons.cancel_sharp, color: Colors.red),
        ],
      ),
    );
  }
}
