import 'package:flutter/material.dart';

import '../views/home_page.dart';
import '../views/shoe_overview_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  MyAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
          child: Text('Home'),
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
          child: Text('Shoes'),
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
          child: Text('Contact'),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Navigate to the cart page
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
