# Setup local do Flutter

## Pré-requisitos

- Flutter instalado.
- Android Studio ou VS Code com extensão Flutter/Dart.
- Android SDK configurado e/ou dispositivo físico com depuração USB.

## Passos

Se ainda não existe projeto Flutter nativo:

```bash
flutter create cinepulse
cd cinepulse
```

Copie deste pacote para o projeto criado:

- `lib/`
- `assets/`
- `test/`
- `docs/`
- `README.md`
- `pubspec.yaml`
- `analysis_options.yaml`

Depois:

```bash
flutter doctor
flutter pub get
flutter analyze
flutter test
flutter run
```

## Critério de aceite técnico do CP4

- `flutter analyze` sem erros.
- `flutter test` aprovado.
- App abre sem crash.
- Navegação inferior alterna entre Descobrir, Diário, Listas e Perfil.
- Layout não estoura em uma tela Android comum.

## Se `flutter_lints` gerar conflito de versão

Use a versão sugerida automaticamente pelo `flutter pub get`, mantendo a lógica do código intacta.
