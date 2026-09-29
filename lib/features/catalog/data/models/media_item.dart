enum MediaType { movie, tv }

class MediaItem {
  const MediaItem({
    required this.tmdbId,
    required this.mediaType,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
    this.genres = const [],
    this.runtimeMinutes,
    this.seasonCount,
  });

  final int tmdbId;
  final MediaType mediaType;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double voteAverage;
  final List<int> genreIds;
  final List<String> genres;
  final int? runtimeMinutes;
  final int? seasonCount;

  String get mediaKey => '${mediaType.name}_$tmdbId';
  String get typeLabel => mediaType == MediaType.movie ? 'Filme' : 'Série';
  String get year => releaseDate != null && releaseDate!.length >= 4
      ? releaseDate!.substring(0, 4)
      : 'Ano indisponível';

  Uri? get posterUrl => imageUrl(posterPath, size: 'w342');
  Uri? get backdropUrl => imageUrl(backdropPath, size: 'w780');

  static Uri? imageUrl(String? path, {required String size}) {
    if (path == null || path.isEmpty) return null;
    return Uri.https('image.tmdb.org', '/t/p/$size$path');
  }

  static MediaItem? fromSearchJson(Map<String, dynamic> json) {
    final type = switch (json['media_type']) {
      'movie' => MediaType.movie,
      'tv' => MediaType.tv,
      _ => null,
    };
    if (type == null || json['id'] is! num) return null;
    return fromTmdbJson(json, type);
  }

  static MediaItem fromTmdbJson(Map<String, dynamic> json, MediaType type) {
    final genreIds =
        (json['genre_ids'] as List<dynamic>?)
            ?.whereType<num>()
            .map((id) => id.toInt())
            .toList() ??
        const <int>[];
    final genres =
        (json['genres'] as List<dynamic>?)
            ?.whereType<Map<String, dynamic>>()
            .map((genre) => genre['name'])
            .whereType<String>()
            .toList() ??
        const <String>[];
    return MediaItem(
      tmdbId: (json['id'] as num).toInt(),
      mediaType: type,
      title:
          (type == MediaType.movie ? json['title'] : json['name']) as String? ??
          'Título indisponível',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate:
          (type == MediaType.movie
                  ? json['release_date']
                  : json['first_air_date'])
              as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      genreIds: genreIds,
      genres: genres,
      runtimeMinutes: (json['runtime'] as num?)?.toInt(),
      seasonCount: (json['number_of_seasons'] as num?)?.toInt(),
    );
  }
}
