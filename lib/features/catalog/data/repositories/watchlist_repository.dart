import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/media_item.dart';
import '../models/watchlist_entry.dart';

abstract class WatchlistRepository {
  Future<bool> contains(String mediaKey);
  Stream<bool> watch(String mediaKey);
  Stream<List<WatchlistEntry>> watchAll();
  Future<void> add(MediaItem media);
  Future<void> remove(String mediaKey);
  Future<void> toggle(MediaItem media);
}

class FirestoreWatchlistRepository implements WatchlistRepository {
  const FirestoreWatchlistRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _document(String mediaKey) {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Usuário não autenticado.');
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('watchlist')
        .doc(mediaKey);
  }

  @override
  Future<bool> contains(String mediaKey) async =>
      (await _document(mediaKey).get()).exists;

  @override
  Stream<bool> watch(String mediaKey) =>
      _document(mediaKey).snapshots().map((snapshot) => snapshot.exists);

  @override
  Stream<List<WatchlistEntry>> watchAll() => _firestore
      .collection('users')
      .doc(
        _auth.currentUser?.uid ??
            (throw StateError('Usuário não autenticado.')),
      )
      .collection('watchlist')
      .snapshots()
      .map((snapshot) {
        final entries = snapshot.docs
            .map((doc) => WatchlistEntry.fromFirestore(doc.id, doc.data()))
            .toList();
        entries.sort(
          (a, b) =>
              (b.addedAt ?? DateTime(0)).compareTo(a.addedAt ?? DateTime(0)),
        );
        return entries;
      });

  @override
  Future<void> add(MediaItem media) => _document(media.mediaKey).set({
    'tmdbId': media.tmdbId,
    'mediaType': media.mediaType.name,
    'title': media.title,
    'posterPath': media.posterPath,
    'releaseDate': media.releaseDate,
    'addedAt': FieldValue.serverTimestamp(),
  });

  @override
  Future<void> remove(String mediaKey) => _document(mediaKey).delete();

  @override
  Future<void> toggle(MediaItem media) async {
    if (await contains(media.mediaKey)) {
      await remove(media.mediaKey);
    } else {
      await add(media);
    }
  }
}
