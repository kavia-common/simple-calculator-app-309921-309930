import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator_frontend/main.dart';

void main() {
  testWidgets('Calculator app renders basic UI', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    // Should render some key controls.
    expect(find.text('C'), findsOneWidget);
    expect(find.text('⌫'), findsOneWidget);
    expect(find.text('='), findsOneWidget);

    // Operators.
    expect(find.text('+'), findsOneWidget);
    expect(find.text('−'), findsOneWidget);
    expect(find.text('×'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);

    // Digits.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);

    // There should be a scaffold background.
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
