import 'package:cloud_firestore/cloud_firestore.dart';

class TipModel {
  static const TITLE = "title";
  static const BODY = "body";
  static const SENDERID = "senderID";
  static const IMAGES = "images";
  static const TAGS = "tags";
  static const MATERNITY = "maternity";
  static const DATEOFPOSTING = "dateOfPosting";

  int _dateOfPosting;
  int _imagesCount;
  String _title;
  String _id;
  String _body;
  String _senderID;
  List<dynamic> _tags;
  List<dynamic> _images;

  int get time => _dateOfPosting;
  int get imagesCount => _imagesCount;
  String get title => _title;
  String get body => _body;
  String get id => _id;
  String get senderID => _senderID;
  List<dynamic> get tags => _tags;
  List<dynamic> get images => _images;

  set imageCount(int value) {
    _imagesCount = value;
  }

  TipModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map pp = snapshot.data() as Map;

    _title = pp[TITLE];
    _body = pp[BODY];
    _tags = pp[TAGS];
    _id = snapshot.id;
    _images = pp[IMAGES];
    _dateOfPosting = pp[DATEOFPOSTING];
    _senderID = pp[SENDERID];

    if (images == null) {
      _imagesCount = 0;
    } else {
      _imagesCount = _images.length;
    }
  }
}
