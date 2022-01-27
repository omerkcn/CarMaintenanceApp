class Order {
  final String carBrand;
  final String carModel;
  final int carYear;
  final String detail;
  final String email;
  final String fuelType;
  final String gearType;
  final bool isApproved;
  final bool isFinished;
  final String plate;
  final String orderType;
  final int cost;

  Order(
      {required this.carBrand,
      required this.carModel,
      required this.carYear,
      required this.detail,
      required this.email,
      required this.fuelType,
      required this.gearType,
      required this.isApproved,
      required this.isFinished,
      required this.plate,
      required this.orderType,
      required this.cost,
      });

  Map<String, dynamic> toMap() {
    return {
      'carBrand': carBrand,
      'carModel': carModel,
      'carYear': carYear,
      'detail': detail,
      'email': email,
      'fuelType': fuelType,
      'gearType': gearType,
      'isApproved': isApproved,
      'isFinished': isFinished,
      'plate': plate,
      'orderType': orderType,
      'cost':cost,
    };
  }

  factory Order.fromMap(Map map) {
    return Order(
      carBrand: map['carBrand'],
      carModel: map['carModel'],
      carYear: map['carYear'],
      detail: map['detail'],
      email: map['email'],
      fuelType: map['fuelType'],
      gearType: map['gearType'],
      isApproved: map['isApproved'],
      isFinished: map['isFinished'],
      plate: map['plate'],
      orderType: map['orderType'],
      cost: map['cost'],
    );
  }
}
