import '../models/media_item.dart';
import '../models/mood_tag.dart';
import '../services/tmdb_client.dart';
import 'catalog_repository.dart';

class TmdbCatalogRepository implements CatalogRepository {
  const TmdbCatalogRepository(this._client);

  final TmdbClient _client;

  @override
  bool get isConfigured => _client.isConfigured;

  @override
  Future<List<MediaItem>> search(String query) async {
    if (query.trim().length < 2) return const [];
    final data = await _client.getJson('search/multi', {
      'query': query.trim(),
      'include_adult': 'false',
    });
    return (data['results'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MediaItem.fromSearchJson)
        .whereType<MediaItem>()
        .toList();
  }

  @override
  Future<MediaItem> getDetails(MediaType type, int tmdbId) async {
    final data = await _client.getJson('${type.name}/$tmdbId');
    return MediaItem.fromTmdbJson(data, type);
  }

  @override
  Future<List<MediaItem>> trending() async {
    final data = await _client.getJson('trending/all/week');
    return (data['results'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MediaItem.fromSearchJson)
        .whereType<MediaItem>()
        .toList();
  }

  @override
  Future<List<MediaItem>> byMood(MoodTag mood) async {
    // IDs from TMDB movie and TV genre lists; see SETUP.md.
    final (movieGenre, tvGenre) = switch (mood) {
      MoodTag.tenso => (53, 9648),
      MoodTag.leve => (35, 35),
      MoodTag.reflexivo => (18, 18),
      MoodTag.epico => (12, 10759),
      MoodTag.emocionante => (10749, 18),
    };
    final data = await Future.wait([
      _client.getJson('discover/movie', {
        'with_genres': '$movieGenre',
        'sort_by': 'popularity.desc',
        'include_adult': 'false',
      }),
      _client.getJson('discover/tv', {
        'with_genres': '$tvGenre',
        'sort_by': 'popularity.desc',
        'include_adult': 'false',
      }),
    ]);
    final movies = (data[0]['results'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((json) => MediaItem.fromTmdbJson(json, MediaType.movie));
    final shows = (data[1]['results'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((json) => MediaItem.fromTmdbJson(json, MediaType.tv));
    return [...movies.take(10), ...shows.take(10)];
  }
}
