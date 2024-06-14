import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../providers/shoe_provider.dart';
import 'shoe_details_page.dart';
import '../widget/app_bar.dart';

class ShoeOverviewPage extends StatefulWidget {
  @override
  _ShoeOverviewPageState createState() => _ShoeOverviewPageState();
}

class _ShoeOverviewPageState extends State<ShoeOverviewPage> {
  String? selectedBrand;
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'JustShoes'), // Use the AppBar widget
      body: Column(
        children: [
          _buildFilterSection(context),
          Expanded(
            child: Consumer<ShoeProvider>(
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
                    int crossAxisCount = width > 1200
                        ? 4
                        : width > 800
                        ? 3
                        : 2;

                    double maxItemHeight;
                    if (defaultTargetPlatform != TargetPlatform.android) {
                      maxItemHeight = crossAxisCount == 4
                          ? 320
                          : crossAxisCount == 3
                          ? 265
                          : 267.5;
                    } else {
                      maxItemHeight = 190;
                    }

                    double itemWidth =
                        (width - (crossAxisCount - 1) * 25) / crossAxisCount;

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
                                builder: (context) =>
                                    ShoeDetailsPage(
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
                              color: Colors.white,
                              // White background for the card
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // Give a shadow to the container
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: AspectRatio(
                                        aspectRatio: 2 / 1,
                                        // Adjust the aspect ratio as needed
                                        child: shoe.imageUrl.isNotEmpty
                                            ? Image.network(
                                          shoe.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                              stackTrace) {
                                            return Icon(Icons
                                                .error); // Display an error icon if the image fails to load
                                          },
                                        )
                                            : Icon(Icons
                                            .image_not_supported), // Display a placeholder icon if the URL is empty
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shoe.name,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(shoe.brand,
                                          style: TextStyle(fontSize: 12)),
                                      Text('\$${shoe.price.toString()}',
                                          style: TextStyle(fontSize: 12)),
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
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    final shoeProvider = Provider.of<ShoeProvider>(context, listen: false);

    // 10 Famous shoe brands for the filter
    final List<String> shoeBrands = [
      'Nike',
      'Adidas',
      'Puma',
      'Reebok',
      'New Balance',
      'Converse',
      'Vans',
      'Under Armour',
      'Timberland',
      'Burberry',
    ];

    // 10 Common colors for the filter
    final List<String> shoeColors = [
      'Black',
      'White',
      'Grey',
      'Red',
      'Blue',
      'Yellow',
      'Purple',
      'Pink',
      'Orange',
      'Brown',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  key: Key('brandDropdown'),
                  value: selectedBrand,
                  isExpanded: true,
                  hint: Text(
                    defaultTargetPlatform == TargetPlatform.android ? 'Brand' : 'Select a brand',
                  ),
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBrand = newValue;
                    });
                  },
                  items: shoeBrands
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  key: Key('colorDropdown'),
                  value: selectedColor,
                  isExpanded: true,
                  hint: Text(
                    defaultTargetPlatform == TargetPlatform.android ? 'Color' : 'Select a color',
                  ),
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedColor = newValue;
                    });
                  },
                  items: shoeColors
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        key: Key('searchButton'),
                        onPressed: () {
                          shoeProvider.filterShoes(
                            brand: selectedBrand,
                            color: selectedColor,
                          );
                        },
                        style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF246EB9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Corner radius
                          ),
                        ),
                        icon: const Icon(Icons.search),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: IconButton(
                        key: Key('resetButton'),
                        onPressed: () {
                          setState(() {
                            selectedBrand = null;
                            selectedColor = null;
                          });
                          shoeProvider.reloadShoes();
                        },
                        style: IconButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Corner radius
                          ),
                        ),
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}