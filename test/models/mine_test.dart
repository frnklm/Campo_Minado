import 'package:campo_minado/models/field.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Field', () {
    test('Campo com explosão', () {
      Field f = Field(line: 0, column: 0);
      f.mining();

      expect(f.open, throwsException);
    });
    test('Campo sem explosão', () {
      Field f = Field(line: 0, column: 0);
      f.open();

      expect(f.opened, isTrue);
    });
    test('Adcionar não vizinho', () {
      Field f1 = Field(line: 0, column: 0);
      Field f2 = Field(line: 1, column: 3);
      f1.addNeighbor(f2);
      expect(f1.neighbors.isEmpty, isTrue);
    });
    test('Adcionar vizinho', () {
      Field f1 = Field(line: 3, column: 3);
      Field f2 = Field(line: 3, column: 4);
      Field f3 = Field(line: 2, column: 4);
      Field f4 = Field(line: 4, column: 4);
      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);
      expect(f1.neighbors.length, 3);
    });
  });
}
