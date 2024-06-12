import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:fluttercommerce/src/models/shoe_model.dart';
import 'package:fluttercommerce/src/providers/shoe_provider.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';

class MockShoeProvider extends Mock implements ShoeProvider {}

void main() {
  testWidgets('Check if there are at least 8 shoes loaded', (WidgetTester tester) async {
    final mockShoeProvider = MockShoeProvider();

    final shoeList = List<Shoe>.generate(8, (index) => Shoe(
      id: 'id_$index',
      name: 'Shoe $index',
      brand: 'Brand $index',
      imageUrl: '',
      price: 100.0,
    ));

    when(mockShoeProvider.shoes).thenReturn(shoeList);

    await tester.pumpWidget(
      ChangeNotifierProvider<ShoeProvider>.value(
        value: mockShoeProvider,
        child: MaterialApp(
          home: ShoeOverviewPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Print the number of GestureDetector widgets found to debug
    final gestureDetectorFinder = find.byType(GestureDetector);
    final gestureDetectorsCount = tester.widgetList(gestureDetectorFinder).length;
    print('Number of GestureDetector widgets found: $gestureDetectorsCount');

    // Verify that there are at least 8 shoe items in the grid.
    expect(gestureDetectorFinder, findsNWidgets(8));
  });
}
