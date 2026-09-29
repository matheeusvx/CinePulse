# Setup local do CinePulse

O repositório já contém a estrutura Android. Não é necessário criar outro projeto Flutter nem copiar arquivos.

## Pré-requisitos

- Flutter 3.35+ (Dart 3.9+) e Android SDK instalados (`flutter doctor`).
- Um projeto Supabase com autenticação por e-mail/senha habilitada.

## Configurar Supabase

1. No painel Supabase, copie **Project URL** e a chave **publishable/anon** do projeto. Nunca use `service_role` nem secret key no aplicativo.
2. Copie `config/local.example.json` para `config/local.json` e preencha `SUPABASE_URL` e `SUPABASE_ANON_KEY`. `config/local.json` está no `.gitignore`. A chave anon é pública por natureza; a segurança dos dados depende das políticas RLS.
3. Execute `docs/supabase_profiles.sql` no SQL Editor do projeto. O script cria `profiles`, índices, políticas RLS, atualização de `updated_at` e criação automática de perfil para usuários novos. Se o projeto já possui tabelas/triggers com estes nomes, revise antes de executar.
4. Em **Authentication > Providers**, confirme que o provedor Email está ativo. Se **Confirm email** estiver ativo, o cadastro mostra uma orientação para confirmar o e-mail antes do login. Configure o template/remetente de e-mail conforme o ambiente.

O arquivo local é entregue ao Flutter durante o build. Portanto, a URL e a chave pública ficam no binário gerado. Não coloque credenciais privilegiadas nesse arquivo.

## Executar e validar

```powershell
flutter pub get
flutter analyze
flutter test
flutter run --dart-define-from-file=config/local.json
```

Para gerar APK de desenvolvimento:

```powershell
flutter build apk --debug --dart-define-from-file=config/local.json
```

O APK release exige assinatura própria antes de distribuição. A configuração Android gerada pelo Flutter ainda usa assinatura de debug no tipo `release`; substitua por uma configuração de assinatura segura quando for publicar.

As quatro telas CP4 seguem como protótipo visual. Dados e métricas mostrados nelas ainda são demonstrativos. O perfil Supabase e sua tabela estão preparados para integração futura, sem alterar as telas do CP4 nesta etapa.
