import 'package:cloud_firestore/cloud_firestore.dart';

class CareerModel {
  static const DIRECTORY = "career";

  static const TITLE = "title";
  static const DESC = "desc";
  static const DATE = "date";
  static const ADDER = "adder";
  static const DEADLINE = "deadline";
  static const ROLES = "roles";
  static const QUALIFICATIONS = "qualifications";

  String _title;
  String _id;
  String _desc;
  String _roles;
  String _qualification;

  String get title => _title;
  String get desc => _desc;
  String get roles => _roles;
  String get id => _id;
  String get qualifications => _qualification;

  CareerModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.id;
    Map pp = snapshot.data() as Map;

    _qualification = pp[QUALIFICATIONS];
    _desc = pp[DESC];
    _roles = pp[ROLES];
    _title = pp[TITLE];
  }
}
