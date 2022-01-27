import 'package:car_services_app/models/order.dart';
import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:car_services_app/services/firebase_db.dart';

class AddingOrderViewModel {
  FirestoreDB firestoreDB = FirestoreDB();
  String collectionPath = 'orders';

  Future<void> addNewOrder(ProfileInfo currentProfileInfo, String detail,
      String orderType, int cost) async {
    Order newOrder = Order(
      email: Auth().takingCurrentUserEmail()!,
      isFinished: false,
      isApproved: false,
      detail: detail,
      carBrand: currentProfileInfo.myCarBrand,
      carModel: currentProfileInfo.myCarModel,
      carYear: currentProfileInfo.myCarYear,
      fuelType: currentProfileInfo.myCarFuelType,
      gearType: currentProfileInfo.myCarGearType,
      orderType: orderType,
      plate: currentProfileInfo.myCarPlate,
      cost: cost,
    );

    await firestoreDB.setOrderFutureData(
        collectionPath: collectionPath, profileInfoAsMap: newOrder.toMap());
  }
}
