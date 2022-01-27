import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:car_services_app/screens/login_page.dart';
import 'package:car_services_app/services/notification_local.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'on_board.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<NotificationLocal>(
      create: (_) => NotificationLocal(),
      builder: (context, __) {
        return MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset(
            'assets/autoImage.png',
            height: 150,
            width: (MediaQuery.of(context).size.width) / 2,
            fit: BoxFit.cover,
          ),
          const Text(
            "3S AUTO",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
      backgroundColor: Color(0xffffac1c),
      nextScreen: MainApp(),
      splashIconSize: 250,
      duration: 2000,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Battery _battery = Battery();

  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen(_updateBatteryState);
  }
  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Exit"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No Connection"),
      content: Text(
          "This device is not connected to the internet. Make sure connected internet"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("No Connection"),
            content: Text(
                'This device is not connected to the internet. Make sure connected internet'),
            actions: [
              FlatButton(
                onPressed: () {
                  if (initConnectivity().toString() !=
                      "ConnectivityResult.none") {
                    Navigator.pop(context, false);
                  } else {
                    return null;
                  }
                  // Navigator.pop(context, false);
                }, // passing false
                child: Text('Check again'),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context, true), // passing true
                child: Text('Exit'),
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;

      if (exit) {
        // user pressed Yes button
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }
      } else {
        // user pressed No button
      }
    });
  }
  alertDialogForBattery(BuildContext context) async{
    final batteryLevel = await _battery.batteryLevel;
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Battery Level: $batteryLevel % "),
        content: Text('Low battery. Charge your phone for seamless app experience.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      if (result.toString() == "ConnectivityResult.none") {
        return showAlertDialog(context);
      }
      if(batteryLevel<=10){
        alertDialogForBattery(context);
      }
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnBoard();
  }
}
