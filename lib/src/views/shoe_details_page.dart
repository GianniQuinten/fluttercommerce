import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/app_bar.dart';
import '../providers/shoe_provider.dart';

class ShoeDetailsPage extends StatelessWidget {
  final String shoeId;
  final String shoeName;
  final String shoeImageURL;
  final String shoeBrand;
  final double shoePrice;

  const ShoeDetailsPage({
    Key? key,
    required this.shoeId,
    required this.shoeName,
    required this.shoeImageURL,
    required this.shoeBrand,
    required this.shoePrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'),
      body: FutureBuilder(
        future: Provider.of<ShoeProvider>(context, listen: false).fetchShoeDetails(shoeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading shoe details'));
          } else {
            return Consumer<ShoeProvider>(
              builder: (context, shoeProvider, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 320,
                        height: 320,
                        child: Image.network(
                          shoeImageURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        shoeName,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(shoeBrand, style: TextStyle(fontSize: 20)),
                      Text('\$${shoePrice}', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
