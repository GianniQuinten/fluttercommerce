import 'package:flutter/material.dart';
import '../services/sneaks_api_service.dart';
import '../models/shoe_model.dart';
import '../widget/app_bar.dart';

class ShoeDetailsPage extends StatelessWidget {
  final String shoeId;

  ShoeDetailsPage({required this.shoeId});

  @override
  Widget build(BuildContext context) {
    final apiService = SneaksApiService();

    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'), // Use the AppBar widget
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchProductDetails(shoeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            final shoe = Shoe.fromJson(snapshot.data!);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(shoe.imageUrl),
                  SizedBox(height: 16),
                  Text(
                    shoe.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(shoe.brand, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 16),
                  Text('\$${shoe.price}', style: TextStyle(fontSize: 20)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}