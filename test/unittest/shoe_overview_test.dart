import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:fluttercommerce/src/models/shoe_model.dart';
import 'package:fluttercommerce/src/providers/shoe_provider.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';

class MockShoeProvider extends Mock implements ShoeProvider {
  // Implementing a custom behavior for the shoes property
  @override
  List<Shoe> get shoes => List<Shoe>.generate(8, (index) => Shoe(
    id: 'id_$index',
    name: 'Shoe $index',
    brand: 'Brand $index',
    imageUrl: 'https://example.com/shoe_$index.png',
    price: 100,
  ));

  // Implementing a custom behavior for the isLoading property
  @override
  bool get isLoading => false; // Assuming isLoading should be false during testing
}

void main() {
  testWidgets('Check if there are at least 8 shoes loaded', (WidgetTester tester) async {
    final mockShoeProvider = MockShoeProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<ShoeProvider>.value(
        value: mockShoeProvider,
        child: MaterialApp(
          home: ShoeOverviewPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final gestureDetectorFinder = find.byType(GestureDetector);
    final gestureDetectorsCount = tester.widgetList(gestureDetectorFinder).length;
    print('Number of GestureDetector widgets found: $gestureDetectorsCount');

    expect(gestureDetectorFinder, findsAtLeastNWidgets(8));
  });
}

