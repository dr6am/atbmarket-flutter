import 'package:atbmarket_app/Splash/splash_screen.dart';
import 'package:atbmarket_app/models/economySaleStore.dart';
import 'package:atbmarket_app/screens/home_screen.dart';
import 'package:atbmarket_app/screens/sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/7daysSaleStore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => SevenDaysItemsList(),
        ),
        ChangeNotifierProvider(
          builder: (_) => EconomyItemsList(),
        ),
      ],
      child: MaterialApp(
        title: 'АТБ',
        theme: ThemeData(
            // fontFamily: "Roboto",
            accentColor: Colors.blue[100],
            primarySwatch: Colors.blue,
            indicatorColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
              headline2: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: Colors.black87),
              headline3: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.black87),
            )),
        darkTheme: ThemeData(
            accentColor: Colors.blue[900],
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[900],
            backgroundColor: Colors.grey[800],
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
              headline2: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: Colors.white70),
              headline3: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.white70),
            )),
        //home: HomeScreen(),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SaleScreen.routeName: (context) => SaleScreen(),
        },
      ),
    );
  }
}
