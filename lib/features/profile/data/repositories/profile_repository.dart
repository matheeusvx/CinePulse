import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile.dart';

class ProfileRepository {
  const ProfileRepository(this._client);

  final SupabaseClient _client;

  Future<Profile?> getMine() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final data = await _client
        .from('profiles')
        .select(
            'id, display_name, username, avatar_url, created_at, updated_at')
        .eq('id', user.id)
        .maybeSingle();
    return data == null ? null : Profile.fromJson(data);
  }

  Future<void> updateMine({
    String? displayName,
    String? username,
    String? avatarUrl,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw StateError('Usuário não autenticado.');
    await _client.from('profiles').update({
      'display_name': displayName,
      'username': username,
      'avatar_url': avatarUrl,
    }).eq('id', user.id);
  }
}
