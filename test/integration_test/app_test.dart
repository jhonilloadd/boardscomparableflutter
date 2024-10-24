import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:boardscomparableflutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the board management button, navigate to board management screen',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify that we are on the HomePage
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Board Management'), findsOneWidget);

      // Tap the board management button
      await tester.tap(find.text('Board Management'));
      await tester.pumpAndSettle();

      // Verify that we are now on the BoardManagementScreen
      expect(find.text('Board Management'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsNWidgets(3));

      // Test adding a board
      await tester.enterText(find.byKey(ValueKey('boardNameField')), 'Test Board');
      await tester.enterText(find.byKey(ValueKey('boardWidthField')), '10');
      await tester.enterText(find.byKey(ValueKey('boardHeightField')), '20');
      await tester.tap(find.byKey(ValueKey('addBoardButton')));
      await tester.pumpAndSettle();

      // Verify that the board was added successfully
      expect(find.text('Board added successfully'), findsOneWidget);

      // Test getting boards
      await tester.tap(find.byKey(ValueKey('getBoardsButton')));
      await tester.pumpAndSettle();

      // Verify that the added board is displayed
      expect(find.text('Test Board'), findsOneWidget);
    });
  });
}