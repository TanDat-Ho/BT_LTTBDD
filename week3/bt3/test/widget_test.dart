// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bt3/main.dart';
import 'package:bt3/utils/constants.dart';

void main() {
  testWidgets('Library Management App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LibraryManagementApp());

    // Verify that the app loads with bottom navigation
    expect(find.byType(BottomNavigationBar), findsOneWidget);
      // Verify navigation labels exist
    expect(find.text('Quản lý'), findsOneWidget);
    expect(find.text('Danh sách Sách'), findsOneWidget);
    expect(find.text('Người dùng'), findsOneWidget);

    // Test navigation to books tab
    await tester.tap(find.text('Danh sách Sách'));
    await tester.pump();
    
    // Should find search field in books screen
    expect(find.byType(TextField), findsAtLeastNWidgets(1));
  });
}
