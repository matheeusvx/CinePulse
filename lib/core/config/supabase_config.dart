import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class SupabaseConfig {
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static Future<void> initialize() async {
    if (url.isEmpty || anonKey.isEmpty) {
      throw const FormatException(
        'Configuração do Supabase ausente. Forneça SUPABASE_URL e '
        'SUPABASE_ANON_KEY com --dart-define-from-file=config/local.json. '
        'Consulte SETUP.md.',
      );
    }
    await Supabase.initialize(url: url, publishableKey: anonKey);
  }
}
