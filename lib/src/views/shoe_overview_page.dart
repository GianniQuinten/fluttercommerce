import 'package:flutter/foundation.dart';
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

          return LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;

              // Calculate the cross axis count based on the available width
              int crossAxisCount = width > 1200 ? 4 : width > 800 ? 3 : 2;

              double maxItemHeight;
              if(defaultTargetPlatform != TargetPlatform.android) {
                maxItemHeight = crossAxisCount == 4 ? 320 : crossAxisCount == 3 ? 265 : 267.5;
              } else {
                maxItemHeight = 190;
              }

              double itemWidth = (width - (crossAxisCount - 1) * 25) / crossAxisCount;

              // Calculate the aspect ratio based on the max item height
              double aspectRatio = itemWidth / maxItemHeight;

              return GridView.builder(
                padding: const EdgeInsets.all(25),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 15,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: shoeProvider.shoes.length,
                itemBuilder: (context, index) {
                  final shoe = shoeProvider.shoes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoeDetailsPage(
                            shoeId: shoe.id,
                            shoeName: shoe.name,
                            shoeBrand: shoe.brand,
                            shoeImageURL: shoe.imageUrl,
                            shoePrice: shoe.price,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for the card
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Give a shadow to the container
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: AspectRatio(
                                aspectRatio: 2 / 1, // Adjust the aspect ratio as needed
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shoe.name,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(shoe.brand, style: TextStyle(fontSize: 12)),
                                Text('\$${shoe.price.toString()}', style: TextStyle(fontSize: 12)),
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
          );
        },
      ),
    );
  }
}
