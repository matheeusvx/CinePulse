import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  bool get isAuthenticated;
  Stream<bool> get authStateChanges;

  Future<bool> signUp({required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
}

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;

  @override
  bool get isAuthenticated {
    final session = _client.auth.currentSession;
    return session != null && !session.isExpired;
  }

  @override
  Stream<bool> get authStateChanges => _client.auth.onAuthStateChange
      .map((event) => event.session != null && !event.session!.isExpired);

  @override
  Future<bool> signUp({required String email, required String password}) async {
    final response =
        await _client.auth.signUp(email: email, password: password);
    return response.session != null;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => _client.auth.signOut();
}
