import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/data_keys.dart';

class CareerModel {
  late String careerKey;
  late String ownerKey;
  late String departmentCategory;
  late String positionCategory;
  late String positionDetail;
  late String companyDescription;
  late DateTime beginDate;
  late DateTime endDate;
  late String detailDescription;
  late num annualSalary;
  late bool findWork;
  late bool masterCareerVerified;
  late String ownerName;
  late String ownerImageUrl;
  late DateTime uploadTime;
  DocumentReference? reference;
  CareerModel(
      {required this.careerKey,
      required this.ownerKey,
      required this.departmentCategory,
      required this.positionCategory,
      required this.positionDetail,
      required this.companyDescription,
      required this.beginDate,
      required this.endDate,
      required this.detailDescription,
      required this.annualSalary,
      required this.findWork,
      required this.masterCareerVerified,
      required this.uploadTime,
      this.reference});

  CareerModel.fromJson(dynamic json, this.careerKey, this.reference) {
    careerKey = json[DOC_CAREERKEY] ?? "";
    ownerKey = json[DOC_OWNERKEY] ?? "";
    departmentCategory = json[DOC_DEPARTMENTCATEGORY] ?? "";
    positionCategory = json[DOC_POSITIONCATEGORY] ?? "";
    positionDetail = json[DOC_POSITIONDETAIL] ?? "";
    companyDescription = json[DOC_COMPANYDESCRIPTION] ?? "";
    beginDate = json[DOC_BEGINDATE] ?? "";
    endDate = json[DOC_ENDDATE] ?? "";
    detailDescription = json[DOC_DETAILDESCRIPTION] ?? "";
    annualSalary = json[DOC_ANNUALSALARY] ?? 0;
    masterCareerVerified = json[DOC_MASTERCAREERVERIFIED] ?? false;
    uploadTime = (json['uploadTime'] == null)
        ? DateTime.now().toUtc()
        : (json['uploadTime'] as Timestamp).toDate();
    // tag = json['tag'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[DOC_CAREERKEY] = careerKey;
    map[DOC_OWNERKEY] = ownerKey;
    map[DOC_DEPARTMENTCATEGORY] = departmentCategory;
    map[DOC_POSITIONCATEGORY] = positionCategory;
    map[DOC_POSITIONDETAIL] = positionDetail;
    map[DOC_COMPANYDESCRIPTION] = companyDescription;
    map[DOC_BEGINDATE] = beginDate;
    map[DOC_ENDDATE] = endDate;
    map[DOC_DETAILDESCRIPTION] = detailDescription;
    map[DOC_ANNUALSALARY] = annualSalary;
    map[DOC_MASTERCAREERVERIFIED] = masterCareerVerified;
    map[DOC_OWNERNAME] = ownerName;
    map[DOC_OWNERIMAGEURL] = ownerImageUrl;
    map[DOC_UPLOADTIME] = uploadTime;
    return map;
  }

  CareerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);
  CareerModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);

  Map<String, dynamic> toMinJson() {
    final map = <String, dynamic>{};
    map[DOC_DEPARTMENTCATEGORY] = departmentCategory;
    map[DOC_POSITIONCATEGORY] = positionCategory;
    map[DOC_POSITIONDETAIL] = positionDetail;
    return map;
  }

  static String generateCareerKey(String uid){
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    return '${uid}_$timeInMilli';
  }
}
