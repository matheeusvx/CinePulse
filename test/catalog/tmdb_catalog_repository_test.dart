import 'package:cinepulse/features/catalog/data/repositories/tmdb_catalog_repository.dart';
import 'package:cinepulse/features/catalog/data/services/tmdb_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('busca usa Bearer e retorna somente movie/tv', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/3/search/multi');
      expect(request.url.queryParameters['query'], 'Filme teste');
      expect(request.headers['Authorization'], 'Bearer TOKEN_TESTE_SEM_VALOR');
      return http.Response('''{
        "results": [
          {"id": 1, "media_type": "movie", "title": "Filme"},
          {"id": 2, "media_type": "tv", "name": "Série"},
          {"id": 3, "media_type": "person", "name": "Pessoa"}
        ]
      }''', 200);
    });
    final repository = TmdbCatalogRepository(
      TmdbClient(token: 'TOKEN_TESTE_SEM_VALOR', client: client),
    );

    final results = await repository.search('Filme teste');
    expect(results.map((item) => item.mediaKey), ['movie_1', 'tv_2']);
    client.close();
  });
}
