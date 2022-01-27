import 'package:car_services_app/models/profile_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreDB {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOrderListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  Future<DocumentSnapshot> getWithFutureFromApi(
      String collectionPath, String documentPath) {
    return _firestore.collection(collectionPath).doc(documentPath).get();
  }

  Future<void> updateEmails(List newEmailList) {
    return _firestore
        .collection('emails')
        .doc('emails')
        .update({'emails': newEmailList})
        .then((value) => print("Email Updated"))
        .catchError((error) => print("Failed to update email: $error"));
  }

  Future<void> setWithFutureData(
      {required String collectionPath,
      required Map<String, dynamic> profileInfoAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(ProfileInfo.fromMap(profileInfoAsMap).email)
        .set(profileInfoAsMap);
  }

  Future<void> setOrderFutureData(
      {required String collectionPath,
      required Map<String, dynamic> profileInfoAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(Uuid().v1())
        .set(profileInfoAsMap);
  }
}
