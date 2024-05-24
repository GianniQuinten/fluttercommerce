import 'package:flutter/material.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';
import 'package:provider/provider.dart';
import '../providers/shoe_provider.dart';
import 'shoe_details_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JustShoes'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Text('Home'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoeOverviewPage(),
                ),
              );
            },
            child: Text('Shoes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoeOverviewPage(), // Change to contact whenever it is made
                ),
              );
            },
            child: Text('Contact'),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart page
            },
          ),
        ],
      ),
      body: Consumer<ShoeProvider>(
        builder: (context, shoeProvider, child) {
          if (shoeProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (shoeProvider.shoes.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: shoeProvider.shoes.length,
            itemBuilder: (context, index) {
              final shoe = shoeProvider.shoes[index];
              return ListTile(
                leading: shoe.imageUrl.isNotEmpty
                    ? Image.network(
                  shoe.imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error); // Display an error icon if the image fails to load
                  },
                )
                    : Icon(Icons.image_not_supported), // Display a placeholder icon if the URL is empty
                title: Text(shoe.name),
                subtitle: Text(shoe.brand),
                trailing: Text('\$${shoe.price.toString()}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoeDetailsPage(shoeId: shoe.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
