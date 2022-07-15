
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeReplyThingPerComment extends StatefulWidget {
  final Function onCommentPressed;
  final String commentID;
  final bool isTopLevelComment;

  LikeReplyThingPerComment({
    Key key,
    @required this.onCommentPressed,
    @required this.commentID,
    @required this.isTopLevelComment,
  }) : super(key: key);

  @override
  _LikeReplyThingPerCommentState createState() =>
      _LikeReplyThingPerCommentState();
}

class _LikeReplyThingPerCommentState extends State<LikeReplyThingPerComment> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("repliesToComments")
          .doc(widget.commentID)
          .collection(widget.commentID)
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              widget.isTopLevelComment
                  ? IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        widget.onCommentPressed();
                      })
                  : SizedBox(
                      width: 1,
                    )
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                snapshot.data.docs == null
                    ? SizedBox(
                        height: 1,
                      )
                    : Visibility(
                        visible: widget.isTopLevelComment,
                        child: Text(
                          "${snapshot.data.docs.length} replies",
                        ),
                      ),
                widget.isTopLevelComment
                    ? IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () {
                          widget.onCommentPressed();
                        },
                      )
                    : SizedBox(
                        width: 1,
                      ),
              ],
            ),
          );
        }
      },
    );
  }
}
