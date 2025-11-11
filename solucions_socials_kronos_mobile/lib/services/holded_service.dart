import 'dart:convert';
import 'package:http/http.dart' as http;
import 'holded_client.dart';

class HoldedService {
  HoldedService(this.client);
  final HoldedClient client;

  Future<List<dynamic>> getPurchases({
    required HoldedCompany company,
    int page = 1,
    int limit = 100,
    String sort = 'created-desc',
    String? starttmp,
    String? endtmp,
    String? contactid,
    String? paid,
  }) async {
    final http.Response resp = await client.get(
      '/documents/purchase',
      company: company,
      query: <String, String>{
        'page': '$page',
        'limit': '$limit',
        'sort': sort,
        if (starttmp != null) 'starttmp': starttmp,
        if (endtmp != null) 'endtmp': endtmp,
        if (contactid != null) 'contactid': contactid,
        if (paid != null) 'paid': paid,
      },
    );
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final dynamic data = jsonDecode(resp.body);
      if (data is List<dynamic>) return data;
      return <dynamic>[];
    }
    throw Exception('Holded error ${resp.statusCode}: ${resp.body}');
  }

  Future<List<dynamic>> _getAllPages(
    Future<List<dynamic>> Function(int page) fetchPage,
  ) async {
    const int limit = 100;
    int page = 1;
    final List<dynamic> all = <dynamic>[];
    while (true) {
      final List<dynamic> batch = await fetchPage(page);
      if (batch.isEmpty) break;
      all.addAll(batch);
      if (batch.length < limit) break;
      page++;
    }
    return all;
  }

  Future<List<dynamic>> getAllPendingPurchases(HoldedCompany company) async {
    final List<dynamic> pending = await _getAllPages(
      (int p) => getPurchases(company: company, page: p, paid: '0'),
    );
    final List<dynamic> partial = await _getAllPages(
      (int p) => getPurchases(company: company, page: p, paid: '2'),
    );
    final Set<dynamic> seen = <dynamic>{};
    final List<dynamic> merged = <dynamic>[];
    for (final dynamic d in <dynamic>[...pending, ...partial]) {
      final dynamic id = (d as Map<String, dynamic>)['id'];
      if (id != null && !seen.contains(id)) {
        seen.add(id);
        merged.add(d);
      }
    }
    return merged;
  }

  Future<List<dynamic>> getOverduePurchases(HoldedCompany company) {
    final String today = DateTime.now().toIso8601String().split('T').first;
    return _getAllPages(
      (int p) => getPurchases(company: company, page: p, paid: '0', endtmp: today),
    );
  }

  Future<List<dynamic>> getAllContacts(HoldedCompany company) async {
    const int limit = 100;
    int page = 1;
    final List<dynamic> all = <dynamic>[];
    while (true) {
      final http.Response resp = await client.get(
        '/contacts',
        company: company,
        query: <String, String>{'page': '$page', 'limit': '$limit'},
      );
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final List<dynamic> data = (jsonDecode(resp.body) as List<dynamic>);
        if (data.isEmpty) break;
        all.addAll(data);
        if (data.length < limit) break;
        page++;
      } else {
        throw Exception('Holded error ${resp.statusCode}: ${resp.body}');
      }
    }
    return all;
  }
}


