import 'package:flutter_test/flutter_test.dart';
import 'package:solucions_socials_kronos_mobile/config/supabase_config.dart';
import 'package:solucions_socials_kronos_mobile/config/external_services_config.dart';

void main() {
  group('SupabaseConfig Tests', () {
    test('tiene URL configurada', () {
      expect(SupabaseConfig.url, isNotEmpty);
      expect(SupabaseConfig.url, startsWith('https://'));
    });

    test('tiene anonKey configurada', () {
      expect(SupabaseConfig.anonKey, isNotEmpty);
      expect(SupabaseConfig.anonKey.length, greaterThan(50));
    });

    test('URL de Supabase tiene formato correcto', () {
      expect(SupabaseConfig.url, contains('.supabase.co'));
    });
  });

  group('ExternalServicesConfig Tests', () {
    test('githubOwner está configurado', () {
      expect(ExternalServicesConfig.githubOwner, equals('Marcausente'));
    });

    test('githubRepo está configurado', () {
      expect(
        ExternalServicesConfig.githubRepo,
        equals('Solucions-Socials-Sostenibles-Kronos-Mobile'),
      );
    });

    test('githubApiBase tiene URL correcta', () {
      expect(
        ExternalServicesConfig.githubApiBase,
        equals('https://api.github.com'),
      );
    });

    test('puede construir URL de releases', () {
      final String url =
          '${ExternalServicesConfig.githubApiBase}/repos/${ExternalServicesConfig.githubOwner}/${ExternalServicesConfig.githubRepo}/releases/latest';
      
      expect(url, isNotEmpty);
      expect(url, startsWith('https://api.github.com/repos/'));
      expect(url, endsWith('/releases/latest'));
    });
  });
}

