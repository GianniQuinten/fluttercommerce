import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widget/app_bar.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double contactFormPadding;
    // Check if the platform is Android and adjust padding accordingly
    if (defaultTargetPlatform == TargetPlatform.android) {
      contactFormPadding = screenWidth * 0.1;
    } else {
      contactFormPadding = screenWidth * 0.20;
    }

    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'), // Use the AppBar widget
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              contactFormPadding, 25, contactFormPadding, 25),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double fontSize = constraints.maxWidth * 0.1;
                  double titleFontsize = fontSize.clamp(24, 32); // Clamp within the range
                  double contactTitleFontSize = fontSize.clamp(20, 28); // Clamp within the range
                  double infoFontSize = fontSize.clamp(8, 18); // Clamp within the range

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'JustShoes',
                        style: TextStyle(
                          fontSize: titleFontsize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: contactTitleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Email: contact@justshoes.com',
                        style: TextStyle(
                          fontSize: infoFontSize,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Phone: +1 234 567 890',
                        style: TextStyle(
                          fontSize: infoFontSize,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Address: 123 Shoe Street, Footwear City, USA',
                        style: TextStyle(
                          fontSize: infoFontSize,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Instagram: @justshoes',
                        style: TextStyle(
                          fontSize: infoFontSize,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'LinkedIn: JustShoes Inc.',
                        style: TextStyle(
                          fontSize: infoFontSize,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Twitter: @justshoes',
                        style: TextStyle(
                          fontSize: infoFontSize,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}