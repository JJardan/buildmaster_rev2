import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/data_keys.dart';
import 'career_model.dart';

class UserModel {
  late String userKey;
  late String userEmail;
  late bool varifiedUserEmail;
  late DateTime signupDate;
  late String profileName;
  late String profileImageUrl;
  late String profileNationality;
  late bool findWork;
  late bool workingAbroad;
  late List<CareerModel> careers;
  DocumentReference? reference;
  UserModel({
    required this.userKey,
    required this.userEmail,
    required this.varifiedUserEmail,
    required this.profileName,
    required this.profileImageUrl,
    required this.profileNationality,
    required this.findWork,
    required this.workingAbroad,
    required this.careers,
    required this.signupDate,
    this.reference
  });

  UserModel.fromJson(dynamic json, this.userKey, this.reference) {
    userEmail = json[DOC_USEREMAIL];
    signupDate = json[DOC_SIGNUPDATE] == null
        ? DateTime.now().toUtc()
        : (json[DOC_SIGNUPDATE] as Timestamp).toDate();
    profileName = json[DOC_PROFILENAME];
    profileImageUrl = json[DOC_PROFILEIMAGEURL]??"";
    profileNationality = json[DOC_PROFILENATIONALITY]??"";
    careers = json[DOC_CAREERS]??[];
    varifiedUserEmail = json[DOC_VARIFIEDUSEREMAIL]??false;
    findWork = json[DOC_FINDWORK]??false;
    workingAbroad = json[DOC_WORKINGABROAD]??false;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[DOC_USEREMAIL] = userEmail;
    map[DOC_SIGNUPDATE] = signupDate;
    map[DOC_PROFILENAME] = profileName;
    map[DOC_PROFILEIMAGEURL] = profileImageUrl;
    map[DOC_PROFILENATIONALITY] = profileNationality;
    map[DOC_FINDWORK] = findWork;
    map[DOC_CAREERS] = careers;
    map[DOC_VARIFIEDUSEREMAIL] = varifiedUserEmail;
    map[DOC_WORKINGABROAD] = workingAbroad;
    return map;
  }

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

}