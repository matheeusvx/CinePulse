import 'package:cinepulse/features/catalog/data/models/media_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parsing multi aceita filme e série e ignora pessoa', () {
    final movie = MediaItem.fromSearchJson({
      'id': 42,
      'media_type': 'movie',
      'title': 'Filme teste',
      'release_date': '2024-03-01',
      'vote_average': 8.4,
      'genre_ids': [18, 878],
    });
    final tv = MediaItem.fromSearchJson({
      'id': 42,
      'media_type': 'tv',
      'name': 'Série teste',
      'first_air_date': '2023-10-02',
    });
    final person = MediaItem.fromSearchJson({
      'id': 42,
      'media_type': 'person',
      'name': 'Pessoa teste',
    });

    expect(movie?.mediaKey, 'movie_42');
    expect(movie?.year, '2024');
    expect(movie?.genreIds, [18, 878]);
    expect(tv?.mediaKey, 'tv_42');
    expect(tv?.title, 'Série teste');
    expect(person, isNull);
  });

  test('detalhe interpreta duração ou temporadas', () {
    final movie = MediaItem.fromTmdbJson({
      'id': 1,
      'title': 'Filme',
      'runtime': 121,
      'genres': [
        {'id': 18, 'name': 'Drama'},
      ],
    }, MediaType.movie);
    final tv = MediaItem.fromTmdbJson({
      'id': 2,
      'name': 'Série',
      'number_of_seasons': 3,
    }, MediaType.tv);

    expect(movie.runtimeMinutes, 121);
    expect(movie.genres, ['Drama']);
    expect(tv.seasonCount, 3);
  });
}
