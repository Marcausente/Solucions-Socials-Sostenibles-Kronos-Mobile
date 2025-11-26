import 'package:flutter_test/flutter_test.dart';
import 'package:solucions_socials_kronos_mobile/utils/roles.dart';

void main() {
  group('RoleUtils Tests', () {
    group('toCanonical', () {
      test('convierte "admin" correctamente', () {
        expect(RoleUtils.toCanonical('admin'), equals('admin'));
      });

      test('convierte "administrador" a "admin"', () {
        expect(RoleUtils.toCanonical('administrador'), equals('admin'));
      });

      test('convierte "management" correctamente', () {
        expect(RoleUtils.toCanonical('management'), equals('management'));
      });

      test('convierte "gestion" a "management"', () {
        expect(RoleUtils.toCanonical('gestion'), equals('management'));
      });

      test('convierte "gestión" (con tilde) a "management"', () {
        expect(RoleUtils.toCanonical('gestión'), equals('management'));
      });

      test('convierte "manager" correctamente', () {
        expect(RoleUtils.toCanonical('manager'), equals('manager'));
      });

      test('convierte "jefe" a "manager"', () {
        expect(RoleUtils.toCanonical('jefe'), equals('manager'));
      });

      test('convierte "supervisor" a "manager"', () {
        expect(RoleUtils.toCanonical('supervisor'), equals('manager'));
      });

      test('convierte "user" correctamente', () {
        expect(RoleUtils.toCanonical('user'), equals('user'));
      });

      test('convierte "usuario" a "user"', () {
        expect(RoleUtils.toCanonical('usuario'), equals('user'));
      });

      test('convierte "empleado" a "user"', () {
        expect(RoleUtils.toCanonical('empleado'), equals('user'));
      });

      test('maneja null devolviendo "user"', () {
        expect(RoleUtils.toCanonical(null), equals('user'));
      });

      test('maneja string vacío devolviendo "user"', () {
        expect(RoleUtils.toCanonical(''), equals('user'));
      });

      test('maneja rol desconocido devolviendo "user"', () {
        expect(RoleUtils.toCanonical('desconocido'), equals('user'));
      });

      test('es case-insensitive', () {
        expect(RoleUtils.toCanonical('ADMIN'), equals('admin'));
        expect(RoleUtils.toCanonical('Admin'), equals('admin'));
        expect(RoleUtils.toCanonical('aDmIn'), equals('admin'));
      });

      test('trimea espacios antes de procesar', () {
        expect(RoleUtils.toCanonical('  admin  '), equals('admin'));
        expect(RoleUtils.toCanonical('  manager  '), equals('manager'));
      });
    });

    group('label', () {
      test('devuelve "Administrador" para "admin"', () {
        expect(RoleUtils.label('admin'), equals('Administrador'));
      });

      test('devuelve "Gestión" para "management"', () {
        expect(RoleUtils.label('management'), equals('Gestión'));
      });

      test('devuelve "Jefe" para "manager"', () {
        expect(RoleUtils.label('manager'), equals('Jefe'));
      });

      test('devuelve "Usuario" para "user"', () {
        expect(RoleUtils.label('user'), equals('Usuario'));
      });

      test('devuelve "Usuario" para rol desconocido', () {
        expect(RoleUtils.label('desconocido'), equals('Usuario'));
      });

      test('devuelve "Usuario" para string vacío', () {
        expect(RoleUtils.label(''), equals('Usuario'));
      });
    });

    group('canonical list', () {
      test('contiene todos los roles canónicos', () {
        expect(RoleUtils.canonical, hasLength(4));
        expect(RoleUtils.canonical, contains('admin'));
        expect(RoleUtils.canonical, contains('management'));
        expect(RoleUtils.canonical, contains('manager'));
        expect(RoleUtils.canonical, contains('user'));
      });

      test('no contiene duplicados', () {
        final Set<String> uniqueRoles = RoleUtils.canonical.toSet();
        expect(uniqueRoles.length, equals(RoleUtils.canonical.length));
      });
    });

    group('flujo completo', () {
      test('convierte y obtiene label correctamente', () {
        const String input = 'administrador';
        final String canonical = RoleUtils.toCanonical(input);
        final String labelText = RoleUtils.label(canonical);

        expect(canonical, equals('admin'));
        expect(labelText, equals('Administrador'));
      });

      test('funciona con roles en mayúsculas', () {
        const String input = 'JEFE';
        final String canonical = RoleUtils.toCanonical(input);
        final String labelText = RoleUtils.label(canonical);

        expect(canonical, equals('manager'));
        expect(labelText, equals('Jefe'));
      });
    });
  });
}
