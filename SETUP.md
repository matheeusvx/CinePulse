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

4. Na raiz deste repositório, execute `flutterfire configure --platforms=android`, selecione o projeto Firebase real e registre/vincule o app Android com o package name **`com.cinepulse.cinepulse`**. A CLI gera/atualiza `lib/firebase_options.dart` e `android/app/google-services.json` localmente; ambos estão ignorados pelo Git. Não preencha esses arquivos manualmente com valores inventados.
5. Confira no Console se o app Android registrado tem o mesmo package name. Para e-mail/senha e Firestore não há credencial privilegiada para colocar no aplicativo. Os identificadores gerados pelo FlutterFire não são secrets.

## Configurar TMDB

1. Obtenha o **API Read Access Token** na conta TMDB. Use esse token como Bearer para a API v3; não use a chave diretamente no código.
2. Copie `config/local.example.json` para `config/local.json` e substitua o placeholder. **Nunca faça commit de `config/local.json`**; o arquivo está no `.gitignore`.
3. A busca e o detalhe de filmes/séries usam esse token. Sem ele, o restante do app continua abrindo e a busca mostra uma mensagem de configuração pendente. Como `--dart-define-from-file` incorpora valores no aplicativo, o token distribuído em um APK não é um segredo forte; considere um backend/proxy antes de distribuição pública.

As novas regras em `firestore.rules` cobrem `users/{uid}/watchlist/{mediaKey}` e `users/{uid}/ratings/{mediaKey}`. **Publique a versão atualizada no Firebase Console** antes de testar essas ações. Elas não são publicadas automaticamente.

Em um clone novo, execute a etapa 4 antes do build, pois `lib/firebase_options.dart` não é versionado. Depois, execute o app para validar cadastro, criação do documento `users/{uid}`, login, restauração de sessão e logout contra seu projeto real.

## Executar e validar

```powershell
flutter pub get
flutter analyze
flutter test
flutter run --dart-define-from-file=config/local.json
flutter build apk --debug --dart-define-from-file=config/local.json
```

O APK release exige assinatura própria antes de distribuição. A configuração Android atual ainda usa assinatura de debug no tipo `release`.

As quatro telas CP4 continuam como protótipo visual; dados e métricas nelas exibidos são demonstrativos. O documento Firestore de usuário fica preparado para integração futura sem alterar essas telas nesta etapa.
