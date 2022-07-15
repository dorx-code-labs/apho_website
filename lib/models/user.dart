import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  static const DIRECTORY = "users";
  static const ACCOUNTTYPEDIRECTORY = "accountTypes";

  static const LASTLOGINTIME = "lastLogin";
  static const LASTLOGOUTTIME = "lastLogout";
  static const FCMTOKENS = "userFCMTokens";

  static const PHONENUMBER = "phoneNumber";
  static const PROFILEPIC = "profilePic";
  static const DEVICETOKEN = "deviceToken";
  static const TITLE = "title";
  static const TIMESSAVEDASFAVORITE = "timesSavedAsFavorite";
  static const RATING = "rating";
  static const SERVICEPROVIDER = "serviceProvider";
  static const SPECIALTY = "specialty";
  static const NAME = "name";
  static const EMAIL = "email";
  static const DATEOFJOINING = "dateOfJoining";
  static const WORKPLACE = "workPlace";

  static const MONDAYSTOP = "mondayStop";
  static const TUESDAYSTOP = "tuesdayStop";
  static const WEDNESDAYSTOP = "wednesdayStop";
  static const THURSDAYSTOP = "thursdayStop";
  static const FRIDAYSTOP = "fridayStop";
  static const SATURDAYSTOP = "saturdayStop";
  static const SUNDAYSTOP = "sundayStop";

  static const MONDAYSTART = "mondayStart";
  static const TUESDAYSTART = "tuesdayStart";
  static const WEDNESDAYSTART = "wednesdayStart";
  static const THURSDAYSTART = "thursdayStart";
  static const FRIDAYSTART = "fridayStart";
  static const SATURDAYSTART = "saturdayStart";
  static const SUNDAYSTART = "sundayStart";

  static const RATINGCOUNT = "ratingCount";

  static const DUEDATEDIRECTORY = "dueDates";

  int _timesSavedAsFavorite;
  int _dateOfJoining;
  String _rating;
  bool _serviceProvider;

  String _id;
  String _specialty;
  String _name;
  String _email;
  String _workPlace;
  String _profilePic;
  String _title;
  String _phoneNumber;
  String _deviceToken;
  dynamic _rt;
  dynamic _rtCount;

  int _mondayStart;
  int _mondayStop;
  int _tuesdayStart;
  int _tuesdayStop;
  int _wednesdayStart;
  int _wednesdayStop;
  int _thursdayStart;
  int _thursdayStop;
  int _fridayStart;
  int _fridayStop;
  int _saturdayStart;
  int _saturdayStop;
  int _sundayStart;
  int _sundayStop;

  String get rating => _rating;
  bool get serviceProvider => _serviceProvider;
  int get dateOfJoining => _dateOfJoining;
  String get specialty => _specialty;
  String get name => _name;
  dynamic get rt => _rt;
  dynamic get rtCount => _rtCount;
  String get workplace => _workPlace;
  String get email => _email;
  int get timesSavedAsFavorite => _timesSavedAsFavorite;
  String get id => _id;
  String get profilePic => _profilePic;
  String get title => _title;
  String get phoneNumber => _phoneNumber;
  String get deviceToken => _deviceToken;

  int get mondayStart => _mondayStart;
  int get tuesdayStart => _tuesdayStart;
  int get wednesdayStart => _wednesdayStart;
  int get thursdayStart => _thursdayStart;
  int get fridayStart => _fridayStart;
  int get saturdayStart => _saturdayStart;
  int get sundayStart => _sundayStart;

  int get mondayStop => _mondayStop;
  int get tuesdayStop => _tuesdayStop;
  int get wednesdayStop => _wednesdayStop;
  int get thursdayStop => _thursdayStop;
  int get fridayStop => _fridayStop;
  int get saturdayStop => _saturdayStop;
  int get sundayStop => _sundayStop;

  UserModel.fromData({
    @required String phoneNumber,
    @required String username,
    @required String profilePic,
    @required String email,
  }) {
    _phoneNumber = phoneNumber;
    _email = email;
    _name = username;
    _profilePic = profilePic;
  }

  UserModel.fromSnapshot(
    DocumentSnapshot snapshot,
  ) {
    Map pp = snapshot.data() as Map;

    if (pp[TIMESSAVEDASFAVORITE] == null) {
      _timesSavedAsFavorite = 0;
    } else {
      _timesSavedAsFavorite = pp[TIMESSAVEDASFAVORITE];
    }

    _mondayStart = pp[MONDAYSTART];
    _dateOfJoining = pp[DATEOFJOINING];
    _mondayStop = pp[MONDAYSTOP];
    _tuesdayStart = pp[TUESDAYSTART];
    _tuesdayStop = pp[TUESDAYSTOP];
    _wednesdayStart = pp[WEDNESDAYSTART];
    _wednesdayStop = pp[WEDNESDAYSTOP];
    _thursdayStart = pp[THURSDAYSTART];
    _thursdayStop = pp[THURSDAYSTOP];
    _fridayStart = pp[FRIDAYSTART];
    _fridayStop = pp[FRIDAYSTOP];
    _saturdayStart = pp[SATURDAYSTART];
    _saturdayStop = pp[SATURDAYSTOP];
    _sundayStart = pp[SUNDAYSTART];
    _sundayStop = pp[SUNDAYSTOP];

    _name = pp[NAME] ?? "";
    _phoneNumber = pp[PHONENUMBER];

    _rt = pp[RATING] ?? 0;
    _rtCount = pp[RATINGCOUNT] ?? 0;

    if (pp[RATING] == null) {
      _rating = "No rating yet";
    } else if (pp[RATING] <= 1.0) {
      _rating = "1 Star rating";
    } else if (pp[RATING] <= 2.0) {
      _rating = "2 Star rating";
    } else if (pp[RATING] <= 3.0) {
      _rating = "3 Star rating";
    } else if (pp[RATING] <= 4.0) {
      _rating = "4 Star rating";
    } else if (pp[RATING] <= 5.0) {
      _rating = "5 Star rating";
    } else {
      _rating = "";
    }

    _serviceProvider = pp[SERVICEPROVIDER] ?? false;

    _specialty = pp[SPECIALTY];
    _workPlace = pp[WORKPLACE];
    _profilePic = pp[PROFILEPIC];

    if (_serviceProvider && (pp[TITLE] == null || pp[TITLE].trim().isEmpty)) {
      _title = "Doctor";
    } else if (_serviceProvider && pp[TITLE] != null) {
      _title = pp[TITLE];
    } else {
      _title = "";
    }

    _deviceToken = pp[DEVICETOKEN];
    _id = snapshot.id;
  }
}
