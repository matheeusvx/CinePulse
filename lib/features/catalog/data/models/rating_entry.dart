import 'package:cloud_firestore/cloud_firestore.dart';

import 'media_item.dart';
import 'mood_tag.dart';

bool validHalfStar(double value) =>
    value >= 0.5 && value <= 5 && (value * 2) % 1 == 0;

class PulseScore {
  const PulseScore({this.story, this.acting, this.visual, this.soundtrack});

  final double? story;
  final double? acting;
  final double? visual;
  final double? soundtrack;

  bool get isEmpty =>
      story == null && acting == null && visual == null && soundtrack == null;

  Map<String, dynamic> toMap() => {
    'story': story,
    'acting': acting,
    'visual': visual,
    'soundtrack': soundtrack,
  };

  factory PulseScore.fromMap(Map<String, dynamic> data) => PulseScore(
    story: (data['story'] as num?)?.toDouble(),
    acting: (data['acting'] as num?)?.toDouble(),
    visual: (data['visual'] as num?)?.toDouble(),
    soundtrack: (data['soundtrack'] as num?)?.toDouble(),
  );
}

class RatingDraft {
  RatingDraft({
    required this.rating,
    this.moodTags = const [],
    this.reviewText = '',
    this.containsSpoiler = false,
    this.pulseScore,
  }) {
    if (!validHalfStar(rating)) throw ArgumentError.value(rating, 'rating');
    if (moodTags.length > 3 || moodTags.toSet().length != moodTags.length) {
      throw ArgumentError.value(moodTags, 'moodTags');
    }
    if (reviewText.length > 2000) {
      throw ArgumentError.value(reviewText, 'reviewText');
    }
    for (final value in [
      pulseScore?.story,
      pulseScore?.acting,
      pulseScore?.visual,
      pulseScore?.soundtrack,
    ]) {
      if (value != null && !validHalfStar(value)) {
        throw ArgumentError.value(value, 'pulseScore');
      }
    }
  }

  final double rating;
  final List<MoodTag> moodTags;
  final String reviewText;
  final bool containsSpoiler;
  final PulseScore? pulseScore;
}

class RatingEntry {
  const RatingEntry({
    required this.mediaKey,
    required this.tmdbId,
    required this.mediaType,
    required this.title,
    required this.posterPath,
    required this.rating,
    required this.watchedAt,
    required this.updatedAt,
    this.moodTags = const [],
    this.reviewText = '',
    this.containsSpoiler = false,
    this.pulseScore,
  });

  final String mediaKey;
  final int tmdbId;
  final MediaType mediaType;
  final String title;
  final String? posterPath;
  final double rating;
  final DateTime? watchedAt;
  final DateTime? updatedAt;
  final List<MoodTag> moodTags;
  final String reviewText;
  final bool containsSpoiler;
  final PulseScore? pulseScore;

  bool get hasReview => reviewText.trim().isNotEmpty;

  MediaItem get media => MediaItem(
    tmdbId: tmdbId,
    mediaType: mediaType,
    title: title,
    overview: '',
    posterPath: posterPath,
    backdropPath: null,
    releaseDate: null,
    voteAverage: 0,
    genreIds: const [],
  );

  RatingDraft get draft => RatingDraft(
    rating: rating,
    moodTags: moodTags,
    reviewText: reviewText,
    containsSpoiler: containsSpoiler,
    pulseScore: pulseScore,
  );

  factory RatingEntry.fromFirestore(String key, Map<String, dynamic> data) {
    final rawScore = data['pulseScore'];
    return RatingEntry(
      mediaKey: key,
      tmdbId: (data['tmdbId'] as num).toInt(),
      mediaType: MediaType.values.byName(data['mediaType'] as String),
      title: data['title'] as String,
      posterPath: data['posterPath'] as String?,
      rating: (data['rating'] as num).toDouble(),
      watchedAt: (data['watchedAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      moodTags: (data['moodTags'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .map((tag) => MoodTag.values.where((m) => m.label == tag))
          .where((matches) => matches.isNotEmpty)
          .map((matches) => matches.first)
          .toList(),
      reviewText: data['reviewText'] as String? ?? '',
      containsSpoiler: data['containsSpoiler'] as bool? ?? false,
      pulseScore: rawScore is Map
          ? PulseScore.fromMap(Map<String, dynamic>.from(rawScore))
          : null,
    );
  }
}
