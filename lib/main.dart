import 'package:flutter/material.dart';

import 'core/config/supabase_config.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SupabaseConfig.initialize();
    runApp(CinePulseApp(
      authRepository: SupabaseAuthRepository(Supabase.instance.client),
    ));
  } on FormatException catch (error) {
    runApp(_ConfigurationErrorApp(message: error.message));
  }
}

class CinePulseApp extends StatelessWidget {
  const CinePulseApp({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinePulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: AuthGate(repository: authRepository),
    );
  }
}

class _ConfigurationErrorApp extends StatelessWidget {
  const _ConfigurationErrorApp({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'CinePulse',
        theme: AppTheme.dark,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(message, textAlign: TextAlign.center),
            ),
          ),
        ),
      );
}
