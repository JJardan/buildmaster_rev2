import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/data_keys.dart';
import '../model/career_model.dart';

class CareerService {
  Future uploadNewCareer(CareerModel careerModel, String careerKey, String userKey) async {
    DocumentReference<Map<String, dynamic>> careerDocReference =
    FirebaseFirestore.instance.collection(COL_CAREERS).doc(careerKey);
    DocumentReference<Map<String, dynamic>> userCareerDocReference =
    FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(COL_USERS_CAREERS)
        .doc(careerKey);
    final DocumentSnapshot documentSnapshot = await careerDocReference.get();

    if (!documentSnapshot.exists) {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(careerDocReference, careerModel.toJson());
        transaction.set(userCareerDocReference, careerModel.toMinJson());
      });
      await careerDocReference.set(careerModel.toJson());
    }
  }

  Future<CareerModel> getCareer(String productKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance.collection(COL_CAREERS).doc(productKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
    await documentReference.get();
    CareerModel careerModel = CareerModel.fromSnapshot(documentSnapshot);
    return careerModel;
  }

  Future<List<CareerModel>> getAllCareers() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
    FirebaseFirestore.instance.collection(COL_CAREERS);
    QuerySnapshot<Map<String, dynamic>> snapshots =
    await collectionReference.get();

    List<CareerModel> careers = [];

    for (int i = 0; i < snapshots.size; i++) {
      CareerModel productModel =
      CareerModel.fromQuerySnapshot(snapshots.docs[i]);
      careers.add(productModel);
    }

    return careers;
  }
}
