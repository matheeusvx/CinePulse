import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/media_item.dart';

abstract class RatingRepository {
  Future<double?> getRating(String mediaKey);
  Future<void> save(MediaItem media, double rating);
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
  Future<void> save(MediaItem media, double rating) async {
    if (rating < 0.5 || rating > 5 || (rating * 2) % 1 != 0) {
      throw ArgumentError.value(rating, 'rating', 'Use uma nota de 0.5 a 5.0.');
    }
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
      'rating': rating,
      'watchedAt': watchedAt,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    batch.delete(watchlistDocument);
    await batch.commit();
  }
}
