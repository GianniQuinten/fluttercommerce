import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercommerce/src/views/home_page.dart';
import 'package:fluttercommerce/src/views/shoe_overview_page.dart';
import 'package:fluttercommerce/src/views/contact_page.dart';
import 'package:fluttercommerce/src/widget/app_bar.dart';
import 'package:fluttercommerce/src/providers/shoe_provider.dart';
import 'package:provider/provider.dart';
import 'shoe_overview_test.dart';

void main() {
  final mockApiService = MockSneaksApiService();
  final shoeProvider = ShoeProvider(apiService: mockApiService);

  Future<void> setupWidget(WidgetTester tester) async {
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
  }

  group('MyAppBar Navigation Tests', () {
    testWidgets('Navigate to HomePage', (WidgetTester tester) async {
      await setupWidget(tester);

      // Tap on Home and check navigation
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      print('Navigating to Home');
    });

    testWidgets('Navigate to ShoeOverviewPage', (WidgetTester tester) async {
      await setupWidget(tester);

      // Tap on Shoes and check navigation
      await tester.tap(find.text('Shoes'));
      await tester.pumpAndSettle();
      expect(find.byType(ShoeOverviewPage), findsOneWidget);
      print('Navigating to Shoes');
    });

    testWidgets('Navigate to ContactPage', (WidgetTester tester) async {
      await setupWidget(tester);

      // Tap on Contact and check navigation
      await tester.tap(find.text('Contact'));
      await tester.pumpAndSettle();
      expect(find.byType(ContactPage), findsOneWidget);
      print('Navigating to Contact');
    });
  });
}
