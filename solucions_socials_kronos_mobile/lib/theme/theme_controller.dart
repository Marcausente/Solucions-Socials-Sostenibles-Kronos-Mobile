import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Currency _currency = Currency.eur;

  ThemeMode get themeMode => _themeMode;
  Currency get currency => _currency;

  bool get isDark => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void toggleDark(bool value) {
    setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void setCurrency(Currency newCurrency) {
    if (_currency == newCurrency) return;
    _currency = newCurrency;
    notifyListeners();
  }
}

enum Currency {
  eur('Euro', '€'),
  usd('Dólar Estadounidense', '\$'),
  gbp('Libra Esterlina', '£'),
  jpy('Yen Japonés', '¥'),
  chf('Franco Suizo', 'Fr'),
  cad('Dólar Canadiense', 'C\$'),
  aud('Dólar Australiano', 'A\$');

  const Currency(this.label, this.symbol);
  final String label;
  final String symbol;
}
