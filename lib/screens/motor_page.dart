import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/screens/adding_order_view_model.dart';
import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:car_services_app/services/notification_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MotorPage extends StatefulWidget {
  ProfileInfo profileInfo;
  MotorPage({required this.profileInfo});

  @override
  _MotorPageState createState() => _MotorPageState();
}

class _MotorPageState extends State<MotorPage> {
  int check = 0;
  String colorOfLamp = '';
  String text = '';
  TextEditingController problemCtr = TextEditingController();

  bool isSell = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFAC1C),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Text(
              'ENGİNE FAILURE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
            Image.asset(
              'assets/loader.gif',
              height: size.width / 2,
            ),
            Center(
                child: Text(
              'What color is the engine fault?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height / 3,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          colorOfLamp = 'Yellow';
                          check = 1;
                          text =
                              'If the warning light is yellow, it means that there is a serious problem with the engine starting and it is in malfunction mode. However, this system cannot protect the engine for a long time.';
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: check == 1
                                ? Colors.yellow
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('Light is Yellow',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          colorOfLamp = 'Red';
                          check = 2;
                          text =
                              'When you see the red warning lamp, you must pull the vehicle to the right and stop.';
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: check == 2
                                ? Colors.red
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/kirmizi.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Light is Red',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                  padding: EdgeInsets.all(check != 0 ? 8 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: check != 0
                        ? Colors.white.withOpacity(0.5)
                        : Colors.transparent,
                  ),
                  child: Center(
                      child: Text(
                    '$text',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextField(
                controller: problemCtr,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'What problems did your vehicle have?',
                    fillColor: Colors.white.withOpacity(0.5),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _showDialog();
                if (isSell) {
                  await AddingOrderViewModel().addNewOrder(
                      widget.profileInfo,
                      'Color of Lamp: $colorOfLamp**Problem: ${problemCtr.text}',
                      'Engine Failure',
                      0);
                  await Provider.of<NotificationLocal>(context, listen: false)
                      .pushNotfication('Motor Service');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.white.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              icon: Icon(
                Icons.contact_mail,
                color: Colors.blue,
                size: 30,
              ),
              label: Text(
                'Send',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
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
          title: new Text("Approve the models"),
          content:
              new Text("Do you approve the models of tire change service ?"),
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
