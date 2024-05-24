import 'package:flutter/material.dart';

class ShoeOverviewPage extends StatelessWidget {
  const ShoeOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shoe Overview')),
      body: const Center(
        child: Text('Explore our amazing shoe collection!'),
      ),
    );
  }
}

