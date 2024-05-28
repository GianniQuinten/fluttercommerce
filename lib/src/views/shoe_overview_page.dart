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
