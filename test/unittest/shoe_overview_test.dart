import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:fluttercommerce/src/views/home_page.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';
import 'package:fluttercommerce/src/widget/app_bar.dart';
import 'package:fluttercommerce/src/providers/shoe_provider.dart';
import 'package:fluttercommerce/src/models/shoe_model.dart';
import 'package:fluttercommerce/src/services/sneaks_api_service.dart';

class MockSneaksApiService extends Mock implements SneaksApiService {}

void main() {
  testWidgets('ShoeOverviewPage loads at least 15 shoes after navigation', (WidgetTester tester) async {
    final mockApiService = MockSneaksApiService();
    final shoes = List<Shoe>.generate(
      15,
          (index) => Shoe(
        id: 'id_$index',
        name: 'Shoe $index',
        brand: 'Brand $index',
        price: 100.0 + index,
        imageUrl: '',
      ),
    );

    // Explicitly specify the expected arguments for fetchProducts
    when(mockApiService.fetchProducts('Sneaker', 20)).thenAnswer((_) async => shoes.map((shoe) => shoe.toJson()).toList());

    // Create the ShoeProvider
    final shoeProvider = ShoeProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<ShoeProvider>(
        create: (_) => shoeProvider,
        child: MaterialApp(
          home: Scaffold(
            appBar: MyAppBar(title: 'Test AppBar'),
            body: HomePage(),
          ),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Shoes'), findsOneWidget);

    // Navigate to Shoes page
    await tester.tap(find.text('Shoes'));
    await tester.pumpAndSettle();

    // Verify ShoeOverviewPage is displayed and contains at least 15 shoes
    expect(find.byType(ShoeOverviewPage), findsOneWidget);
    expect(find.byType(GestureDetector), findsAtLeastNWidgets(15));
  });
}

extension on Shoe {
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'shoeName': name,
      'brand': brand,
      'thumbnail': imageUrl,
      'retailPrice': price,
    };
  }
}
