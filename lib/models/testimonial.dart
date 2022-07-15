import 'package:flutter/material.dart';

class Testimonial {
  final String text;
  final String company;
  final String projectName;
  final String commenter;
  final String post;

  Testimonial({
    @required this.text,
    @required this.commenter,
    @required this.company,
    @required this.post,
    @required this.projectName,
  });
}
