import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/auth_gate.dart';
import 'features/profile/data/repositories/profile_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
      CinePulseApp(
        authRepository: FirebaseAuthRepository(
          FirebaseAuth.instance,
          ProfileRepository(FirebaseAuth.instance, FirebaseFirestore.instance),
        ),
      ),
    );
  } on UnsupportedError catch (error) {
    runApp(
      _ConfigurationErrorApp(message: error.message ?? 'Configure o Firebase.'),
    );
  } on FirebaseException {
    runApp(
      const _ConfigurationErrorApp(
        message:
            'Não foi possível iniciar o Firebase. Confira a configuração em SETUP.md.',
      ),
    );
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
