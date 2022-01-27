import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:car_services_app/screens/tire_change_componenets/tireSeleciton.dart';
import 'package:flutter/material.dart';

class AddingNewCar extends StatefulWidget {
  const AddingNewCar({Key? key}) : super(key: key);

  @override
  _AddingNewCarState createState() => _AddingNewCarState();
}

class _AddingNewCarState extends State<AddingNewCar> {
  GlobalKey<FormState> carInfoKey = GlobalKey<FormState>();

  TextEditingController nameCtr = TextEditingController();
  TextEditingController modelCtr = TextEditingController();
  TextEditingController yearCtr = TextEditingController();
  TextEditingController plateCodeCtr = TextEditingController();

  int gearType = 0;

  String dropdownValue = 'Gasoline';

  @override
  void initState() {
    // TODO: implement initState
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
                        child: TextFormField(
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return 'Empty';
                            }
                          },
                          controller: nameCtr,
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                              child: TextFormField(
                                validator: (_val) {
                                  if (_val!.isEmpty) {
                                    return 'Empty';
                                  }
                                },
                                controller: modelCtr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (carInfoKey.currentState!.validate()) {
                        if (gearType == 0) {
                          _showDialog(context);
                        } else {
                          print('Finish it...');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TireSelection()));
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 16,
                        top: 16,
                        bottom: 16,
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
