import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';
import 'package:provider/provider.dart';
import '../widget/app_bar.dart';
import '../providers/shoe_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the left and right padding based on the screen width
    double screenPadding = defaultTargetPlatform == TargetPlatform.android ? 20 : 50;
    double textPadding = defaultTargetPlatform == TargetPlatform.android ? 10 : 25;
    double buttonPadding = defaultTargetPlatform == TargetPlatform.android ? 8 : 16;

    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'),
      body: Padding(
        padding: EdgeInsets.all(screenPadding),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            int crossAxisCount = width > 825 ? 2 : 1; // Change number of columns (images) based on width
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Consumer<ShoeProvider>(
                    builder: (context, shoeProvider, child) {
                      if (shoeProvider.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (shoeProvider.shoes.isEmpty) {
                        return Center(child: Text('No data available'));
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.25, // Height of the images
                        ),
                        itemCount: 4, // Only show 4 images
                        itemBuilder: (context, index) {
                          final shoe = shoeProvider.shoes[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                shoe.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: defaultTargetPlatform == TargetPlatform.android ? 0 : 30,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    // Use responsive padding
                    padding: EdgeInsets.fromLTRB(textPadding, 25, textPadding, 25),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Calculate font size based on the available width
                                double fontSize = constraints.maxWidth * 0.05;
                                fontSize = fontSize.clamp(16.0, 32.0); // Clamp within the range
                                return Text(
                                  'Welcome to the JustShoes Store!',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate spacing based on the available width
                              double sizedBoxHeight = constraints.maxWidth * 0.05;
                              sizedBoxHeight = sizedBoxHeight.clamp(20.0, 50.0); // Clamp within the range
                              return SizedBox(height: sizedBoxHeight);
                            },
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate font size based on the available width
                              double paragraphFontSize = constraints.maxWidth * 0.02;
                              paragraphFontSize = paragraphFontSize.clamp(12.0, 18.0); // Clamp within the range
                              return Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                    ' Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                    ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                                style: TextStyle(fontSize: paragraphFontSize),
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate spacing based on the available width
                              double sizedBoxHeight = constraints.maxWidth * 0.02;
                              sizedBoxHeight = sizedBoxHeight.clamp(5.0, 20.0); // Clamp within the range
                              return SizedBox(height: sizedBoxHeight);
                            },
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate font size based on the available width
                              double paragraphFontSize = constraints.maxWidth * 0.02;
                              paragraphFontSize = paragraphFontSize.clamp(12.0, 18.0); // Clamp within the range
                              return Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                    ' Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                                    ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                                style: TextStyle(
                                  fontSize: paragraphFontSize,
                                ),
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Calculate spacing based on the available width
                              double sizedBoxHeight = constraints.maxWidth * 0.03;
                              sizedBoxHeight = sizedBoxHeight.clamp(20.0, 30.0); // Clamp within the range
                              return SizedBox(height: sizedBoxHeight);
                            },
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShoeOverviewPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFF246EB9),
                                // Text color & Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Corner radius
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: buttonPadding,
                                  vertical: buttonPadding,
                                ),
                              ),
                              child: Text(
                                'Explore more',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
