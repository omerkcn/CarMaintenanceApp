import 'package:car_services_app/screens/login_page.dart';
import 'package:car_services_app/screens/profile_page.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'operations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAC1C),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await Auth().signOut();
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 40,
              ))
        ],
        backgroundColor: Colors.black,
        title: const Text('3S AUTO'),
        centerTitle: true,
      ),
      body: const Operations(),
    );
  }
}
