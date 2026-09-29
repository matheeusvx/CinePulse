import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/media_item.dart';
import '../models/mood_tag.dart';
import '../models/rating_entry.dart';

abstract class RatingRepository {
  Future<double?> getRating(String mediaKey);
  Future<RatingEntry?> getEntry(String mediaKey);
  Stream<List<RatingEntry>> watchAll();
  Future<void> save(MediaItem media, RatingDraft draft);
  Future<void> delete(String mediaKey);
}

class FirestoreRatingRepository implements RatingRepository {
  const FirestoreRatingRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  String get _uid {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Usuário não autenticado.');
    return uid;
  }

  DocumentReference<Map<String, dynamic>> _ratingDocument(String mediaKey) =>
      _firestore
          .collection('users')
          .doc(_uid)
          .collection('ratings')
          .doc(mediaKey);

  @override
  Future<double?> getRating(String mediaKey) async {
    final snapshot = await _ratingDocument(mediaKey).get();
    return (snapshot.data()?['rating'] as num?)?.toDouble();
  }

  @override
  Future<RatingEntry?> getEntry(String mediaKey) async {
    final snapshot = await _ratingDocument(mediaKey).get();
    final data = snapshot.data();
    return data == null ? null : RatingEntry.fromFirestore(snapshot.id, data);
  }

  @override
  Stream<List<RatingEntry>> watchAll() => _firestore
      .collection('users')
      .doc(_uid)
      .collection('ratings')
      .snapshots()
      .map((snapshot) {
        final entries = snapshot.docs
            .map((doc) => RatingEntry.fromFirestore(doc.id, doc.data()))
            .toList();
        entries.sort(
          (a, b) => (b.watchedAt ?? DateTime(0)).compareTo(
            a.watchedAt ?? DateTime(0),
          ),
        );
        return entries;
      });

  @override
  Future<void> save(MediaItem media, RatingDraft draft) async {
    final ratingDocument = _ratingDocument(media.mediaKey);
    final previous = await ratingDocument.get();
    final watchedAt =
        previous.data()?['watchedAt'] ?? FieldValue.serverTimestamp();
    final watchlistDocument = _firestore
        .collection('users')
        .doc(_uid)
        .collection('watchlist')
        .doc(media.mediaKey);
    final batch = _firestore.batch();
    batch.set(ratingDocument, {
      'tmdbId': media.tmdbId,
      'mediaType': media.mediaType.name,
      'title': media.title,
      'posterPath': media.posterPath,
      'rating': draft.rating,
      'moodTags': draft.moodTags.map((tag) => tag.label).toList(),
      'reviewText': draft.reviewText,
      'containsSpoiler': draft.containsSpoiler,
      'pulseScore': draft.pulseScore?.isEmpty == false
          ? draft.pulseScore!.toMap()
          : null,
      'watchedAt': watchedAt,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    batch.delete(watchlistDocument);
    await batch.commit();
  }

  @override
  Future<void> delete(String mediaKey) => _ratingDocument(mediaKey).delete();
}
