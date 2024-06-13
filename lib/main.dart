import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/shoe_provider.dart';
import 'src/providers/cart_provider.dart';
import 'src/views/home_page.dart';
import 'src/views/shoe_details_page.dart';
import 'src/views/shopping_cart_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoeProvider()..fetchShoes("Air Force", 20)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JustShoes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          ShoeDetailsPage.routeName: (ctx) => ShoeDetailsPage(
            shoeId: '',
            shoeName: '',
            shoeImageURL: '',
            shoeBrand: '',
            shoePrice: 0.0,
          ),
          ShoppingCartPage.routeName: (ctx) => ShoppingCartPage(),
        },
      ),
    );
  }
}
