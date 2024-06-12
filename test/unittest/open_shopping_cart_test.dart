import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercommerce/src/views/shopping_cart_page.dart';
import 'package:fluttercommerce/src/widget/app_bar.dart';

void main() {
  testWidgets('MyAppBar should navigate to CartPage when shopping cart icon is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(title: 'JustShoes'),
        body: Container(),
      ),
    ));

    // Verify if MyAppBar is present
    expect(find.byType(MyAppBar), findsOneWidget);

    // Tap the shopping cart icon
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    // Verify if CartPage is pushed
    expect(find.byType(ShoppingCartPage), findsOneWidget);
    print('Opening Shopping Cart');
  });
}
