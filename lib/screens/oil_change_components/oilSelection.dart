import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:flutter/material.dart';
import 'oil_change_page.dart';

class OilSelection extends StatefulWidget {
  const OilSelection({Key? key}) : super(key: key);

  @override
  _OilSelectionState createState() => _OilSelectionState();
}

class _OilSelectionState extends State<OilSelection> {
  bool isSell = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            title: Text("Oil Selection"),
          ),
          body: Center(
              child: Column(
            children: [
              Wrap(
                children: [
                  Card(
                    elevation: 5,
                    child: InkWell(
                      onTap: () async {
                        await _showDialog();
                        if (isSell) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
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
                                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Castrol Magnatec Stop-Start 5W-30 A5 4Litre"),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
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
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
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
                                    "https://productimages.hepsiburada.net/s/24/550/10091920457778.jpg/format:webp"),
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
                                Wrap(
                                  children: [
                                    Text(
                                        "Shell Helix HX6 10W-40 4 Litre Motor oil"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    width: 260,
                                    child: Text(
                                      "Shell",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 48, 48, 54)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                  child: Container(
                                    width: 260,
                                    child: Text(
                                      "300 TL",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(255, 48, 48, 54)),
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
          ))),
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
