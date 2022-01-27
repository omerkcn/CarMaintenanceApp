import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/on_board.dart';
import 'package:car_services_app/screens/adding_order_view_model.dart';
import 'package:car_services_app/services/notification_local.dart';
import 'package:car_services_app/widgets/ShowDialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Towpage extends StatefulWidget {
  ProfileInfo profileInfo;
  Towpage({required this.profileInfo});

  @override
  State<Towpage> createState() => _TowpageState();
}

class _TowpageState extends State<Towpage> {
  int isCanMove = 0;
  int carType = 0;

  int MovePrice = 0;
  int TypePrice = 0;

  String isCanMoveStr = '';
  String carTypeStr = '';

  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFAC1C),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Text(
              'TOW AWAY A CAR',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            )),
            SizedBox(
              height: 30,
            ),
            Container(
                color: Colors.white.withOpacity(0.50),
                child: Image.asset(
                  'assets/error-500.gif',
                  width: double.infinity,
                  height: size.width / 3,
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
              child: TextField(
                controller: locationController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    suffixIcon: Icon(Icons.near_me),
                    fillColor: Colors.white.withOpacity(0.5),
                    filled: true,
                    hintText: 'Enter Your Location',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.50),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Text('Is your vehicle moving?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCanMove = 1;
                            isCanMoveStr = 'Yes';
                            MovePrice = 0;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AnimatedOpacity(
                                opacity: isCanMove == 1 ? 1 : 0,
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
                              'Yes',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCanMove = 2;
                            isCanMoveStr = 'No';
                            MovePrice = 100;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AnimatedOpacity(
                                opacity: isCanMove == 2 ? 1 : 0,
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
                              'No',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.50),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Center(
                      child: Text('Choose vehicle type?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            carType = 1;
                            carTypeStr = 'Motor';
                            TypePrice = 100;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.motorcycle_sharp,
                              size: 40,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Motor'),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AnimatedOpacity(
                                opacity: carType == 1 ? 1 : 0,
                                duration: Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            carType = 2;
                            carTypeStr = 'Car';
                            TypePrice = 200;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 40,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Car'),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AnimatedOpacity(
                                opacity: carType == 2 ? 1 : 0,
                                duration: Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            carType = 3;
                            carTypeStr = 'Bus';
                            TypePrice = 300;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.directions_bus,
                              size: 40,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Bus'),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AnimatedOpacity(
                                opacity: carType == 3 ? 1 : 0,
                                duration: Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            carType = 4;
                            carTypeStr = 'Van';
                            TypePrice = 400;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.local_shipping,
                              size: 40,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Van'),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: AnimatedOpacity(
                                opacity: carType == 4 ? 1 : 0,
                                duration: Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.50),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price = ${carType == 0 ? 0 : TypePrice + MovePrice}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Icon(Icons.attach_money_outlined),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  /* String detail =
                      'Can vehicle move: $isCanMoveStr**Vehicle Type: $carTypeStr';
                  await AddingOrderViewModel().addNewOrder(
                      widget.profileInfo, detail, 'Tow Away A Car');*/

                  _showDialog();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.7),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                icon: Icon(
                  Icons.attach_money_outlined,
                  color: Colors.green,
                  size: 24,
                ),
                label: Text(
                  'Verify',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("PRICE"),
          content: new Text(
              "Total Amount ${carType == 0 ? 0 : TypePrice + MovePrice}"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Approve"),
              onPressed: () async {
                String detail =
                    'Can vehicle move: $isCanMoveStr**Vehicle Type: $carTypeStr';
                await AddingOrderViewModel().addNewOrder(widget.profileInfo,
                    detail, 'Tow Away A Car', (MovePrice + TypePrice));
                await Provider.of<NotificationLocal>(context, listen: false)
                    .pushNotfication('Tow Away A Car Service');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OnBoard()));
              },
            ),

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
