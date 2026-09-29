# Setup local do CinePulse

O repositório já contém a estrutura Android. Não é necessário criar outro projeto Flutter.

## Pré-requisitos

- Flutter 3.35+ (Dart 3.9+) e Android SDK (`flutter doctor`).
- Um projeto Firebase ao qual você tenha acesso no Firebase Console.
- Firebase CLI e FlutterFire CLI para vincular o app ao projeto real.

## Configurar Firebase

1. No Firebase Console, crie ou selecione um projeto. Em **Authentication > Sign-in method**, habilite **Email/Password**.
2. Em **Firestore Database**, crie o banco de dados e escolha a região. Publique o conteúdo de `firestore.rules` na aba **Rules**. As regras permitem apenas acesso ao documento `users/{uid}` do próprio usuário; não há acesso a outros documentos nesta etapa.
3. Instale e autentique as ferramentas oficiais, se necessário:

   ```powershell
   firebase login
   dart pub global activate flutterfire_cli
   ```

4. Na raiz deste repositório, execute `flutterfire configure --platforms=android`, selecione o projeto Firebase real e registre/vincule o app Android com o package name **`com.cinepulse.cinepulse`**. A CLI deverá substituir o marcador `lib/firebase_options.dart` pelo arquivo gerado oficialmente. Não preencha esse arquivo manualmente com valores inventados.
5. Confira no Console se o app Android registrado tem o mesmo package name. Para e-mail/senha e Firestore não há credencial privilegiada para colocar no aplicativo. Os identificadores gerados pelo FlutterFire não são secrets.

Sem a etapa 4, o projeto continua analisável, testável e compilável, mas ao abrir mostra uma mensagem de configuração pendente. Depois de gerar `lib/firebase_options.dart`, execute o app para validar cadastro, criação do documento `users/{uid}`, login, restauração de sessão e logout contra seu projeto real.

## Executar e validar

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
flutter build apk --debug
```

O APK release exige assinatura própria antes de distribuição. A configuração Android atual ainda usa assinatura de debug no tipo `release`.

As quatro telas CP4 continuam como protótipo visual; dados e métricas nelas exibidos são demonstrativos. O documento Firestore de usuário fica preparado para integração futura sem alterar essas telas nesta etapa.
