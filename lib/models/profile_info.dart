class ProfileInfo {
  final String email;
  final String myCarBrand;
  final String myCarFuelType;
  final String myCarGearType;
  final String myCarModel;
  final String myCarPlate;
  final int myCarYear;

  ProfileInfo(
      {required this.email,
      required this.myCarBrand,
      required this.myCarFuelType,
      required this.myCarGearType,
      required this.myCarModel,
      required this.myCarPlate,
      required this.myCarYear});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'myCarBrand': myCarBrand,
      'myCarFuelType': myCarFuelType,
      'myCarGearType': myCarGearType,
      'myCarModel': myCarModel,
      'myCarPlate': myCarPlate,
      'myCarYear': myCarYear,
    };
  }

  factory ProfileInfo.fromMap(Map map) {
    return ProfileInfo(
        email: map['email'],
        myCarBrand: map['myCarBrand'],
        myCarFuelType: map['myCarFuelType'],
        myCarGearType: map['myCarGearType'],
        myCarModel: map['myCarModel'],
        myCarPlate: map['myCarPlate'],
        myCarYear: map['myCarYear']);
  }
}
