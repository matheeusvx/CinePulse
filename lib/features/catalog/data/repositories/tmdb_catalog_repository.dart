import '../models/media_item.dart';
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
}
