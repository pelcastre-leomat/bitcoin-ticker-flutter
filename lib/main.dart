import 'package:bitcoin_ticker/price_screen_redesign.dart';
import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black
            )
          ),
          scaffoldBackgroundColor: Colors.white
      ),
      home: PriceScreenRedesign(),
    );
  }
}
