# Pasta de Evidências de Execução & QA — CinePulse 📸

Esta pasta destina-se ao armazenamento de todas as evidências comprobatórias de funcionamento do CinePulse para a avaliação do professor.

---

## 📁 Estrutura de Arquivos Recomendada

```text
docs/evidencias/
├── README.md                           # Este guia de organização
├── logs/
│   ├── flutter_doctor.txt              # Saída do comando flutter doctor
│   ├── flutter_analyze.txt             # Saída comprovando zero erros de lint
│   └── flutter_test.txt                # Saída comprovando aprovação nos testes de widget
├── screenshots/
│   ├── 01_home_mobile.png              # Tela Descobrir com MoodTags e Destaques
│   ├── 02_spoiler_safe_interacao.png   # Card de Spoiler Safe antes e depois do clique
│   ├── 03_diario_assistidos.png        # Tela Diário com histórico de obras
│   ├── 04_listas_categorias.png        # Tela Listas com contadores
│   ├── 05_perfil_pulsematch.png        # Tela Perfil com métricas e gráfico circular do PulseMatch
│   └── 06_layout_desktop_wide.png      # Demonstração da barra lateral em telas amplas
```

---

## 📋 Checklist de Evidências Antes da Entrega

- [ ] **Log `flutter doctor`:** Salvo em `logs/flutter_doctor.txt` comprovando ambiente saudável.
- [ ] **Log `flutter analyze`:** Salvo em `logs/flutter_analyze.txt` comprovando `No issues found!`.
- [ ] **Log `flutter test`:** Salvo em `logs/flutter_test.txt` comprovando `All tests passed!`.
- [ ] **Capturas de Tela (Screenshots):** Capturas nítidas em alta resolução em `screenshots/` comprovando o funcionamento da interface.

