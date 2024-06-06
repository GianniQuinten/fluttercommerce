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
    double screenWidth = MediaQuery.of(context).size.width;
    double sizedBoxWidth =
        screenWidth * 0.2; // The margin between the image and the shoeoverview

    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'),
      body: FutureBuilder(
        future: Provider.of<ShoeProvider>(context, listen: false)
            .fetchShoeDetails(shoeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading shoe details'));
          } else {
            return Consumer<ShoeProvider>(
              builder: (context, shoeProvider, child) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        // Shoe Details
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Text(
                                  'Shoe Overview',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(height: 16),
                                Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                SizedBox(height: 16),
                                _buildDetailRow('Name', shoeName),
                                _buildDetailRow('Brand', shoeBrand),
                                _buildDetailRow('Price',
                                    '\$${shoePrice.toStringAsFixed(2)}'),
                                _buildDetailRow('Size', '[size placeholder]'),
                                SizedBox(height: 16),
                                Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle add to cart functionality
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xFF246EB9),
                                      // Text color & Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            14), // Corner radius
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                    ),
                                    child: Text(
                                      'Add to cart',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: sizedBoxWidth),
                        // Shoe Image
                        Expanded(
                          flex: 1,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 480),
                            // Limit the height to 480
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                // Set border radius
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double maxWidth = constraints.maxWidth;
                                    double maxHeight = constraints.maxHeight;
                                    double aspectRatio = maxWidth / maxHeight;
                                    return AspectRatio(
                                      aspectRatio: aspectRatio,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(shoeImageURL),
                                            fit: BoxFit
                                                .contain, // Use BoxFit.contain to fit within the box
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
