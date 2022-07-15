import 'package:flutter/material.dart';

class ServiceModel {
  final String name;
  final String image;
  final Color color;
  final String id;
  final String desc;
  final IconData icon;

  ServiceModel({
    @required this.name,
    @required this.id,
    @required this.color,
    @required this.image,
    @required this.desc,
    @required this.icon,
  });
}
