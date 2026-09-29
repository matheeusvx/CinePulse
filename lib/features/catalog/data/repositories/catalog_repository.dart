import '../models/media_item.dart';

abstract class CatalogRepository {
  bool get isConfigured => true;
  Future<List<MediaItem>> search(String query);
  Future<MediaItem> getDetails(MediaType type, int tmdbId);
}

class CatalogException implements Exception {
  const CatalogException(this.message);
  final String message;

  @override
  String toString() => message;
}

class MissingTmdbTokenException extends CatalogException {
  const MissingTmdbTokenException()
    : super(
        'Catálogo não configurado. Defina TMDB_READ_ACCESS_TOKEN em config/local.json.',
      );
}
