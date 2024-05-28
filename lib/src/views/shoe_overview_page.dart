import 'package:flutter/material.dart';
import '../widget/app_bar.dart';
import 'package:provider/provider.dart';
import '../providers/shoe_provider.dart';
import 'shoe_details_page.dart';

class ShoeOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'), // Use the AppBar widget
      body: Consumer<ShoeProvider>(
        builder: (context, shoeProvider, child) {
          if (shoeProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (shoeProvider.shoes.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(25),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of items in a row
              crossAxisSpacing: 25,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 1, // Adjust the aspect ratio as needed
            ),
            itemCount: shoeProvider.shoes.length,
            itemBuilder: (context, index) {
              final shoe = shoeProvider.shoes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoeDetailsPage(shoeId: shoe.id),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: shoe.imageUrl.isNotEmpty
                            ? Image.network(
                          shoe.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error); // Display an error icon if the image fails to load
                          },
                        )
                            : Icon(Icons.image_not_supported), // Display a placeholder icon if the URL is empty
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(shoe.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(shoe.brand),
                            Text('\$${shoe.price.toString()}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
