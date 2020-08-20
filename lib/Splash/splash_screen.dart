import 'dart:async';
import 'dart:core';

import 'package:atbmarket_app/models/7daysSaleStore.dart';
import 'package:atbmarket_app/models/economySaleStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Inheriting from the state widget
// that is, a widget for changing the state of which is not required to recreate its instance
class SplashScreen extends StatefulWidget {
  static String routeName = "splashScreen";

  SplashScreen();

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

// Create a widget state
class _SplashScreenState extends State<SplashScreen> {
  // State initialization
  @override
  void initState() {
    super.initState();
    Provider.of<SevenDaysItemsList>(context, listen: false).loadData();
    Provider.of<EconomyItemsList>(context, listen: false).loadData();

    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed("/");
    });
  }

  // Widget creation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logo.png",
              width: MediaQuery.of(context).size.width / 3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Theme.of(context).platform == TargetPlatform.iOS
                ? CupertinoActivityIndicator(
                    radius: MediaQuery.of(context).size.width * .03,
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.white70,
                  ),
          ],
        ),
      ),
    );
  }
}
