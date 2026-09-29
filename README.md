# CinePulse

![Logo oficial do CinePulse](assets/brand/cinepulse_logo_oficial.png)

**Versão CP6: `1.0.0+1`** · Flutter para Android · tema escuro

O CinePulse permite descobrir filmes e séries, guardar títulos para assistir, registrar avaliações e acompanhar um diário pessoal. O catálogo vem do TMDB; autenticação e dados do usuário ficam no Firebase. O aplicativo não oferece feed social, recomendações por IA ou comparação de perfis na interface.

## O que funciona

1. Cadastro, login, logout e restauração de sessão com Firebase Authentication.
2. Home com tendências do TMDB, busca e filtros MoodTags determinísticos por gênero. Busca e detalhe aceitam filmes e séries.
3. Watchlist pessoal em `users/{uid}/watchlist/{mediaKey}`.
4. Avaliação de 0,5 a 5 estrelas, MoodTags opcionais, review opcional de até 2.000 caracteres e PulseScore opcional. Marcar como assistido remove o título da Watchlist.
5. Diário com registros por mês, métricas e edição ou exclusão de avaliação.
6. Perfil com dados reais do usuário, totais, nota média, MoodTags frequentes e reviews recentes. Reviews com spoiler ficam ocultas até uma ação explícita.

Dados inexistentes aparecem como estados vazios. O perfil não mostra médias comunitárias ou percentuais fictícios.

## Stack e arquitetura

- **Flutter/Dart:** UI Material 3 com identidade escura CinePulse.
- **TMDB API v3:** tendências, busca, filtros Discover e detalhes; autenticação por Bearer token.
- **Firebase Authentication:** e-mail e senha.
- **Cloud Firestore:** perfil, Watchlist e avaliações isolados pelo `uid` nas regras locais.
- **Feature-First:** `lib/features/auth`, `catalog`, `home`, `diary`, `lists` e `profile`; tema e widgets compartilhados em `lib/core`.
- **Testes:** `flutter_test` com repositórios fake e cliente HTTP simulado, sem acessar serviços reais.

```text
assets/brand/       logo oficial, símbolo do ícone e crédito TMDB
android/            projeto e recursos nativos do APK
config/             exemplo de configuração TMDB
docs/               documentação e protótipos históricos
lib/core/           tema e componentes compartilhados
lib/features/       código por funcionalidade
test/               testes de modelo, cálculo e widgets
firestore.rules     regras para dados por usuário
SETUP.md            configuração local detalhada
```

## Configurar e executar

Requer Flutter 3.35+, Dart 3.9+ e Android SDK. Configure um projeto Firebase real e habilite **Authentication > Email/Password** e **Cloud Firestore**. Execute `flutterfire configure --platforms=android` para gerar localmente `lib/firebase_options.dart` e `android/app/google-services.json`. O package name é `com.cinepulse.cinepulse`. Publique manualmente `firestore.rules` no Firebase Console; o repositório não publica regras.

Obtenha um **API Read Access Token** do TMDB, copie `config/local.example.json` para `config/local.json` e preencha a variável `TMDB_READ_ACCESS_TOKEN`. Esse arquivo e os dois arquivos gerados pelo FlutterFire estão no `.gitignore`. Nunca os versione. `--dart-define-from-file` embute o token no binário, portanto o APK gerado aqui é para teste/entrega acadêmica; distribuição pública pede um proxy para proteger o token.

```powershell
flutter pub get
flutter analyze
flutter test
flutter run --dart-define-from-file=config/local.json
flutter build apk --debug --dart-define-from-file=config/local.json
flutter build apk --release --dart-define-from-file=config/local.json
```

O APK fica em `build/app/outputs/flutter-apk/`. A configuração atual usa **assinatura de debug também no build release**; ela serve à entrega acadêmica e não está pronta para publicação na Play Store. Veja [SETUP.md](SETUP.md) para o passo a passo completo e a geração de ícone/splash.

## Como funcionam os diferenciais

- **MoodTags:** os chips da Home aplicam filtros fixos de gêneros TMDB em filmes e séries. O mapeamento está em [SETUP.md](SETUP.md). É um filtro explicável, sem IA ou dados sociais.
- **PulseScore pessoal:** história, atuação, visual e trilha aceitam notas de 0,5 a 5. Critérios não preenchidos ficam `null`. A média considera somente os critérios preenchidos e é multiplicada por 2 para o cartão visual de 0–10. Sem critérios, não há média. O destaque usa a avaliação detalhada mais recente do próprio usuário.
- **Spoiler Safe:** reviews marcadas com spoiler iniciam ocultas no detalhe, na Home e no Perfil. Revelar um card não revela os demais.
- **PulseMatch:** há somente uma função determinística testada conforme [a especificação do projeto](docs/03-mvp-e-requisitos.md). Com menos de cinco títulos avaliados em comum, o resultado é insuficiente. O aplicativo não compara usuários reais nem apresenta percentual na UI.

## Evolução CP4 → CP5 → CP6

- **CP4:** identidade escura, arquitetura inicial e protótipo visual das telas principais.
- **CP5:** Android, Firebase Auth/Firestore, TMDB, busca, detalhe, Watchlist e avaliação.
- **CP6:** Diário e Perfil ligados aos dados pessoais, review/Spoiler Safe, PulseScore pessoal, estados vazios honestos, identidade oficial, ícone/splash e APK validado.

## Decisões e limites

Os repositórios de catálogo, Watchlist e avaliação isolam serviços externos da UI. Dados das Etapas 2 e 3 continuam compatíveis. O PulseScore não altera o schema existente; as regras Firestore atuais continuam necessárias. O ícone Android usa somente o símbolo da logo oficial para legibilidade em tamanho pequeno; a logo completa aparece no README e no splash anterior ao Android 12.

Não estão implementados feed, seguidores, perfis de terceiros, listas personalizadas, recomendação por IA/ML ou PulseMatch entre usuários na interface. Testes automatizados usam fakes; o fluxo contra Firebase e TMDB reais precisa de validação manual no projeto configurado.

## Créditos do catálogo

![Marca oficial do TMDB](assets/brand/tmdb_logo_oficial.svg)

**This product uses the TMDB API but is not endorsed or certified by TMDB.** Filmes, séries e imagens de catálogo são fornecidos pelo [TMDB](https://www.themoviedb.org). A marca TMDB usada nos créditos foi obtida da [página oficial de atribuição](https://www.themoviedb.org/about/logos-attribution) e aparece com menos destaque que a marca CinePulse, conforme os [requisitos oficiais](https://developer.themoviedb.org/docs/faq).

Projeto acadêmico CinePulse/FIAP. Os documentos em `docs/` preservam o histórico de produto e UX e podem descrever ideias ainda não implementadas.
