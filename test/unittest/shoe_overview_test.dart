import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercommerce/src/services/sneaks_api_service.dart';
import 'package:fluttercommerce/src/views/home_page.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';
import 'package:fluttercommerce/src/widget/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:fluttercommerce/src/providers/shoe_provider.dart';

// Mock implementation of SneaksApiService
class MockSneaksApiService extends SneaksApiService {
  @override
  Future<List<Map<String, dynamic>>> fetchProducts(String keyword, int limit) async {
    // Return predefined shoe products for testing
    return List.generate(
      limit,
          (index) => {
        'id': index.toString(),
        'name': 'Shoe $index',
        'price': (index + 1) * 10,
        // Add more fields as needed
      },
    );
  }
}

void main() {
  testWidgets('ShoeOverviewPage loads at least 8 shoes after navigation', (WidgetTester tester) async {
    // Create a mock implementation of SneaksApiService
    final mockApiService = MockSneaksApiService();

    // Create a mock ShoeProvider with the mock SneaksApiService
    final shoeProvider = ShoeProvider(apiService: mockApiService);

    // Trigger the fetchShoes method to load shoe products
    await shoeProvider.fetchShoes("Sneaker", 10);

    await tester.pumpWidget(
      ChangeNotifierProvider<ShoeProvider>.value(
        value: shoeProvider,
        child: MaterialApp(
          home: Scaffold(
            appBar: MyAppBar(title: 'JustShoes'),
            body: HomePage(),
          ),
          routes: {
            '/shoe-overview': (context) => ShoeOverviewPage(),
          },
        ),
      ),
    );

    // Verify if the Shoes button navigates to ShoeOverviewPage
    await tester.tap(find.text('Shoes').first);
    await tester.pumpAndSettle();
    expect(find.byType(ShoeOverviewPage), findsOneWidget);
    print('Navigating to Shoes');

// Verify that there are at least 8 GestureDetector widgets
    expect(find.byType(GestureDetector).evaluate().length, greaterThanOrEqualTo(8));
  });
}

