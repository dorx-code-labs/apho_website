import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  final Function onPulessed;
  CommentButton({Key key, this.onPulessed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_comment_outlined, color: Colors.purple,),
      onPressed: onPulessed,
    );
  }
}