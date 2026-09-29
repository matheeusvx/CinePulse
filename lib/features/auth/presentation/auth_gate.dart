import 'package:flutter/material.dart';

import '../../home/presentation/app_shell.dart';
import '../../catalog/catalog_dependencies.dart';
import '../data/repositories/auth_repository.dart';
import 'auth_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({
    super.key,
    required this.repository,
    this.catalogDependencies,
  });

  final AuthRepository repository;
  final CatalogDependencies? catalogDependencies;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: repository.authStateChanges,
      initialData: repository.isAuthenticated,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Não foi possível restaurar a sessão. Reinicie o app.',
              ),
            ),
          );
        }
        return snapshot.data == true
            ? AppShell(
                onSignOut: repository.signOut,
                catalogDependencies: catalogDependencies,
              )
            : AuthPage(repository: repository);
      },
    );
  }
}
