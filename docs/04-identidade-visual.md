# 04 — Marca, Identidade Visual e Design System

> **Responsável:** Cauã Ferreira Muniz — Brand & UI Designer  
> **Entrega:** Checkpoint 4 (CP4) — CinePulse  

---

## 1. Naming e Conceito da Marca

**CinePulse** combina “cine” (universo cinematográfico e audiovisual) com “pulse” (o pulso, a vibração e o gosto individual e comunitário). O aplicativo traduz a paixão por filmes e séries de forma expressiva, interativa e sem barreiras.

### Naming Rationale
- **Curto e memorável:** Fácil de pronunciar em português e inglês.
- **Identificação imediata:** Evoca simultaneamente cinema e pulso comunitário.
- **Ecossistema de features:** Permite nomear de maneira fluida e coesa os diferenciais do app:
  - **PulseScore™:** Avaliação multicritério (História, Atuação, Visual, Trilha Sonora).
  - **PulseMatch™:** Afinidade de gosto entre amigos e perfis da comunidade.
  - **MoodTags™:** Descoberta por sensação (Leve, Tenso, Épico, Reflexivo).
  - **Spoiler Safe™:** Proteção contra spoilers indesejados.
- **Diferenciação:** Foge dos clichês de “letter”, “box”, “film” ou paletas verdes/laranjas genéricas de concorrentes.

---

## 2. Tagline e Tom de Voz

### Tagline Oficial
> **Assista. Avalie. Conecte.**

### Personalidade da Marca
- **Moderna e Cinemática:** Interface escura (*dark-first*), com destaques em violeta elétrico e ciano neon.
- **Social e Acolhedora:** Incentiva a troca genuína de opiniões, sem esnobismo ou elitismo crítico.
- **Confiável e Cuidadosa:** Respeita a experiência do usuário com o modo *Spoiler Safe*.

### Tom de Voz
| O que fazer | O que evitar |
|---|---|
| *"O que vale a sua próxima sessão?"* | Jargões acadêmicos herméticos ou inacessíveis |
| *"Seu gosto, além das 5 estrelas."* | Tom professoral que desmereça gostos populares |
| *"Vocês têm 88% de PulseMatch em Ficção Científica!"* | Notificações invasivas com spoilers explícitos |

---

## 3. Paleta de Cores e Tokens do Design System

A paleta foi construída sobre o princípio *Dark-First*, priorizando contraste cinematográfico, conforto visual e destaque para os pôsteres e mídias.

| Token | Hex | Cor / Amostra | Papel Semântico no App | Flutter `AppColors` |
|---|---|---|---|---|
| **Primary** | `#8B5CF6` | 🟣 Violeta | Botões principais, estados ativos, destaques de marca | `AppColors.primary` |
| **Secondary** | `#22D3EE` | 🔵 Ciano Neon | PulseScore, indicadores de PulseMatch, MoodTags ativas | `AppColors.secondary` |
| **Background** | `#090D18` | ⬛ Deep Midnight | Fundo principal da aplicação e páginas | `AppColors.background` |
| **Surface** | `#121829` | ⬛ Dark Navy | Cards de conteúdo, campos de busca, barras de navegação | `AppColors.surface` |
| **Surface Strong** | `#1A2238` | ⬛ Elevated Navy | Bordas elevadas, chips inativos, separadores | `AppColors.surfaceStrong` |
| **Text Primary** | `#F8FAFC` | ⬜ Branco Gelo | Títulos H1-H4, textos de alto contraste | `AppColors.textPrimary` |
| **Text Secondary** | `#94A3B8` | 🔘 Slate Gray | Metadados, subtítulos, sinopses e legendas | `AppColors.textSecondary` |
| **Success** | `#34D399` | 🟢 Verde Menta | Confirmações, status "Assistido", salvamentos | `AppColors.success` |
| **Warning** | `#FBBF24` | 🟡 Dourado Âmbar | Estrelas de avaliação e avisos sutis | `AppColors.warning` |

---

## 4. Tipografia

- **Títulos e Destaques (Headings):** `Space Grotesk` (Pesos: 700 Bold / 600 Semi-Bold).
  - Traz personalidade moderna, tecnológica e geométrica para a marca CinePulse.
- **Corpo e Interface (Body & UI):** `Inter` (Pesos: 400 Regular / 500 Medium / 600 Semi-Bold).
  - Máxima legibilidade em telas móveis e densidade de informação limpa.
- **Fallback Nativo no Flutter:** Fontes padrão do sistema (`sans-serif`), garantindo build sem dependências externas pesadas no CP4.

---

## 5. Assets Oficiais da Marca (`assets/brand/`)

Todos os assets vetoriais foram desenhados e padronizados em formato SVG escalável:

1. **`assets/brand/app_icon.svg`**  
   - Ícone mobile squircle (512x512) com gradiente violeta profundo, símbolo de play e pulso eletrocardiograma ciano com efeito de brilho (*neon glow*).
2. **`assets/brand/logo_symbol.svg`**  
   - Símbolo condensado do CinePulse para ícones, botões de ação e favicons.
3. **`assets/brand/logo_horizontal.svg`**  
   - Logotipo horizontal completo com símbolo, wordmark em Space Grotesk e tagline.
4. **`assets/brand/logo_monochrome.svg`**  
   - Variação em alto contraste branco/preto para impressões, carimbos ou fundos especiais.
5. **`assets/brand/logo_badge.svg`**  
   - Selo circular comemorativo e emblemático para comunidade, redes sociais e merchandising.

---

## 6. Especificação dos Componentes de UI (UI Kit)

### 6.1. Botões
- **Primary CTA:** Altura 48px–52px, raio de 16px. Fundo com gradiente linear `#8B5CF6` ➔ `#22D3EE` (ou violeta sólido `#8B5CF6`), texto branco em Space Grotesk 14px bold.
- **Secondary / Action Button:** Altura 40px, raio de 14px. Fundo `#121829`, borda `#1A2238` 1px, texto `#F8FAFC`.
- **Status Ativo (ex: "✓ Assistido"):** Fundo `#1A2238`, borda `#22D3EE` 1.2px, texto `#22D3EE`.

### 6.2. Componente PulseScore™
- **Estrutura:** Quebra a avaliação em quatro dimensões fundamentais:
  1. *História & Roteiro*
  2. *Atuação & Elenco*
  3. *Direção Visual & Fotografia*
  4. *Trilha Sonora & Ambientação*
- **Visual:** Barras de progresso com gradiente violeta-ciano (`#8B5CF6` ➔ `#22D3EE`), altura 6px, fundo `#1A2238` e pontuação numérica acompanhada de estrela.

### 6.3. Chips de MoodTags™
- **Chip Inativo:** Fundo `#121829`, borda `#1A2238` 1px, texto `#94A3B8`.
- **Chip Selecionado:** Fundo `#1A2238`, borda ciano `#22D3EE` (ou violeta `#8B5CF6`), texto com cor de destaque correspondente e emoji indicativo (`⚡ Tenso`, `☕ Leve`, `💡 Reflexivo`, `🔥 Épico`).

### 6.4. Card Spoiler Safe™
- **Proteção do Usuário:** Reviews sinalizadas com spoilers são protegidas por padrão.
- **Card:** Borda `#8B5CF6`, fundo tonal `#16152B`, badge com ícone de escudo `🛡️ SPOILER SAFE` e texto de aviso: *"Review oculta. Toque para revelar o conteúdo..."*.

### 6.5. Badge PulseMatch™
- **Indicador Circular:** Medidor de anel com gradiente circular ciano/violeta e porcentagem no centro (ex: `88% MATCH`).
- **Resumo Social:** Exibe a compatibilidade em gêneros e títulos em comum entre dois perfis.

---

## 7. Telas e Mockups de Alta Fidelidade (CP4)

Os mockups completos em escala mobile (390 x 844 px — padrão iOS/Android moderno) foram desenvolvidos em arquivos vetoriais SVG na pasta `docs/assets/` e podem ser visualizados ou importados diretamente no Figma:

### Tela 1: Splash Screen
- **Arquivo:** `docs/assets/mockup_01_splash.svg`
- **Elementos:** Logotipo centralizado com brilho ambiente neon, tipografia CinePulse, tagline e indicador de carregamento de pulso.

### Tela 2: Home / Descobrir
- **Arquivo:** `docs/assets/mockup_02_home.svg`
- **Elementos:** Barra superior com logotipo e notificações, campo de busca com cantos arredondados, banner promocional do PulseMatch, carrossel de MoodTags interativas, pôsteres em alta com notas e barra de navegação inferior.

### Tela 3: Detalhe do Título (com PulseScore™)
- **Arquivo:** `docs/assets/mockup_03_detalhe.svg`
- **Elementos:** Backdrop cinematográfico com fade escuro, pôster sobreposto, botões de ação rápida (+ Watchlist, ✓ Assistido, ★ Avaliar), sinopse e o card diferencial **PulseScore™ da Comunidade** com barras multicritério.

### Tela 4: Avaliação & Review (com Spoiler Safe™)
- **Arquivo:** `docs/assets/mockup_04_review.svg`
- **Elementos:** Modal de avaliação com 5 estrelas interativas, seletor de MoodTags, caixa de texto de review com contador de caracteres, switch ativo do **Spoiler Safe™** e botão de publicação no diário.

### Tela 5: Perfil & PulseMatch™
- **Arquivo:** `docs/assets/mockup_05_perfil.svg`
- **Elementos:** Avatar com anel gradiente, métricas de títulos assistidos/reviews/listas, medidor de afinidade social **PulseMatch (88%)**, abas de navegação e feed do diário demonstrando cards comuns e cards protegidos por Spoiler Safe.

---

## 8. Guia para Apresentação e Figma

As telas conceituais foram importadas e organizadas no Figma para a apresentação do grupo:

🔗 **Link Oficial do Projeto no Figma:**  
👉 [**CinePulse — Figma UI Design (Cauã Ferreira Muniz)**](https://www.figma.com/design/SMfkQcK7LwgpSV9Yp8VVkh/Sem-t%C3%ADtulo?node-id=1-3&t=fcr24qhg0RFKlwOL-1)

### Como importar novamente ou atualizar no Figma:
1. Abra o arquivo no [Figma](https://www.figma.com/design/SMfkQcK7LwgpSV9Yp8VVkh/Sem-t%C3%ADtulo?node-id=1-3&t=fcr24qhg0RFKlwOL-1).
2. Arraste os arquivos SVG de `docs/assets/mockup_01_splash.svg` até `mockup_05_perfil.svg` diretamente para o canvas do Figma.
3. O Figma importará todas as telas como **Frames de 390x844 px** com todas as camadas, vetores, textos e cores 100% editáveis!

---

## 9. Registro de Evidências de Cauã Ferreira Muniz

- **Branch de trabalho:** `design/brand-caua`
- **Arquivos criados/refinados:**
  - `assets/brand/app_icon.svg`
  - `assets/brand/logo_symbol.svg`
  - `assets/brand/logo_horizontal.svg`
  - `assets/brand/logo_monochrome.svg`
  - `assets/brand/logo_badge.svg`
  - `docs/assets/mockup_01_splash.svg`
  - `docs/assets/mockup_02_home.svg`
  - `docs/assets/mockup_03_detalhe.svg`
  - `docs/assets/mockup_04_review.svg`
  - `docs/assets/mockup_05_perfil.svg`
  - `docs/04-identidade-visual.md`
