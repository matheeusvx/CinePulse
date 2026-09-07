# CinePulse

> **Assista. Avalie. Conecte.**

CinePulse é um aplicativo mobile em Flutter para pessoas que querem registrar, avaliar e descobrir **filmes e séries** de forma social, organizada e mais expressiva do que uma nota isolada.

Este repositório contém a entrega-base do **Checkpoint 4 — Idealização do App**, preparada para evoluir nos Checkpoints 5 e 6.

## Proposta de valor

Plataformas de entretenimento ajudam a encontrar títulos, mas a experiência de avaliação costuma ser rasa ou pouco personalizada. O CinePulse combina diário de consumo, reviews, listas e descoberta com quatro diferenciais planejados:

- **PulseScore:** avaliação por critérios como história, atuação, visual e trilha.
- **PulseMatch:** percentual de afinidade de gosto entre usuários.
- **MoodTags:** descoberta por sensação/clima, como leve, tenso, emocionante ou confortável.
- **Spoiler Safe:** reviews com spoilers ocultos por padrão e sinalização clara.

## Público-alvo

Jovens e adultos de aproximadamente 16 a 35 anos que consomem filmes e séries com frequência, usam streaming, conversam sobre entretenimento em redes sociais e gostam de registrar ou compartilhar opiniões e recomendações.

## MVP planejado

1. Cadastro/login de usuário.
2. Busca de filmes e séries.
3. Página de detalhes do título.
4. Avaliação geral e por critérios.
5. Review com marcação de spoiler.
6. Diário de títulos assistidos.
7. Watchlist/listas personalizadas.
8. Perfil com histórico e estatísticas básicas.
9. PulseMatch entre usuários como diferencial social.

> No CP4, o foco é a **fundação do produto**: marca, documentação e primeiro projeto Flutter funcional. Integrações reais com catálogo, autenticação e persistência ficam para os próximos checkpoints.

## Identidade da marca

- **Nome:** CinePulse
- **Tagline:** Assista. Avalie. Conecte.
- **Conceito:** o “pulso” do gosto de cada pessoa e da comunidade.
- **Tom de voz:** direto, curioso, leve, inclusivo e sem elitismo cinematográfico.
- **Cor primária:** `#8B5CF6` — violeta.
- **Cor secundária:** `#22D3EE` — ciano.
- **Fundo:** `#090D18`.
- **Superfície:** `#121829`.
- **Texto principal:** `#F8FAFC`.
- **Texto secundário:** `#94A3B8`.
- **Tipografia recomendada:** Space Grotesk (títulos) + Inter (corpo).

Arquivos de logo em `assets/brand/`.

## Integrantes e papéis no CP4

| Integrante | Papel principal | Entregas sugeridas |
|---|---|---|
| **Matheus Morelli** | Tech Lead / Integração Flutter | Criar/organizar repositório, consolidar branches, revisar estrutura Flutter, rodar build final e garantir README atualizado. |
| **Cauã Ferreira Muniz** | Brand & UI Designer | Refinar logo, paleta, tipografia, componentes e montar identidade visual/tela no Figma seguindo `docs/04-identidade-visual.md`. |
| **Rafael Ferreira** | Product / UX | Validar problema, público-alvo, personas, jornada, user stories, priorização do MVP e wireframes. |
| **Victor Nicolas** | Flutter Developer | Implementar/refinar a home e navegação do protótipo Flutter, responsividade e componentes visuais. |
| **Henrique Nicolas** | Documentação, Pitch & QA | Organizar documentação GitHub, preparar pitch, revisar critérios do professor, testar execução e registrar evidências. |

**Regra de equipe:** todo integrante deve ter pelo menos um commit identificável no GitHub, mesmo quando sua entrega principal for documentação/design.

## Estrutura do projeto

```text
cinepulse/
├─ assets/
│  └─ brand/
├─ docs/
├─ lib/
│  ├─ core/
│  │  ├─ theme/
│  │  └─ widgets/
│  └─ features/
│     ├─ home/
│     ├─ diary/
│     ├─ lists/
│     └─ profile/
├─ test/
├─ analysis_options.yaml
├─ pubspec.yaml
└─ README.md
```

## Como rodar

Este pacote contém o código-fonte e os arquivos de configuração do CP4. Como o ambiente em que ele foi preparado não possui o SDK do Flutter instalado, o build final precisa ser validado em uma máquina com Flutter.

### Se vocês já têm um projeto Flutter criado

Copiem/substituam estas pastas e arquivos no projeto:

- `lib/`
- `assets/`
- `test/`
- `pubspec.yaml`
- `analysis_options.yaml`
- `docs/`
- `README.md`

Depois executem:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

### Se ainda não têm o projeto Flutter

```bash
flutter create cinepulse
cd cinepulse
```

Depois substituam os arquivos gerados pelos arquivos deste pacote e executem os quatro comandos acima.

## Git e colaboração

Sugestão de branches:

- `main` — versão estável/entrega.
- `develop` — integração do checkpoint.
- `feat/flutter-home-victor`
- `docs/product-rafael`
- `design/brand-caua`
- `docs/pitch-henrique`
- `chore/integration-matheus`

Padrão de commits:

```text
feat: cria estrutura inicial da home
feat: adiciona navegacao principal
docs: documenta proposta de valor e publico alvo
design: adiciona identidade visual do CinePulse
docs: adiciona pitch e modelo de negocio
chore: prepara entrega do checkpoint 4
```

## Checkpoint 4 — conferência rápida

- [x] Nome e conceito de marca definidos.
- [x] Proposta de valor definida.
- [x] Problema e público-alvo documentados.
- [x] MVP e diferenciais documentados.
- [x] Identidade visual e logo-base definidos.
- [x] Pitch e modelo de negócio documentados.
- [x] Estrutura Flutter inicial preparada.
- [x] Tela inicial/navegação de demonstração implementadas.
- [x] Papéis de todos os integrantes documentados.
- [ ] Tema aprovado pelo professor.
- [ ] Repositório GitHub do grupo criado e link inserido neste README.
- [ ] `flutter analyze`, `flutter test` e `flutter run` validados localmente.
- [ ] Screenshot/vídeo curto do app rodando anexado à documentação, se desejado.

## Documentação complementar

Veja a pasta `docs/` para a documentação completa do Checkpoint 4 e o planejamento de evolução para CP5/CP6.
