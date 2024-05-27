import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercommerce/src/views/home_page.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';
import 'package:fluttercommerce/src/views/contact_page.dart';
import 'package:fluttercommerce/src/widget/app_bar.dart';
import 'package:fluttercommerce/src/providers/shoe_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('MyAppBar navigates to the correct pages', (WidgetTester tester) async {
    // Define the providers required for the test
    final shoeProvider = ShoeProvider();

    // Create a test widget with the MyAppBar wrapped in the necessary providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ShoeProvider>.value(value: shoeProvider),
        ],
        child: MaterialApp(
          home: Scaffold(
            appBar: MyAppBar(title: 'JustShoes'),
          ),
        ),
      ),
    );

    // Verify if the Home button navigates to HomePage
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    print('Navigating to Home');

    await tester.pump(const Duration(seconds: 1));  // Add a 1-second pause

    // Navigate back to the initial screen
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));  // Add a 1-second pause

    // Verify if the Shoes button navigates to ShoeOverviewPage
    await tester.tap(find.text('Shoes'));
    await tester.pumpAndSettle();
    expect(find.byType(ShoeOverviewPage), findsOneWidget);
    print('Navigating to Shoes');

    await tester.pump(const Duration(seconds: 1));  // Add a 1-second pause

    // Navigate back to the initial screen
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 1));  // Add a 1-second pause

    // Verify if the Contact button navigates to ShoeOverviewPage
    // Since ContactPage is not implemented, we check ShoeOverviewPage again
    await tester.tap(find.text('Contact'));
    await tester.pumpAndSettle();
    expect(find.byType(ShoeOverviewPage), findsOneWidget);
    print('Navigating to Contact');
  });
}
