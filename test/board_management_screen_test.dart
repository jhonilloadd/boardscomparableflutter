import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:boardscomparableflutter/services/api_service.dart';
import 'package:boardscomparableflutter/views/board_view.dart';
import 'package:boardscomparableflutter/model/board.dart'; // Add this import

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  testWidgets('BoardView UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BoardView(mockApiService)));

    expect(find.text('Board Management'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4)); // Adjust if needed
    expect(find.byType(ElevatedButton), findsNWidgets(3)); // Adjust if needed
  });

  testWidgets('Add Board Test', (WidgetTester tester) async {
    when(() => mockApiService.registerBoard(any()))
        .thenAnswer((_) async => Board());

    await tester.pumpWidget(MaterialApp(home: BoardView(mockApiService)));

    await tester.enterText(
        find.byKey(const ValueKey('boardNameField')), 'Test Board');
    await tester.enterText(
        find.byKey(const ValueKey('boardModelField')), 'Model X');
    await tester.enterText(
        find.byKey(const ValueKey('boardBrandField')), 'Brand Y');
    await tester.tap(find.byKey(const ValueKey('addBoardButton')));
    await tester.pump();

    verify(() => mockApiService.registerBoard(any(that: isA<Board>())))
        .called(1);
    expect(find.text('Board added successfully'), findsOneWidget);
  });

  testWidgets('Add Board Validation Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BoardView(mockApiService)));

    await tester.tap(find.byKey(const ValueKey('addBoardButton')));
    await tester.pump();

    expect(find.text('Please fill all fields'), findsOneWidget);
  });

  testWidgets('Get Boards Test', (WidgetTester tester) async {
    when(() => mockApiService.getBoards()).thenAnswer((_) async => [
          Board(name: 'Board 1', model: 'Model A', brand: 'Brand X'),
          Board(name: 'Board 2', model: 'Model B', brand: 'Brand Y'),
        ]);

    await tester.pumpWidget(MaterialApp(home: BoardView(mockApiService)));

    await tester.tap(find.byKey(const ValueKey('getBoardsButton')));
    await tester.pump();

    verify(() => mockApiService.getBoards()).called(1);
    expect(find.text('Board 1'), findsOneWidget);
    expect(find.text('Board 2'), findsOneWidget);
    expect(find.text('Model A'), findsOneWidget);
    expect(find.text('Model B'), findsOneWidget);
    expect(find.text('Brand X'), findsOneWidget);
    expect(find.text('Brand Y'), findsOneWidget);
  });
}
