import 'package:car_services_app/services/firebase_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersPageModelView {
  FirestoreDB firestoreDB = FirestoreDB();
  String referencePath = 'orders';

  Stream<QuerySnapshot> takeOrderList() {
    return firestoreDB.getOrderListFromApi(referencePath);
  }
}
