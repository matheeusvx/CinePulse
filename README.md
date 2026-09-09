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

Arquivos de logo e ícones em `assets/brand/`, mockups visuais em `docs/assets/` e [Figma Oficial do CinePulse](https://www.figma.com/design/SMfkQcK7LwgpSV9Yp8VVkh/Sem-t%C3%ADtulo?node-id=1-3&t=fcr24qhg0RFKlwOL-1).

## Integrantes e papéis no CP4

| Integrante | Papel principal | Entregas sugeridas / Realizadas |
|---|---|---|
| **Matheus Morelli** | Tech Lead / Integração Flutter | Criar/organizar repositório, consolidar branches, revisar estrutura Flutter, rodar build final e garantir README atualizado. |
| **Cauã Ferreira Muniz** | Brand & UI Designer | Identidade visual completa, variações de logo/ícone de app (`assets/brand/`), especificação de UI Kit, mockups das 5 telas e [Figma Oficial](https://www.figma.com/design/SMfkQcK7LwgpSV9Yp8VVkh/Sem-t%C3%ADtulo?node-id=1-3&t=fcr24qhg0RFKlwOL-1) (detalhes em `docs/04-identidade-visual.md`). |
| **Rafael Ferreira** | Product / UX | Validação do problema com dados de mercado, hipóteses e benchmark (`docs/01`), segmentação, 3 personas, antipersona e mapa de jornada (`docs/02`), 20 user stories com critérios de aceite + priorização RICE/MoSCoW (`docs/03`), arquitetura de informação, fluxos e 12 wireframes lo-fi em SVG (`docs/06` + `docs/assets/wireframes/`), plano de pesquisa e validação (`docs/10`) e o [dossiê navegável de Product/UX](docs/dossie-product-ux.html). |
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

A pasta `docs/` reúne a documentação completa do Checkpoint 4 e o planejamento de evolução para CP5/CP6.

| Documento | Conteúdo |
|---|---|
| [01 — Visão do produto](docs/01-visao-produto.md) | Problema com dados de mercado, hipóteses, proposta de valor, benchmark, posicionamento, métricas e riscos |
| [02 — Público, personas e jornada](docs/02-publico-personas-e-jornada.md) | Segmentação comportamental, 3 personas, antipersona, mapa de jornada e princípios de UX |
| [03 — MVP e requisitos](docs/03-mvp-e-requisitos.md) | 20 user stories com critérios de aceite, priorização RICE e MoSCoW, requisitos não funcionais e DoD |
| [04 — Identidade visual](docs/04-identidade-visual.md) | Marca, paleta, tipografia, UI kit e mockups de alta fidelidade |
| [05 — Pitch e modelo de negócio](docs/05-pitch-e-modelo-de-negocio.md) | Pitch de 30 s e 1 min, modelo de negócio e diferenciais competitivos |
| [06 — Wireframes e fluxos](docs/06-wireframes-e-fluxos.md) | Arquitetura da informação, fluxo principal e 12 wireframes lo-fi em SVG |
| [07 — Divisão da equipe](docs/07-divisao-da-equipe.md) | Papéis, responsabilidades e evidências por integrante |
| [08 — Checklist do CP4](docs/08-checklist-checkpoint-4.md) | Conferência item a item contra a rubrica |
| [09 — Roadmap CP5/CP6](docs/09-roadmap-cp5-cp6.md) | Evolução planejada até o produto instalável |
| [10 — Pesquisa e validação](docs/10-pesquisa-e-validacao.md) | Questionário, roteiro de entrevista e plano de teste de usabilidade |

**Materiais para apresentação**

- [Dossiê navegável de Product/UX](docs/dossie-product-ux.html) — página única com problema, personas, jornada, priorização e wireframes.
- [Protótipo interativo mobile](docs/app_interativo.html) — simulador clicável do app.
- [Wireframes lo-fi](docs/assets/wireframes/) — 12 arquivos SVG anotados, prontos para importar no Figma.
