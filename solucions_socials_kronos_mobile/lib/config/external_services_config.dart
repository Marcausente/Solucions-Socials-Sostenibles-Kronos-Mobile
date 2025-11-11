class ExternalServicesConfig {
  // URLs de ping para comprobar estado de servicios externos
  static const String holdedSolucionsUrl = String.fromEnvironment(
    'HOLDED_SOLUCIONS_URL',
    defaultValue: '', // p.ej. https://api.holded.com/some/health
  );
  static const String holdedMenjadorUrl = String.fromEnvironment(
    'HOLDED_MENJADOR_URL',
    defaultValue: '',
  );

  // Tokens opcionales para autorización (si aplica)
  static const String holdedSolucionsToken = String.fromEnvironment(
    'HOLDED_SOLUCIONS_TOKEN',
    defaultValue: '',
  );
  static const String holdedMenjadorToken = String.fromEnvironment(
    'HOLDED_MENJADOR_TOKEN',
    defaultValue: '',
  );
}


