# 06 — Wireframes e Fluxos

## Fluxo principal — avaliar conteúdo

```text
HOME
  ↓
BUSCA
  ↓
DETALHE DO TÍTULO
  ├─ Adicionar à watchlist
  └─ Marcar como assistido
          ↓
       AVALIAR
          ├─ Nota geral
          ├─ PulseScore opcional
          ├─ MoodTags
          └─ Review + spoiler?
                  ↓
               PUBLICAR
                  ↓
          DIÁRIO / PERFIL
```

## Wireframe — Home

```text
┌─────────────────────────────────┐
│ [logo] CinePulse          [sino]│
│ ┌─────────────────────────────┐ │
│ │ Buscar filmes ou séries...  │ │
│ └─────────────────────────────┘ │
│                                 │
│ [Banner] Seu gosto, além...     │
│                                 │
│ Em alta na comunidade           │
│ [poster] [poster] [poster]      │
│                                 │
│ Para o seu humor                │
│ [Leve] [Tenso] [Reflexivo]      │
│                                 │
│ Descobrir Diário Listas Perfil  │
└─────────────────────────────────┘
```

## Wireframe — Detalhe

```text
┌─────────────────────────────────┐
│ ←         capa/banner           │
│          TÍTULO                 │
│ Ano • gênero • duração          │
│ ★ 4,3 da comunidade             │
│                                 │
│ [Assistido] [Watchlist]         │
│                                 │
│ Sinopse                         │
│ ...                             │
│                                 │
│ Seu PulseScore                  │
│ História    ★★★★☆               │
│ Atuação     ★★★★★               │
│ Visual      ★★★★☆               │
│ Trilha      ★★★★☆               │
└─────────────────────────────────┘
```

## Wireframe — Review com spoiler

```text
┌─────────────────────────────────┐
│ Escrever review                 │
│ Nota geral [★★★★☆]              │
│ MoodTags [Tenso] [Reflexivo]    │
│                                 │
│ Review...                       │
│ ┌─────────────────────────────┐ │
│ │                             │ │
│ └─────────────────────────────┘ │
│ [x] Contém spoiler              │
│                                 │
│          [PUBLICAR]             │
└─────────────────────────────────┘
```

## Fluxo secundário — PulseMatch

```text
PERFIL DE OUTRO USUÁRIO
        ↓
TÍTULOS EM COMUM
        ↓
COMPARAÇÃO DE NOTAS/PREFERÊNCIAS
        ↓
PULSEMATCH: 84%
        ↓
“Vocês combinam principalmente em suspense e ficção científica.”
```
