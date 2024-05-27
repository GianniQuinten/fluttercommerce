import 'package:flutter/material.dart';

import '../views/home_page.dart';
import '../views/shoe_overview_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  MyAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0), // Sets a margin of 25px around the AppBar
      height: kToolbarHeight + 45, // Adjust the height so it works with the margin
      child: AppBar(
        backgroundColor: const Color(0xFF89AAE6), // Background color of AppBar
        title: Text(
          title,
          style: const TextStyle(color: Colors.white), // Change title text color to white
        ),
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
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white), // Change button text color to white
            ),
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
            child: const Text(
              'Shoes',
              style: TextStyle(color: Colors.white), // Change button text color to white
            ),
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
            child: const Text(
              'Contact',
              style: TextStyle(color: Colors.white), // Change button text color to white
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0), // Padding for the IconButton
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Color(0xFF246EB9)), // Change icon color to custom blue color
              onPressed: () {
                // Navigate to the cart page
              },
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 45); // Adjust the height so it works with the margin
}