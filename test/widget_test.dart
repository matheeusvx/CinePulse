import 'dart:async';

import 'package:cinepulse/features/auth/data/repositories/auth_repository.dart';
import 'package:cinepulse/features/profile/presentation/profile_page.dart';
import 'package:cinepulse/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.isAuthenticated = false});

  final _changes = StreamController<bool>.broadcast();

  @override
  bool isAuthenticated;

  @override
  Stream<bool> get authStateChanges => _changes.stream;

  @override
  Future<void> signIn({required String email, required String password}) async {
    isAuthenticated = true;
    _changes.add(true);
  }

  @override
  Future<bool> signUp({required String email, required String password}) async {
    return false; // Simula confirmação de e-mail habilitada.
  }

  @override
  Future<void> signOut() async {
    isAuthenticated = false;
    _changes.add(false);
  }

  Future<void> dispose() => _changes.close();
}

void main() {
  testWidgets('sessão restaurada abre o AppShell CP4', (tester) async {
    final repository = FakeAuthRepository(isAuthenticated: true);
    addTearDown(repository.dispose);
    await tester.pumpWidget(CinePulseApp(authRepository: repository));

    expect(find.text('Descobrir'), findsOneWidget);
    expect(find.text('Diário'), findsOneWidget);
    expect(find.text('Listas'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });

  testWidgets('login abre AppShell e logout retorna à autenticação',
      (tester) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.dispose);
    await tester.pumpWidget(CinePulseApp(authRepository: repository));
    expect(find.text('Entrar'), findsWidgets);

    await tester.enterText(
        find.byType(EditableText).first, 'teste@cinepulse.com');
    await tester.enterText(find.byType(EditableText).last, 'senha123');
    await tester.tap(find.text('Entrar').last);
    await tester.pumpAndSettle();
    expect(find.text('Descobrir'), findsOneWidget);

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Sair da conta'),
      300,
      scrollable: find.descendant(
        of: find.byType(ProfilePage),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.tap(find.text('Sair da conta'));
    await tester.pumpAndSettle();
    expect(find.text('Ainda não tem conta? Cadastre-se'), findsOneWidget);
  });

  testWidgets('cadastro sem sessão orienta confirmação do e-mail',
      (tester) async {
    final repository = FakeAuthRepository();
    addTearDown(repository.dispose);
    await tester.pumpWidget(CinePulseApp(authRepository: repository));
    await tester.tap(find.text('Ainda não tem conta? Cadastre-se'));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(EditableText).first, 'novo@cinepulse.com');
    await tester.enterText(find.byType(EditableText).last, 'senha123');
    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();
    expect(find.text('Cadastro realizado. Confirme seu e-mail e depois entre.'),
        findsOneWidget);
  });
}
