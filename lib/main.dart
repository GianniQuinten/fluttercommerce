import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/shoe_overview_page.dart';
import 'pages/shoe_details_page.dart';
import 'pages/cart_page.dart';
import 'pages/contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoeCommerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/shoeOverview': (context) => const ShoeOverviewPage(),
        '/shoeDetails': (context) => ShoeDetailsPage(),
        '/cart': (context) => CartPage(),
        '/contact': (context) => ContactPage(),
      },
      builder: (context, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 25, 50, 25), // Add margins
              child: AppBar(
                backgroundColor: const Color(0xFF89AAE6),
                elevation: 6,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                    bottom: Radius.circular(20),
                  ),
                ),
                title: const Text(
                  'ShoeCommerce',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                actions: const [
                  Row(
                    children: [
                      NavButton(label: 'Home', route: '/'),
                      NavButton(label: 'Shoes', route: '/shoeOverview'),
                      NavButton(label: 'Contact', route: '/contact'),
                      NavButton(label: 'My Cart', route: '/cart'),
                    ],
                  ),
                ],
              ),
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

  const NavButton({Key? key, required this.label, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route); // Use Navigator.pushNamed
      },
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
