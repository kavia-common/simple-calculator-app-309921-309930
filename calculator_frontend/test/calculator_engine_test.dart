import 'package:flutter_test/flutter_test.dart';

import 'package:calculator_frontend/calculator/calculator_engine.dart';

void main() {
  CalculatorEngine pressAll(List<CalculatorKey> keys) {
    final engine = CalculatorEngine();
    for (final k in keys) {
      engine.apply(k);
    }
    return engine;
  }

  test('addition', () {
    final e = pressAll([
      CalculatorKey.digit1,
      CalculatorKey.add,
      CalculatorKey.digit2,
      CalculatorKey.equals,
    ]);

    expect(e.displayResult, '3');
    expect(e.displayInput, '3');
  });

  test('multiplication', () {
    final e = pressAll([
      CalculatorKey.digit7,
      CalculatorKey.multiply,
      CalculatorKey.digit8,
      CalculatorKey.equals,
    ]);

    expect(e.displayResult, '56');
  });

  test('left-to-right chaining (2 + 3 × 4 => 20)', () {
    final e = pressAll([
      CalculatorKey.digit2,
      CalculatorKey.add,
      CalculatorKey.digit3,
      CalculatorKey.multiply,
      CalculatorKey.digit4,
      CalculatorKey.equals,
    ]);

    // Basic calculators often evaluate left-to-right without precedence.
    expect(e.displayResult, '20');
  });

  test('decimal input and formatting', () {
    final e = pressAll([
      CalculatorKey.digit1,
      CalculatorKey.decimal,
      CalculatorKey.digit5,
      CalculatorKey.add,
      CalculatorKey.digit2,
      CalculatorKey.decimal,
      CalculatorKey.digit5,
      CalculatorKey.equals,
    ]);

    expect(e.displayResult, '4');
  });

  test('backspace behavior', () {
    final e = CalculatorEngine();
    e.apply(CalculatorKey.digit1);
    e.apply(CalculatorKey.digit2);
    e.apply(CalculatorKey.digit3);
    e.apply(CalculatorKey.backspace);

    expect(e.displayInput, '12');
  });

  test('clear resets state', () {
    final e = pressAll([
      CalculatorKey.digit9,
      CalculatorKey.add,
      CalculatorKey.digit1,
      CalculatorKey.clear,
    ]);

    expect(e.displayInput, '0');
    expect(e.displayResult, '');
  });

  test('division by zero yields error', () {
    final e = pressAll([
      CalculatorKey.digit8,
      CalculatorKey.divide,
      CalculatorKey.digit0,
      CalculatorKey.equals,
    ]);

    expect(e.displayResult, CalculatorEngine.errorText);
    expect(e.displayInput, '0');
  });
}
