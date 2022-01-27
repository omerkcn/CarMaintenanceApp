import 'dart:convert';

import 'package:car_services_app/models/email.dart';
import 'package:car_services_app/on_board.dart';
import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:car_services_app/screens/sign_in_page_2_model_view.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:car_services_app/services/auto_car_api.dart';
import 'package:car_services_app/services/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class SignInPage2 extends StatefulWidget {
  final String email;
  final String password;
  final List allEmails;

  SignInPage2(
      {required this.email, required this.password, required this.allEmails});

  @override
  _SignInPage2State createState() => _SignInPage2State();
}

class _SignInPage2State extends State<SignInPage2> {
  AutoCarApi autoCarApi = AutoCarApi();

  GlobalKey<FormState> carInfoKey = GlobalKey<FormState>();

  TextEditingController nameCtr = TextEditingController();
  TextEditingController modelCtr = TextEditingController();
  TextEditingController yearCtr = TextEditingController();
  TextEditingController plateCodeCtr = TextEditingController();

  List carsListFromAPI = [];
  List carsBrandFromAPI = [];

  List typesOfCarList = [];

  bool isModelSelect = false;

  // Future<void> fetchCars() async {
  //   final response = await http.get(Uri.parse(
  //       'https://private-anon-f3a0b5d41e-carsapi1.apiary-mock.com/cars'));
  //   carsListFromAPI = jsonDecode(response.body);
  //   final response2 = await http.get(Uri.parse(
  //       'https://car-data.p.rapidapi.com/cars/makes?rapidapi-key=566cd9d51cmshb5266a816dfa9eap1a8ffdjsnb4a3303b621e'));
  //   carsBrandFromAPI = jsonDecode(response2.body);
  //   print(carsBrandFromAPI.length);
  //   print('fetchAPI successful');
  // }

  // Future addEmail() async {
  //   final email = Email(
  //     email: widget.email,
  //   );
  //
  //   await EmailDatabase.instance.create(email);
  // }

  Future<void> fetchCars() async {
    await autoCarApi.fetchCars();
  }

  void updateList() {
    carsListFromAPI = autoCarApi.carsListFromAPI;
    carsBrandFromAPI = autoCarApi.carsBrandFromAPI;
    print('car lists and brands');
    print(carsListFromAPI.length);
    print(carsBrandFromAPI.length);
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
    print(typesOfCarList);
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
        carsListFromAPI.where((car) => car['make'] == nameCtr.text).toList();
    typesOfCarList = typeCarTemp.map((car) {
      return car['model'];
    }).toList();

    print('typesOfCarList: $typesOfCarList');
    print('hello: $typeCarTemp');
    // print(typesOfCarList[0]);
  }

  int gearType = 0;
  String gearTypeString = '';

  String dropdownValue = 'Gasoline';

  @override
  void initState() {
    updatingListFromAPI();
    print('initState in');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFFAC1C),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: carInfoKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/autoImage.png',
                        width: size.width / 2,
                        height: size.width / 2,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Car Info',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Divider(
                          height: 10,
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),

                      /// Car Name
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        child: TypeAheadFormField<dynamic>(
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return 'Empty';
                            }
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: nameCtr,
                            onChanged: (_) {
                              isModelSelect = false;
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white.withOpacity(0.50),
                              filled: true,
                              hintText: 'Car Name',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
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
                              nameCtr.text = suggestion!;
                              updateTypeOfCar();
                              isModelSelect = true;
                            });
                          },
                        ),
                      ),

                      /// Model-Year
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Model

                            SizedBox(
                              width: size.width / 2 - 36,
                              child: TypeAheadFormField<dynamic>(
                                validator: (_val) {
                                  if (_val!.isEmpty) {
                                    return 'Empty';
                                  }
                                },
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: modelCtr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white.withOpacity(0.50),
                                    filled: true,
                                    hintText: 'Car Model',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
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

                            /// Year
                            SizedBox(
                              width: size.width / 2 - 36,
                              child: TextFormField(
                                validator: (_val) {
                                  if (_val!.isEmpty) {
                                    return 'Empty';
                                  }
                                },
                                controller: yearCtr,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(0.50),
                                  filled: true,
                                  hintText: 'Year',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Manuel- Auto
                      Padding(
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
                                  gearTypeString = 'Manuel';
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
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
                                      color: Colors.white,
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
                                  gearTypeString = 'Semi Auto';
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
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
                                      color: Colors.white,
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
                                  gearTypeString = 'Auto';
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
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
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Plate Code
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        child: TextFormField(
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return 'Empty';
                            }
                          },
                          controller: plateCodeCtr,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            fillColor: Colors.white.withOpacity(0.50),
                            filled: true,
                            hintText: 'Plate Code',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// Motor Type
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.black,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
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
                    ],
                  ),
                ),
              ),
            ),

            /// Finish Button
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Divider(
                    height: 10,
                    color: Colors.black,
                    thickness: 2,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (carInfoKey.currentState!.validate()) {
                      if (gearType == 0) {
                        _showDialog(context);
                      } else {
                        print('Finish it...');
                        // await addEmail();
                        await SignInPage2ModelView().addNewProfileInfo(
                            email: widget.email,
                            myCarBrand: nameCtr.text,
                            myCarFuelType: dropdownValue,
                            myCarGearType: gearTypeString,
                            myCarModel: modelCtr.text,
                            myCarPlate: plateCodeCtr.text,
                            myCarYear: int.parse(yearCtr.text));
                        List updatedEmailList = widget.allEmails;
                        updatedEmailList.add(widget.email);
                        await SignInPage2ModelView()
                            .updateEmails(updatedEmailList);
                        await Auth().createUserWithEmailAndPassword(
                            widget.email, widget.password);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => OnBoard()));
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 16,
                      top: 16,
                      bottom: 16,
                      left: 16,
                    ),
                    width: size.width / 3,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Center(
                      child: Text(
                        'Finish',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Please select gear type"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
