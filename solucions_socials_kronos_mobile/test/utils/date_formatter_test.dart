import 'package:flutter_test/flutter_test.dart';
import 'package:solucions_socials_kronos_mobile/utils/date_formatter.dart';

void main() {
  group('DateFormatter Tests', () {
    group('formatDate', () {
      test('formatea fecha con patrón por defecto (dd/MM/yyyy)', () {
        final DateTime date = DateTime(2025, 11, 26);
        final String result = DateFormatter.formatDate(date);
        expect(result, equals('26/11/2025'));
      });

      test('formatea fecha con patrón personalizado', () {
        final DateTime date = DateTime(2025, 11, 26);
        final String result = DateFormatter.formatDate(
          date,
          pattern: 'yyyy-MM-dd',
        );
        expect(result, equals('2025-11-26'));
      });

      test('formatea fecha con formato largo', () {
        final DateTime date = DateTime(2025, 11, 26);
        final String result = DateFormatter.formatDate(
          date,
          pattern: 'EEEE, d MMMM yyyy',
        );
        // Nota: El resultado dependerá del locale del sistema
        expect(result, isNotEmpty);
      });

      test('maneja correctamente días de un dígito', () {
        final DateTime date = DateTime(2025, 1, 5);
        final String result = DateFormatter.formatDate(date);
        expect(result, equals('05/01/2025'));
      });

      test('maneja correctamente meses de un dígito', () {
        final DateTime date = DateTime(2025, 3, 15);
        final String result = DateFormatter.formatDate(date);
        expect(result, equals('15/03/2025'));
      });
    });

    group('formatDateTime', () {
      test('formatea fecha y hora con patrón por defecto', () {
        final DateTime dateTime = DateTime(2025, 11, 26, 14, 30);
        final String result = DateFormatter.formatDateTime(dateTime);
        expect(result, equals('26/11/2025 14:30'));
      });

      test('formatea fecha y hora con patrón personalizado', () {
        final DateTime dateTime = DateTime(2025, 11, 26, 14, 30, 45);
        final String result = DateFormatter.formatDateTime(
          dateTime,
          pattern: 'yyyy-MM-dd HH:mm:ss',
        );
        expect(result, equals('2025-11-26 14:30:45'));
      });

      test('formatea correctamente hora de medianoche', () {
        final DateTime dateTime = DateTime(2025, 11, 26, 0, 0);
        final String result = DateFormatter.formatDateTime(dateTime);
        expect(result, equals('26/11/2025 00:00'));
      });

      test('formatea correctamente hora al mediodía', () {
        final DateTime dateTime = DateTime(2025, 11, 26, 12, 0);
        final String result = DateFormatter.formatDateTime(dateTime);
        expect(result, equals('26/11/2025 12:00'));
      });

      test('formatea correctamente minutos de un dígito', () {
        final DateTime dateTime = DateTime(2025, 11, 26, 9, 5);
        final String result = DateFormatter.formatDateTime(dateTime);
        expect(result, equals('26/11/2025 09:05'));
      });

      test('formatea con formato de 12 horas', () {
        final DateTime dateTime = DateTime(2025, 11, 26, 14, 30);
        final String result = DateFormatter.formatDateTime(
          dateTime,
          pattern: 'dd/MM/yyyy hh:mm a',
        );
        expect(result, equals('26/11/2025 02:30 PM'));
      });
    });
  });
}
