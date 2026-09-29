import 'package:cloud_firestore/cloud_firestore.dart';

import 'media_item.dart';

class WatchlistEntry {
  const WatchlistEntry({
    required this.mediaKey,
    required this.tmdbId,
    required this.mediaType,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.addedAt,
  });

  final String mediaKey;
  final int tmdbId;
  final MediaType mediaType;
  final String title;
  final String? posterPath;
  final String? releaseDate;
  final DateTime? addedAt;

  MediaItem get media => MediaItem(
    tmdbId: tmdbId,
    mediaType: mediaType,
    title: title,
    overview: '',
    posterPath: posterPath,
    backdropPath: null,
    releaseDate: releaseDate,
    voteAverage: 0,
    genreIds: const [],
  );

  factory WatchlistEntry.fromFirestore(String key, Map<String, dynamic> data) =>
      WatchlistEntry(
        mediaKey: key,
        tmdbId: (data['tmdbId'] as num).toInt(),
        mediaType: MediaType.values.byName(data['mediaType'] as String),
        title: data['title'] as String,
        posterPath: data['posterPath'] as String?,
        releaseDate: data['releaseDate'] as String?,
        addedAt: (data['addedAt'] as Timestamp?)?.toDate(),
      );
}
