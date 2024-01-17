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
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF89AAE6),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ShoeCommerce',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    NavButton(label: 'Home', route: '/'),
                    NavButton(label: 'Shoe Overview', route: '/shoeOverview'),
                    NavButton(label: 'Cart', route: '/cart'),
                    NavButton(label: 'Contact', route: '/contact'),
                  ],
                ),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final String route;

  const NavButton({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
