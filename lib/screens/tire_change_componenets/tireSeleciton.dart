import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:flutter/material.dart';
import 'tire_page.dart';

class TireSelection extends StatefulWidget {
  @override
  _TireSelectionState createState() => _TireSelectionState();
}

class _TireSelectionState extends State<TireSelection> {
  bool isSell = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffffac1c),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          shadowColor: Colors.transparent,
          title: Text("Tire Selection"),
        ),
        body: Center(
            child: Column(
          children: [
            Card(
              elevation: 5,
              child: InkWell(
                onTap: () async {
                  await _showDialog();
                  if (isSell) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
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
                                  "https://www.artvinticaret.com.tr/gecici/bridgestone/a005.jpg"),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "Bridgestone 225/40R18 92Y XL A005 Four Season"),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "Bridgestone",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "600 TL",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
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
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: InkWell(
                onTap: () async {
                  await _showDialog();
                  if (isSell) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
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
                                  "https://cdn2.lazimbana.com/product/2020/07/30/2641827/petlas-245-50r20-102v-w671-explore-winter-2018-kis-lastigi-1-1596071644.jpg"),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Petlas 245/50R20 102V W671 Explore Winter"),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "Petlas",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "399 TL",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
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
        )));
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

// showAlertDialog(BuildContext context) {
//   // set up the buttons
//   Widget cancelButton = TextButton(
//     child: Text("Cancel"),
//     onPressed: () {
//       Navigator.pop(context);
//     },
//   );
//   Widget continueButton = TextButton(
//     child: Text("Approve"),
//     onPressed: () {
//       Navigator.pushNamed(context, "/");
//     },
//   );
//
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("Approve the models"),
//     content: Text("Do you approve the models of tire change service ?"),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );
//
//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
