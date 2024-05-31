import 'package:flutter/material.dart';
import '../widget/app_bar.dart';

class ShoeDetailsPage extends StatelessWidget {
  final String shoeId;

  const ShoeDetailsPage({Key? key, required this.shoeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the shoeId to fetch more details about the shoe from the API, and then display those details on this page.
    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'), // Use the AppBar widget
      body: Center(
        child: Text('Shoe ID: $shoeId'), // Just an example to show the shoeId
      ),
    );
  }
}
