import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:car_services_app/services/firebase_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePageViewModel {
  FirestoreDB firestoreDB = FirestoreDB();
  String collectionPath = 'users';

  Future<DocumentSnapshot> getProfileInfoFromApi() {
    return firestoreDB.getWithFutureFromApi(
        collectionPath, Auth().takingCurrentUserEmail()!);
  }

  Future<void> addNewProfileInfo(
      {required String email,
      required String myCarBrand,
      required String myCarFuelType,
      required String myCarGearType,
      required String myCarModel,
      required String myCarPlate,
      required int myCarYear}) async {
    ProfileInfo newProfileInfo = ProfileInfo(
        email: email,
        myCarBrand: myCarBrand,
        myCarFuelType: myCarFuelType,
        myCarGearType: myCarGearType,
        myCarModel: myCarModel,
        myCarPlate: myCarPlate,
        myCarYear: myCarYear);

    await firestoreDB.setWithFutureData(
        collectionPath: collectionPath,
        profileInfoAsMap: newProfileInfo.toMap());
  }
}
