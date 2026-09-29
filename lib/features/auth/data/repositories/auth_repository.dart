import 'package:firebase_auth/firebase_auth.dart';

import '../../../profile/data/repositories/profile_repository.dart';

abstract class AuthRepository {
  bool get isAuthenticated;
  Stream<bool> get authStateChanges;

  Future<void> signUp({required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._profiles);

  final FirebaseAuth _auth;
  final ProfileRepository _profiles;

  @override
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  Stream<bool> get authStateChanges =>
      _auth.authStateChanges().map((user) => user != null);

  @override
  Future<void> signUp({required String email, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw StateError('Cadastro sem usuário retornado.');
    try {
      await _profiles.ensureFor(user.uid);
    } catch (_) {
      await _auth.signOut();
      rethrow;
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) throw StateError('Login sem usuário retornado.');
    try {
      await _profiles.ensureFor(user.uid);
    } catch (_) {
      await _auth.signOut();
      rethrow;
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
