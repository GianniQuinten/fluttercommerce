import 'package:flutter/material.dart';
import 'package:fluttercommerce/src/views/contact_page.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';
import 'package:provider/provider.dart';
import 'src/providers/shoe_provider.dart';
import 'src/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoeProvider()..fetchShoes("", 20)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JustShoes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ShoeOverviewPage(),
      ),
    );
  }
}
