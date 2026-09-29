import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/auth_gate.dart';
import 'features/catalog/catalog_dependencies.dart';
import 'features/catalog/data/repositories/rating_repository.dart';
import 'features/catalog/data/repositories/tmdb_catalog_repository.dart';
import 'features/catalog/data/repositories/watchlist_repository.dart';
import 'features/catalog/data/services/tmdb_client.dart';
import 'features/profile/data/repositories/profile_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    runApp(
      CinePulseApp(
        authRepository: FirebaseAuthRepository(
          auth,
          ProfileRepository(auth, firestore),
        ),
        catalogDependencies: CatalogDependencies(
          catalog: TmdbCatalogRepository(
            TmdbClient(
              token: const String.fromEnvironment('TMDB_READ_ACCESS_TOKEN'),
            ),
          ),
          watchlist: FirestoreWatchlistRepository(auth, firestore),
          ratings: FirestoreRatingRepository(auth, firestore),
          profile: ProfileRepository(auth, firestore),
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
  const CinePulseApp({
    super.key,
    required this.authRepository,
    this.catalogDependencies,
  });

  final AuthRepository authRepository;
  final CatalogDependencies? catalogDependencies;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinePulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: AuthGate(
        repository: authRepository,
        catalogDependencies: catalogDependencies,
      ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/brand/cinepulse_symbol_transparente.png',
                width: 72,
                height: 72,
                semanticLabel: 'CinePulse',
              ),
              const SizedBox(height: 12),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    ),
  );
}
