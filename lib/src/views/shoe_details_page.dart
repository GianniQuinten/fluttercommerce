import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/app_bar.dart';
import '../providers/shoe_provider.dart';

class ShoeDetailsPage extends StatelessWidget {
  final String shoeId;
  final String shoeName;

  const ShoeDetailsPage({Key? key, required this.shoeId, required this.shoeName}) : super(key: key);

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
                final shoe = shoeProvider.selectedShoe;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shoeName,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
