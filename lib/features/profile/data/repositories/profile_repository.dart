import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile.dart';

class ProfileRepository {
  const ProfileRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _document(String uid) =>
      _firestore.collection('users').doc(uid);

  Future<void> ensureFor(String uid) async {
    final document = _document(uid);
    if ((await document.get()).exists) return;
    await document.set({
      'displayName': null,
      'username': null,
      'avatarUrl': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Profile?> getMine() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final snapshot = await _document(user.uid).get();
    final data = snapshot.data();
    return data == null ? null : Profile.fromFirestore(user.uid, data);
  }

  Future<void> updateMine({
    String? displayName,
    String? username,
    String? avatarUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('Usuário não autenticado.');
    await _document(user.uid).update({
      'displayName': displayName,
      'username': username,
      'avatarUrl': avatarUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
