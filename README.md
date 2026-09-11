# CinePulse 🎬⚡

> **Assista. Avalie. Conecte.**  
> *O pulso da sua experiência com filmes e séries.*

[![Flutter](https://img.shields.io/badge/Flutter-3.3+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Material Design 3](https://img.shields.io/badge/Material%20Design-3-7B1FA2?style=for-the-badge&logo=materialdesign&logoColor=white)](https://m3.material.io)
[![License](https://img.shields.io/badge/License-Academic-blue?style=for-the-badge)](LICENSE)

---

## 📌 Sobre o Projeto

O **CinePulse** é um aplicativo mobile desenvolvido em **Flutter** voltado para cinéfilos e entusiastas do entretenimento que desejam registrar, avaliar e descobrir **filmes e séries** de maneira social, interativa e muito mais expressiva do que uma nota média isolada.

Atualmente, quem consome audiovisual sofre com notas genéricas que não refletem o gosto pessoal, medo de spoilers em fóruns abertos e a fragmentação entre notas no bloco de notas, grupos de WhatsApp e múltiplos serviços de streaming. O CinePulse resolve isso centralizando o diário do usuário e aplicando inteligência social de recomendação.

Este repositório consolida a entrega do **Checkpoint 4 — Idealização, Arquitetura e Protótipo do App**, estruturado com arquitetura escalável e design system pronto para as implementações de backend e persistência nos Checkpoints 5 e 6.

---

## 📱 Justificativa da Escolha / Migração para Flutter & Garantia de Escopo

Atendendo aos critérios e diretrizes do projeto, documentamos a justificativa técnica e estratégica para a adoção do **Flutter**:

1. **Compilação Nativa Multiplataforma (Single Codebase):**  
   O ecossistema do CinePulse requer presença fluida tanto em dispositivos móveis (Android e iOS) quanto em telas expandidas (Web e Tablets). O Flutter permite compilar para código de máquina nativo (ARM/x86) mantendo 60/120 fps constantes, sem pontes de JavaScript (*bridge bottleneck*), garantindo a renderização imersiva do Dark Theme cinematográfico.
2. **Controle Total de Renderização (Skia/Impeller):**  
   A proposta de valor do CinePulse envolve componentes visuais proprietários de alto impacto (barras do *PulseScore*, chip cards do *Spoiler Safe*, gráficos de progresso circular do *PulseMatch* e tags dinâmicas de *MoodTags*). O Flutter desenha cada pixel na tela, eliminando discrepâncias visuais entre fabricantes de dispositivos.
3. **Produtividade e Agilidade (Stateful Hot Reload):**  
   A velocidade de iteração no ciclo de vida de UI e testes rápidos de layouts responsivos reduziu significativamente o tempo de desenvolvimento da Sprint.
4. **Garantia de Cobertura de Escopo das Sprints Anteriores:**  
   A migração e consolidação do escopo em Flutter garantiu 100% de aderência ao que foi concebido nas etapas de ideação, cobrindo integralmente:
   - **Fluxo de Descoberta (`Home`):** Carrosséis de títulos em alta, filtro interativo de humor (*MoodTags*), destaques de pontuação e proteção de spoilers.
   - **Fluxo de Registro (`Diário`):** Histórico de títulos assistidos com datas e notas atribuídas.
   - **Fluxo de Organização (`Listas`):** Categorização por Watchlist e listas temáticas com contadores.
   - **Fluxo Social e Métricas (`Perfil`):** Identificação do usuário, estatísticas de consumo e demonstração do indicador de compatibilidade *PulseMatch*.
   - **Responsividade Total:** Suporte tanto para dimensões móveis quanto para desktop/web através de `LayoutBuilder` inteligente.

---

## 🚀 Diferenciais do CinePulse

| Funcionalidade | Descrição |
|---|---|
| **⚡ PulseScore** | Avaliação granular que vai além da nota de 1 a 5 estrelas: permite pontuar dimensões como *História*, *Atuação*, *Visual* e *Trilha Sonora*. |
| **🤝 PulseMatch** | Algoritmo de afinidade social que calcula a compatibilidade de gosto entre perfis de amigos e da comunidade ("Vocês combinam 87% em Ficção Científica"). |
| **🎭 MoodTags** | Sistema de descoberta por sensação e clima emocional (ex: *Tenso*, *Confortável*, *Chorei Horrores*, *Fim de Noite*), ideal para quando você não sabe o que assistir. |
| **🛡️ Spoiler Safe** | Sistema nativo com máscaras de spoiler e alertas visuais, garantindo discussões seguras sem arruinar a experiência alheia. |

---

## 🛠️ Tecnologias Utilizadas

- **Framework:** [Flutter](https://flutter.dev/) (SDK `>=3.3.0 <4.0.0`)
- **Linguagem:** [Dart](https://dart.dev/)
- **Design System:** Material Design 3 customizado com Dark Theme imersivo
- **Ícones:** `cupertino_icons` e Material Symbols
- **Gerenciamento de Estado & Telas:** StatefulWidgets modulares com `IndexedStack` e navegação responsiva (`NavigationBar` para mobile e `NavigationRail` para desktop/tablet)
- **Qualidade de Código & Linter:** `flutter_lints` versão 5.0.0
- **Testes:** `flutter_test` (testes de widgets automatizados)
- **Prototipação & Design:** Figma ([Figma Oficial CinePulse](https://www.figma.com/design/SMfkQcK7LwgpSV9Yp8VVkh/Sem-t%C3%ADtulo?node-id=1-3&t=fcr24qhg0RFKlwOL-1))

---

## 💻 Estrutura do Repositório

O projeto segue a abordagem **Feature-First** (organização por funcionalidade), promovendo isolamento, testabilidade e alta manutenibilidade:

```text
cinepulse/
├── assets/
│   └── brand/               # Logos, badges e ícones oficiais em vetor (SVG)
├── docs/                    # Dossiê completo de engenharia, UX e requisitos
│   ├── assets/              # Mockups e wireframes em SVG
│   ├── 01-visao-produto.md  # Visão, benchmark, hipóteses e dados de mercado
│   ├── 02-publico-personas-e-jornada.md # Personas detalhadas e jornada do usuário
│   ├── 03-mvp-e-requisitos.md # 20 User Stories, critérios de aceite e MoSCoW
│   ├── 04-identidade-visual.md # Tokens de cor, tipografia e UI Kit
│   ├── 05-pitch-e-modelo-de-negocio.md # Estratégia de negócios e roteiros de pitch
│   ├── 06-wireframes-e-fluxos.md # Arquitetura de informação e wireframes
│   ├── 07-divisao-da-equipe.md # Papéis, matriz RACI e responsabilidades
│   ├── 08-checklist-checkpoint-4.md # Validação de critérios acadêmicos
│   ├── 09-roadmap-cp5-cp6.md # Planejamento das próximas sprints
│   └── dossie-product-ux.html # Relatório visual interativo
├── lib/
│   ├── core/
│   │   ├── theme/           # Tokens de cores, temas escuros e tipografia
│   │   └── widgets/         # Componentes compartilhados (cards, botões, chips)
│   ├── features/
│   │   ├── home/            # Tela Descobrir, destaques, trilhas e carrosséis
│   │   ├── diary/           # Diário de consumo e registro de assistidos
│   │   ├── lists/           # Watchlist e listas temáticas
│   │   └── profile/         # Perfil de usuário, estatísticas e preferências
│   └── main.dart            # Ponto de entrada do aplicativo
├── test/
│   └── widget_test.dart     # Bateria de testes de widget
├── pubspec.yaml             # Manifesto de dependências e assets
└── README.md                # Documentação principal
```

---

## ⚙️ Instalação e Configuração

### Pré-requisitos

Certifique-se de ter instalado em seu ambiente:
1. **[Git](https://git-scm.com/)**
2. **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (versão 3.3.0 ou superior)
3. **[VS Code](https://code.visualstudio.com/)** ou **[Android Studio](https://developer.android.com/studio)** com os plugins do Flutter e Dart habilitados
4. Emulador configurado (Android/iOS) ou o **Google Chrome** para execução em modo Web

Verifique o status do seu ambiente executando:
```bash
flutter doctor
```

---

## ▶️ Como Rodar a Aplicação

Siga o passo a passo abaixo no seu terminal:

1. **Clone este repositório:**
   ```bash
   git clone https://github.com/matheeusvx/CinePulse.git
   cd CinePulse
   ```

2. **Baixe as dependências do projeto:**
   ```bash
   flutter pub get
   ```

3. **Verifique a integridade e padrões de código (Linter):**
   ```bash
   flutter analyze
   ```

4. **Execute os testes automatizados:**
   ```bash
   flutter test
   ```

5. **Inicie o aplicativo:**
   - No emulador padrão ou dispositivo USB conectado:
     ```bash
     flutter run
     ```
   - No navegador Google Chrome (modo Web Desktop):
     ```bash
     flutter run -d chrome
     ```
   - No Windows nativo (se habilitado):
     ```bash
     flutter run -d windows
     ```

---

## 👥 Equipe e Responsabilidades (CP4)

| Integrante | Papel Principal | Entregas Chave no Checkpoint 4 |
|---|---|---|
| **Matheus Morelli** | *Tech Lead & Integração Flutter* | Estrutura de arquitetura de pastas, integração das branches, revisão de pull requests e build da aplicação. |
| **Cauã Ferreira Muniz** | *Brand & UI Designer* | Criação da identidade visual, logos vetoriais em `assets/brand/`, UI Kit, design system e [Figma Oficial](https://www.figma.com/design/SMfkQcK7LwgpSV9Yp8VVkh/Sem-t%C3%ADtulo?node-id=1-3&t=fcr24qhg0RFKlwOL-1). |
| **Rafael Ferreira** | *Product Manager & UX Researcher* | Validação do problema, 3 personas, mapa de jornada, 20 User Stories priorizadas (RICE/MoSCoW), arquitetura de informação e wireframes. |
| **Victor Nicolas** | *Flutter Developer* | Implementação do protótipo funcional, casca do app (`AppShell`), telas (`Home`, `Diário`, `Listas`, `Perfil`) e responsividade. |
| **Henrique Nicolas** | *Documentação, Pitch & QA* | Documentação técnica e README, roteiro de Pitch, plano de testes de QA e auditoria de evidências de execução. |

---

## 🎨 Identidade Visual e Recursos

- **Paleta de Cores:**
  - Primária: `#8B5CF6` (Violeta Neon — pulso criativo)
  - Secundária: `#22D3EE` (Ciano Elétrico — tecnologia e fluidez)
  - Fundo: `#090D18` (Dark Slate profundo para economia de bateria e imersão cinematográfica)
  - Superfície: `#121829` (Contraste limpo para cards e modais)
- **Figma:** [Acessar Projeto no Figma](https://www.figma.com/design/SMfkQcK7LwgpSV9Yp8VVkh/Sem-t%C3%ADtulo?node-id=1-3&t=fcr24qhg0RFKlwOL-1)
- **Protótipo Rápido:** Arquivo navegável em [`docs/app_interativo.html`](docs/app_interativo.html)

---

## 📄 Licença e Uso Acadêmico

Projeto concebido e desenvolvido para fins acadêmicos na FIAP. Todos os direitos de propriedade intelectual pertencem aos membros da equipe CinePulse.
