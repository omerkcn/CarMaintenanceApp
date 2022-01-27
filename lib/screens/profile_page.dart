import 'dart:convert';
import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/screens/orders_page.dart';
import 'package:car_services_app/screens/profile_page_view_model.dart';
import 'package:car_services_app/services/auto_car_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AutoCarApi autoCarApi = AutoCarApi();

  ProfileInfo? profileInfo;

  bool isEdit = false;
  bool isEditMyCar = false;

  TextEditingController carNameCtr = TextEditingController();
  TextEditingController modelCtr = TextEditingController();
  TextEditingController yearCtr = TextEditingController();
  TextEditingController plateCodeCtr = TextEditingController();

  String emailStr = 'a@gmail.com';
  String carNameStr = 'Ford';
  String modelStr = 'Focus';
  int yearStr = 2016;
  String plateCodeStr = '38 ASD 056';

  int gearType = 2;
  String gearTypeStr = '';

  String dropdownValue = 'Gasoline';

  List carsListFromAPI = [];
  List carsBrandFromAPI = [];

  List typesOfCarList = [];

  bool isModelSelect = false;

  Future<void> fetchCars() async {
    await autoCarApi.fetchCars();
  }

  void updateList() {
    carsListFromAPI = autoCarApi.carsListFromAPI;
    carsBrandFromAPI = autoCarApi.carsBrandFromAPI;
  }

  void updatingListFromAPI() async {
    await fetchCars();
    updateList();
  }

  List carBrands(String? query) {
    List newCarsBrandFromAPI =
        carsBrandFromAPI.map((car) => car.toLowerCase()).toList();
    String newQuery = query!.toLowerCase();
    List newLowerList = newCarsBrandFromAPI
        .where((element) => element.contains(newQuery))
        .toList();
    return newLowerList;
  }

  List carModels(String? query) {
    List newCarsBrandFromAPI =
        typesOfCarList.map((car) => car.toLowerCase()).toList();
    String newQuery = query!.toLowerCase();
    List newLowerList = newCarsBrandFromAPI
        .where((element) => element.contains(newQuery))
        .toList();
    return newLowerList;
  }

  void updateTypeOfCar() {
    List typeCarTemp =
        carsListFromAPI.where((car) => car['make'] == carNameCtr.text).toList();
    typesOfCarList = typeCarTemp.map((car) {
      return car['model'];
    }).toList();

    print(typesOfCarList.length);
    print(typesOfCarList[0]);
  }

  @override
  void initState() {
    updatingListFromAPI();
    print('initState in');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: FutureBuilder<DocumentSnapshot>(
          future: ProfilePageViewModel().getProfileInfoFromApi(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              profileInfo = ProfileInfo.fromMap(data);
              if (!isEditMyCar) {
                emailStr = profileInfo!.email;
                carNameStr = profileInfo!.myCarBrand;
                modelStr = profileInfo!.myCarModel;
                yearStr = profileInfo!.myCarYear;
                plateCodeStr = profileInfo!.myCarPlate;
                dropdownValue = profileInfo!.myCarFuelType;
                if (profileInfo!.myCarGearType == 'Manuel') {
                  gearType = 1;
                  gearTypeStr = 'Manuel';
                } else if (profileInfo!.myCarGearType == 'Semi Auto') {
                  gearType = 2;
                  gearTypeStr = 'Semi Auto';
                } else {
                  gearType = 3;
                  gearTypeStr = 'Auto';
                }
              }
              return profilePageComponents(context, size);
            }

            if (profileInfo != null) {
              return profilePageComponents(context, size);
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Scaffold profilePageComponents(BuildContext context, Size size) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFFFAC1C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>OrdersPage()));
            },
            icon: Icon(Icons.handyman),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/autoImage2.png',
                  width: size.width / 3,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                height: 20,
                color: Colors.black,
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.all(12),
              width: size.width - 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  emailStr,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            /// Edit Car
            Container(
              width: size.width - 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  /// Edit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFAC1C),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ]),
                        child: Text(
                          'My Car',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            if (isEditMyCar) {
                              carNameStr = carNameCtr.text;
                              modelStr = modelCtr.text;
                              yearStr = int.parse(yearCtr.text);
                              plateCodeStr = plateCodeCtr.text;
                            }
                          });

                          await ProfilePageViewModel().addNewProfileInfo(
                              email: emailStr,
                              myCarBrand: carNameStr,
                              myCarFuelType: dropdownValue,
                              myCarGearType: gearTypeStr,
                              myCarModel: modelStr,
                              myCarPlate: plateCodeStr,
                              myCarYear: yearStr);

                          setState(() {
                            isEditMyCar = !isEditMyCar;
                          });
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color:
                                !isEditMyCar ? Colors.blueAccent : Colors.green,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              !isEditMyCar ? Icons.edit : Icons.done,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  /// Car Name
                  !isEditMyCar
                      ? Container(
                          height: 56,
                          width: size.width - 128,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFAC1C).withOpacity(0.75),
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            carNameStr,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      : SizedBox(
                          width: size.width - 128,
                          child: TypeAheadFormField<dynamic>(
                            validator: (_val) {
                              if (_val!.isEmpty) {
                                return 'Empty';
                              }
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: carNameCtr,
                              onChanged: (_) {
                                isModelSelect = false;
                              },
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFAC1C).withOpacity(0.75),
                                hintText: 'Car Name',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                            // suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            //   borderRadius: BorderRadius.circular(24),
                            // ),
                            suggestionsCallback: carBrands,
                            itemBuilder: (context, dynamic suggestion) =>
                                ListTile(
                              title: Text(suggestion!),
                            ),
                            onSuggestionSelected: (dynamic suggestion) {
                              setState(() {
                                carNameCtr.text = suggestion!;
                                updateTypeOfCar();
                                isModelSelect = true;
                              });
                            },
                          ),
                        ),

                  SizedBox(
                    height: 20,
                  ),

                  /// Car Model AND Year
                  Row(
                    children: [
                      Expanded(
                        child: !isEditMyCar
                            ? Container(
                                height: 56,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFAC1C).withOpacity(0.75),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  modelStr,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: TypeAheadFormField<dynamic>(
                                  validator: (_val) {
                                    if (_val!.isEmpty) {
                                      return 'Empty';
                                    }
                                  },
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: modelCtr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color(0xFFFFAC1C).withOpacity(0.75),
                                      hintText: 'Car Model',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                  //   borderRadius: BorderRadius.circular(24),
                                  // ),
                                  suggestionsCallback: carModels,
                                  itemBuilder: (context, dynamic suggestion) =>
                                      ListTile(
                                    title: Text(suggestion!),
                                  ),
                                  onSuggestionSelected: (dynamic suggestion) {
                                    setState(() {
                                      modelCtr.text = suggestion!;
                                    });
                                  },
                                ),
                              ),
                      ),
                      Expanded(
                        child: !isEditMyCar
                            ? Container(
                                height: 56,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFAC1C).withOpacity(0.75),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  '$yearStr',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: yearCtr,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color(0xFFFFAC1C).withOpacity(0.75),
                                    hintText: 'new year',
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  /// Plate Code
                  !isEditMyCar
                      ? Container(
                          height: 56,
                          width: size.width - 128,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFAC1C).withOpacity(0.75),
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            plateCodeStr,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      : SizedBox(
                          width: size.width - 128,
                          child: TextField(
                            controller: plateCodeCtr,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFAC1C).withOpacity(0.75),
                              hintText: 'Enter new plate number',
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ),

                  /// Manuel- Auto
                  IgnorePointer(
                    ignoring: isEditMyCar ? false : true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 1. Buton
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gearType = 1;
                                gearTypeStr = 'Manuel';
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.25),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: gearType == 1 ? 1 : 0,
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Manuel',
                                  style: TextStyle(
                                    color: Color(0xFFFFAC1C),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// 2. Buton
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gearType = 2;
                                gearTypeStr = 'Semi Auto';
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.25),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: gearType == 2 ? 1 : 0,
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Semi Auto',
                                  style: TextStyle(
                                    color: Color(0xFFFFAC1C),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// 3. Buton
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gearType = 3;
                                gearTypeStr = 'Auto';
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.25),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: AnimatedOpacity(
                                    opacity: gearType == 3 ? 1 : 0,
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Auto',
                                  style: TextStyle(
                                    color: Color(0xFFFFAC1C),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Motor Type
                  IgnorePointer(
                    ignoring: isEditMyCar ? false : true,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFAC1C).withOpacity(0.75),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.grey,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.black,
                        // ),
                        //
                        dropdownColor: Colors.white,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['Gasoline', 'Diesel', 'Lpg', 'Hybrid']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
