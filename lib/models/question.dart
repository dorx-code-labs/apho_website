import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  static const DIRECTORY = "questions";

  static const TITLE = "title";
  static const APPROVED = "approved";
  static const REJECTED = "rejected";
  static const SENDERID = "senderID";
  static const BODY = "body";
  static const REASON = "reason";

  static const QUESTION = "question";
  static const ANSWER = "answer";
  static const IMAGES = "images";
  static const TAGS = "tags";
  static const PENDING = "pending";
  static const DATEOFPOSTING = "dateOfPosting";
  static const PRIVATE = "private";

  int _dateOfPosting;
  int _imagesCount;
  bool _private;
  String _reason;
  bool _rejected;
  bool _approved;
  bool _pending;
  String _title;
  String _id;
  String _body;
  String _answer;
  String _senderID;
  List<dynamic> _tags;
  List<dynamic> _images;

  int get time => _dateOfPosting;
  int get imagesCount => _imagesCount;
  String get reason => _reason;
  bool get private => _private ?? true;
  bool get approved => _approved ?? true;
  bool get rejected => _rejected ?? false;
  bool get pending => _pending ?? false;
  String get answer => _answer;
  String get title => _title;
  String get body => _body;
  String get id => _id;
  String get senderID => _senderID;
  List<dynamic> get tags => _tags;
  List<dynamic> get images => _images;

  set imageCount(int value) {
    _imagesCount = value;
  }

  QuestionModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map pp = snapshot.data() as Map;

    _title = pp[TITLE];
    _body = pp[BODY];
    _tags = pp[TAGS];
    _rejected = pp[REJECTED];
    _approved = pp[APPROVED];
    _pending = pp[PENDING];
    _id = snapshot.id;
    _images = pp[IMAGES];
    _answer = pp[ANSWER];
    _reason = pp[REASON];
    _dateOfPosting = pp[DATEOFPOSTING];
    _senderID = pp[SENDERID];
    _private = pp[PRIVATE];

    _private ??= false;

    if (images == null) {
      _imagesCount = 0;
    } else {
      _imagesCount = _images.length;
    }
  }
}
