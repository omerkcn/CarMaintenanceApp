import 'package:car_services_app/services/firebase_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInPageModelView {
  FirestoreDB firestoreDB = FirestoreDB();

  Future<DocumentSnapshot> getEmailListFromApi() {
    return firestoreDB.getWithFutureFromApi('emails', 'emails');
  }
}
