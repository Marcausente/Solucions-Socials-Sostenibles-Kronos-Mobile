import 'package:http/http.dart' as http;
import '../config/external_services_config.dart';

enum HoldedCompany { solucions, menjar }

class HoldedClient {
  HoldedClient({
    String? baseUrl,
  }) : baseUrl = baseUrl ?? ExternalServicesConfig.holdedBaseUrl;

  final String baseUrl;

  String? _keyForCompany(HoldedCompany company) {
    switch (company) {
      case HoldedCompany.solucions:
        return ExternalServicesConfig.holdedApiKeySolucions;
      case HoldedCompany.menjar:
        return ExternalServicesConfig.holdedApiKeyMenjar;
    }
  }

  Map<String, String> _headers(HoldedCompany company, {Map<String, String>? extra}) {
    final String? key = _keyForCompany(company);
    if (key == null || key.isEmpty) {
      throw StateError('API key de Holded no configurada para $company');
    }
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'key': key,
      ...?extra,
    };
  }

  Future<http.Response> get(String path, {required HoldedCompany company, Map<String, String>? query}) {
    final Uri uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    return http.get(uri, headers: _headers(company));
  }

  Future<http.Response> post(String path, {required HoldedCompany company, String? body}) {
    final Uri uri = Uri.parse('$baseUrl$path');
    return http.post(uri, headers: _headers(company), body: body);
  }

  Future<http.Response> delete(String path, {required HoldedCompany company}) {
    final Uri uri = Uri.parse('$baseUrl$path');
    return http.delete(uri, headers: _headers(company));
  }
}


