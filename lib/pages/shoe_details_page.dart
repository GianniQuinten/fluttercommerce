import 'package:flutter/material.dart';

class ShoeDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shoe Details')),
      body: Center(
        child: Text('Details of the selected shoe will be displayed here.'),
      ),
    );
  }
}