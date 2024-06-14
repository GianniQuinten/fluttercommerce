import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:fluttercommerce/src/models/shoe_model.dart';
import 'package:fluttercommerce/src/providers/shoe_provider.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';

class MockShoeProvider extends Mock implements ShoeProvider {
  List<Shoe> _shoes = [
    Shoe(id: '1', name: 'Shoe 1', brand: "Nike", imageUrl: 'https://example.com/shoe_1.png', price: 100),
    Shoe(id: '2', name: 'Shoe 2', brand: "Adidas", imageUrl: 'https://example.com/shoe_2.png', price: 120),
  ];

  List<Shoe> _filteredShoes = []; // Initialize an empty filtered list

  @override
  List<Shoe> get shoes => _filteredShoes.isEmpty ? _shoes : _filteredShoes;

  @override
  bool get isLoading => false;

  @override
  void filterShoes({String? brand, String? color}) {
    _shoes.where((shoe) => shoe.brand == brand).toList();
    notifyListeners();
  }

  @override
  Future<void> reloadShoes({String keyword = ""}) async {
    _filteredShoes = _shoes; // Reset filtered shoes to all shoes
    notifyListeners();
  }
}

void main() {
  testWidgets('Filter shoes by brand', (WidgetTester tester) async {
    // Create a mock instance of ShoeProvider
    final mockShoeProvider = MockShoeProvider();

    // Build the widget under test
    await tester.pumpWidget(
      ChangeNotifierProvider<ShoeProvider>.value(
        value: mockShoeProvider,
        child: MaterialApp(
          home: ShoeOverviewPage(),
        ),
      ),
    );

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle();

    // Verify initial state
    expect(find.text('Shoe 1'), findsOneWidget);
    expect(find.text('Shoe 2'), findsOneWidget);

    // Tap on the brand dropdown and select 'Nike'
    await tester.tap(find.byKey(Key('brandDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nike').last);
    await tester.pumpAndSettle();

    // Verify filtered results
    expect(find.text('Shoe 1'), findsOneWidget);

    // Tap on the reset button to clear filters
    await tester.tap(find.byKey(Key('resetButton')));
    await tester.pumpAndSettle();

    // Verify all shoes are displayed again
    expect(find.text('Shoe 1'), findsOneWidget);
    expect(find.text('Shoe 2'), findsOneWidget);
  });
}
