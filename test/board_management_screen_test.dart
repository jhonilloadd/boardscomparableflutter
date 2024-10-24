/*import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boardscomparableflutter/board_management_screen.dart';
import 'package:boardscomparableflutter/api_service.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  testWidgets('BoardManagementScreen UI Test', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BoardManagementScreen(mockApiService)));

    expect(find.text('Board Management'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsNWidgets(3));
  });

  testWidgets('Add Board Test', (WidgetTester tester) async {
    when(() => mockApiService.registerBoard(any()))
        .thenAnswer((_) async => true);

    await tester
        .pumpWidget(MaterialApp(home: BoardManagementScreen(mockApiService)));

    await tester.enterText(
        find.byKey(ValueKey('boardNameField')), 'Test Board');
    await tester.enterText(find.byKey(ValueKey('boardWidthField')), '10');
    await tester.enterText(find.byKey(ValueKey('boardHeightField')), '20');
    await tester.tap(find.byKey(ValueKey('addBoardButton')));
    await tester.pump();

    verify(() => mockApiService.registerBoard(any())).called(1);
    expect(find.text('Board added successfully'), findsOneWidget);
  });

  testWidgets('Add Board Validation Test', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: BoardManagementScreen(mockApiService)));

    await tester.tap(find.byKey(ValueKey('addBoardButton')));
    await tester.pump();

    expect(find.text('Please fill all fields'), findsOneWidget);
  });

  testWidgets('Get Boards Test', (WidgetTester tester) async {
    when(() => mockApiService.getBoards()).thenAnswer((_) async => [
          {'id': '1', 'name': 'Board 1', 'width': 10, 'height': 20},
          {'id': '2', 'name': 'Board 2', 'width': 15, 'height': 25},
        ]);

    await tester
        .pumpWidget(MaterialApp(home: BoardManagementScreen(mockApiService)));

    await tester.tap(find.byKey(ValueKey('getBoardsButton')));
    await tester.pump();

    verify(() => mockApiService.getBoards()).called(1);
    expect(find.text('Board 1'), findsOneWidget);
    expect(find.text('Board 2'), findsOneWidget);
  });
}*/
