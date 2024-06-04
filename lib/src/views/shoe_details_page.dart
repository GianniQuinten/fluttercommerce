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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child:Text (
                                  'Shoe Overview',
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                )
                              ),
                              SizedBox(height: 16),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              SizedBox(height: 16),
                              _buildDetailRow('Name', shoeName),
                              _buildDetailRow('Brand', shoeBrand),
                              _buildDetailRow(
                                  'Price', '\$${shoePrice.toStringAsFixed(2)}'),
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
                      SizedBox(width: 256),
                      // Shoe Image
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(shoeImageURL),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
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
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
