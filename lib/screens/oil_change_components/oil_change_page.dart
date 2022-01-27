import 'package:car_services_app/models/profile_info.dart';
import 'package:car_services_app/screens/adding_new_car.dart';
import 'package:car_services_app/screens/adding_order_view_model.dart';
import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:car_services_app/services/notification_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../on_board.dart';
import 'oilSelection.dart';

class OilChanging extends StatefulWidget {
  ProfileInfo profileInfo;
  OilChanging({required this.profileInfo});

  @override
  State<OilChanging> createState() => _OilChangingState();
}

class _OilChangingState extends State<OilChanging> {
  bool isSell = false;
  int cost = 0;
  TextEditingController locationCtr = TextEditingController();
  String brandOfOil = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffffac1c),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OnBoard()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        shadowColor: Colors.transparent,
        title: Text("Oil Changing"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/oilChanging.jpg",
                  cacheWidth: 450,
                  cacheHeight: 200,
                ),
              ),
              Expanded(
                child: Container(
                  color: Color(0xffffac1c),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 500,
                        padding: EdgeInsets.symmetric(),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //border: Border.all(color: Colors.black, width: 2),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Text(
                          "Where is the car? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 500,
                        padding: EdgeInsets.symmetric(),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.white, width: 2),
                            color: Colors.white.withOpacity(0.5)),
                        child: TextField(
                          controller: locationCtr,
                          decoration: InputDecoration(
                            hintText: "Type the location/address of the car",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  cost = 300;
                                });
                                await _showDialog();
                                if (isSell) {
                                  String detail =
                                      'Location: ${locationCtr.text}**Brand Of Oil: Castrol Magnatec Stop-Start 5W-30 A5 4Litre';
                                  await AddingOrderViewModel().addNewOrder(
                                      widget.profileInfo,
                                      detail,
                                      'Oil Changing',
                                      cost);
                                  await Provider.of<NotificationLocal>(context,
                                          listen: false)
                                      .pushNotfication('Oil Change Service');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OnBoard()));
                                }
                              },
                              child: Container(
                                height: 100.0,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 100.0,
                                      width: 70.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://st2.myideasoft.com/idea/dc/16/myassets/products/783/castrol-5w-30-a5-magnatec.jpg?revision=1574785235"),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      height: 100,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 2, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                "Castrol Magnatec Stop-Start 5W-30 A5 4Litre"),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 2),
                                              child: Container(
                                                width: 260,
                                                child: Text(
                                                  "Castrol",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 48, 48, 54)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 2),
                                              child: Container(
                                                width: 260,
                                                child: Text(
                                                  "300 TL",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 48, 48, 54)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              cost = 300;
                            });
                            await _showDialog();
                            if (isSell) {
                              String detail =
                                  'Location: ${locationCtr.text}**Brand Of Oil: Shell Helix HX6 10W-40 4 Litre Motor oil';
                              await AddingOrderViewModel().addNewOrder(
                                  widget.profileInfo,
                                  detail,
                                  'Oil Changing',
                                  cost);
                              await Provider.of<NotificationLocal>(context,
                                      listen: false)
                                  .pushNotfication('Oil Change Service');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnBoard()));
                            }
                          },
                          child: Container(
                            height: 100.0,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 100.0,
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          topLeft: Radius.circular(5)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://productimages.hepsiburada.net/s/24/550/10091920457778.jpg/format:webp"),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Wrap(
                                          children: [
                                            Text(
                                                "Shell Helix HX6 10W-40 4 Litre Motor oil"),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 2),
                                          child: Container(
                                            width: 260,
                                            child: Text(
                                              "Shell",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 48, 48, 54)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 2),
                                          child: Container(
                                            width: 260,
                                            child: Text(
                                              "300 TL",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 48, 48, 54)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ],
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
          title: new Text("Approve the models"),
          content:
              new Text("Do you approve the models of oil change service ?"),
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

Widget _button(context, String text, String route) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Column(
      children: [
        Container(
          width: 200,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
