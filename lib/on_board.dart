import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:car_services_app/screens/login_page.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:car_services_app/services/notification_local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  bool isNotificationSet = false;

  void initializeNotifications() async {
    await Provider.of<NotificationLocal>(context, listen: false).initializeNotifications();
    setState(() {
      isNotificationSet = true;
    });
  }

  @override
  void initState() {
    initializeNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: Auth().authStatus(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active && isNotificationSet) {
            print('Hello Hello');
            print('${snapshot.data}');
            return snapshot.data != null ? HomePage() : LoginPage();
          } else {
            return Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
