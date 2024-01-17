import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/shoe_overview_page.dart';
import 'pages/shoe_details_page.dart';
import 'pages/cart_page.dart';
import 'pages/contact_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoeCommerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/shoeOverview': (context) => ShoeOverviewPage(),
        '/shoeDetails': (context) => ShoeDetailsPage(),
        '/cart': (context) => CartPage(),
        '/contact': (context) => ContactPage(),
      },
    );
  }
}
