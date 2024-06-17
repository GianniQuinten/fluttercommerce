import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercommerce/src/views/shopping_cart_page.dart';
import 'package:fluttercommerce/src/widget/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:fluttercommerce/src/providers/cart_provider.dart';

void main() {
  testWidgets('MyAppBar should navigate to ShoppingCartPage when shopping cart icon is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: MaterialApp(
          home: Scaffold(
            appBar: MyAppBar(title: 'JustShoes'),
            body: Container(),
          ),
          routes: {
            ShoppingCartPage.routeName: (context) => ShoppingCartPage(),
          },
        ),
      ),
    );

    // Verify if MyAppBar is present
    expect(find.byType(MyAppBar), findsOneWidget);

    // Tap the shopping cart icon
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    // Verify if ShoppingCartPage is pushed
    expect(find.byType(ShoppingCartPage), findsOneWidget);
    print('Opening Shopping Cart');
  });
}
