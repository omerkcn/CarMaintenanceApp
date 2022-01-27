import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/services/notification_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../on_board.dart';
import 'adding_order_view_model.dart';
import 'home_page_components/main_page.dart';

class Washing extends StatefulWidget {
  ProfileInfo profileInfo;
  Washing({required this.profileInfo});
  @override
  State<Washing> createState() => _WashingState();
}

class _WashingState extends State<Washing> {
  int chosen = 0;
  int check = 0;
  int controlPrice = 0;
  int checkPrice = 0;
  bool isSell = false;
  bool isSelected = false;
  int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFFFAC1C),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Car Washing"),
      ),
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Vehicle Type",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      chosen = 1;
                      controlPrice = 100;
                      isSelected = true;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: chosen == 1
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/Sedan.png",
                              width: 40,
                              height: 70,
                            ),
                            Text(
                              "sedan, coupe, sport, mini, or similar",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      chosen = 2;
                      controlPrice = 120;
                      isSelected = true;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: chosen == 2
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/suv.png",
                              width: 40,
                              height: 70,
                            ),
                            Text(
                              "suv, short pickups or similar",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      chosen = 3;
                      controlPrice = 150;
                      isSelected = true;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: chosen == 3
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/Truck.png",
                              width: 40,
                              height: 70,
                            ),
                            Text(
                              "long pickups, trucks or similar",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      chosen = 4;
                      controlPrice = 50;
                      isSelected = true;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: chosen == 4
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/motorcycle.png",
                              width: 40,
                              height: 70,
                            ),
                            Text(
                              "motorcycles, all kinds",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// type of wash
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              check = 1;
                              checkPrice = -20;
                              isSelected = true;
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
                                  opacity: check == 1 ? 1 : 0,
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
                                'Inside Washing',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              check = 2;
                              checkPrice = -20;
                              isSelected = true;
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
                                  opacity: check == 2 ? 1 : 0,
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
                                'Outside Washing',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              check = 3;
                              checkPrice = 0;
                              isSelected = true;
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
                                  opacity: check == 3 ? 1 : 0,
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
                                'Inside-Outside Washing',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Button
                    GestureDetector(
                      onTap: () async {
                        await _showDialog();
                        if (isSell) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      },
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                                height: 50,
                                width: size.width / 3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Price = ${controlPrice + checkPrice < 0 ? 0 : controlPrice + checkPrice}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Icon(Icons.attach_money_outlined),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Verify',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
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
          title: new Text("Approve the order"),
          content: new Text(
              " Price = ${controlPrice + checkPrice < 0 ? 0 : controlPrice + checkPrice}"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new ElevatedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: new Text("Approve"),
              onPressed: () async {
                setState(() {
                  totalPrice = controlPrice + checkPrice;
                });
                String detail =
                    'VehicleType:$controlPrice**WashingType:$checkPrice';
                await AddingOrderViewModel().addNewOrder(
                    widget.profileInfo, detail, 'Washing', totalPrice);
                await Provider.of<NotificationLocal>(context, listen: false)
                    .pushNotfication('Washing Service');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OnBoard()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialog2() async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Approve the order"),
          content: new Text("CONGURAGTS..."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                setState(() {
                  isSell = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
