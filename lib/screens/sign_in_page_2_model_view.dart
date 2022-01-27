import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/services/firebase_db.dart';

class SignInPage2ModelView {
  FirestoreDB firestoreDB = FirestoreDB();
  String collectionPath = 'users';

  Future<void> updateEmails(List newEmailList) async {
    await firestoreDB.updateEmails(newEmailList);
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
