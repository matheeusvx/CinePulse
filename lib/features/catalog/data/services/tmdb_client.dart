import 'dart:convert';

import 'package:http/http.dart' as http;

import '../repositories/catalog_repository.dart';

class TmdbClient {
  TmdbClient({required String token, http.Client? client})
    : _token = token,
      _client = client ?? http.Client();

  final String _token;
  final http.Client _client;

  bool get isConfigured => _token.trim().isNotEmpty;

  Future<Map<String, dynamic>> getJson(
    String path, [
    Map<String, String> query = const {},
  ]) async {
    if (_token.trim().isEmpty) throw const MissingTmdbTokenException();
    final uri = Uri.https('api.themoviedb.org', '/3/$path', {
      'language': 'pt-BR',
      ...query,
    });
    try {
      final response = await _client
          .get(
            uri,
            headers: {
              'accept': 'application/json',
              'Authorization': 'Bearer $_token',
            },
          )
          .timeout(const Duration(seconds: 12));
      if (response.statusCode == 401 || response.statusCode == 403) {
        throw const CatalogException(
          'Token TMDB inválido ou sem permissão. Confira a configuração.',
        );
      }
      if (response.statusCode != 200) {
        throw const CatalogException(
          'Não foi possível consultar o catálogo. Tente novamente.',
        );
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } on CatalogException {
      rethrow;
    } catch (_) {
      throw const CatalogException(
        'Falha de conexão com o TMDB. Tente novamente.',
      );
    }
  }
}
