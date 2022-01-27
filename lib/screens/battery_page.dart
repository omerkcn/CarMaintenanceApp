import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/screens/adding_order_view_model.dart';
import 'package:car_services_app/services/notification_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../on_board.dart';
import 'home_page_components/main_page.dart';

class BatteryPage extends StatefulWidget {
  ProfileInfo profileInfo;
  BatteryPage({required this.profileInfo});

  @override
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  String dropdownValue = 'Mutlu';
  String dropdownValue2 = '60 Ah';
  String dropdownValue3 = '2 V';
  int price = 850;
  int price1 = 0;
  int price2 = 0;

  bool isSell = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFAC1C),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OnBoard()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Battery Change',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: size.width - 32,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('assets/battery1.jpeg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 10,
              color: Colors.black,
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Brand Of Battery:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
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
                      if (dropdownValue == "Inci") {
                        price = 800;
                      } else if (dropdownValue == "Mutlu") {
                        price = 850;
                      } else if (dropdownValue == "Varta") {
                        price = 950;
                      } else if (dropdownValue == "Bosch") {
                        price = 999;
                      }
                    });
                  },
                  items: <String>['Mutlu', 'Varta', 'Inci', 'Bosch']
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Amper Of Battery:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue2,
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.black,
                  // ),
                  //
                  dropdownColor: Colors.white,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                      if (dropdownValue2 == '60 Ah') {
                        price2 = 0;
                      } else if (dropdownValue2 == '70 Ah') {
                        price2 = 150;
                      } else if (dropdownValue2 == '75 Ah') {
                        price2 = 250;
                      } else if (dropdownValue2 == '100 Ah') {
                        price2 = 350;
                      }
                    });
                  },
                  items: <String>[
                    '60 Ah',
                    '70 Ah',
                    '75 Ah',
                    '100 Ah',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Voltage Of Battery:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: dropdownValue3,
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.black,
                  // ),
                  //
                  dropdownColor: Colors.white,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue3 = newValue!;
                      if (dropdownValue3 == '2 V') {
                        price1 = 0;
                      } else if (dropdownValue3 == '4 V') {
                        price1 = 50;
                      } else if (dropdownValue3 == '6 V') {
                        price1 = 100;
                      } else if (dropdownValue3 == '12 V') {
                        price1 = 150;
                      }
                    });
                  },
                  items: <String>[
                    '2 V',
                    '4 V',
                    '6 V',
                    '12 V',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 10,
              color: Colors.black,
              thickness: 2,
            ),
          ),
          Text(
            "Cost: ${price + price2 + price1} TL",
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  await _showDialog();
                  if (isSell) {
                    String detail =
                        'Brand:$dropdownValue**Amper:$dropdownValue2**Voltage:$dropdownValue3';
                    await AddingOrderViewModel().addNewOrder(
                        widget.profileInfo, detail, 'Battery Change', price);
                    await Provider.of<NotificationLocal>(context, listen: false)
                        .pushNotfication('Battery Service');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OnBoard()));
                  }
                },
                child: Container(
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
              ),
            ),
          ),
        ],
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
          title: new Text("Approve the models"),
          content:
              new Text("Do you approve the models of battery change service ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Approve"),
              onPressed: () async {
                await _showDialog2();
                Navigator.of(context).pop();
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
          title: new Text("Approve the models"),
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
