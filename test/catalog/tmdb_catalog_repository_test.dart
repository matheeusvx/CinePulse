import 'package:cinepulse/features/catalog/data/repositories/tmdb_catalog_repository.dart';
import 'package:cinepulse/features/catalog/data/models/mood_tag.dart';
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

  test(
    'tendências ignoram person e MoodTag usa Discover com gêneros',
    () async {
      final paths = <String>[];
      final client = MockClient((request) async {
        paths.add(request.url.path);
        expect(
          request.headers['Authorization'],
          'Bearer TOKEN_TESTE_SEM_VALOR',
        );
        if (request.url.path.contains('trending')) {
          return http.Response('''{"results":[
          {"id":1,"media_type":"movie","title":"Filme"},
          {"id":2,"media_type":"tv","name":"Série"},
          {"id":3,"media_type":"person","name":"Pessoa"}
        ]}''', 200);
        }
        expect(
          request.url.queryParameters['with_genres'],
          request.url.path.endsWith('movie') ? '53' : '9648',
        );
        return http.Response(
          request.url.path.endsWith('movie')
              ? '{"results":[{"id":4,"title":"Tenso filme"}]}'
              : '{"results":[{"id":5,"name":"Tenso série"}]}',
          200,
        );
      });
      final repository = TmdbCatalogRepository(
        TmdbClient(token: 'TOKEN_TESTE_SEM_VALOR', client: client),
      );
      expect((await repository.trending()).map((item) => item.mediaKey), [
        'movie_1',
        'tv_2',
      ]);
      expect(
        (await repository.byMood(MoodTag.tenso)).map((item) => item.mediaKey),
        ['movie_4', 'tv_5'],
      );
      expect(
        paths,
        containsAll([
          '/3/trending/all/week',
          '/3/discover/movie',
          '/3/discover/tv',
        ]),
      );
      client.close();
    },
  );
}
