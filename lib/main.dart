import 'package:flutter/material.dart';
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
        ChangeNotifierProvider(create: (_) => ShoeProvider()..fetchShoes("Yeezy", 10)),
      ],
      child: MaterialApp(
        title: 'JustShoes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
