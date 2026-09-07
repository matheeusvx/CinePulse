# 04 — Marca e Identidade Visual

## Naming

**CinePulse** combina “cine” com “pulse”. O nome comunica entretenimento audiovisual e, ao mesmo tempo, o “pulso” individual e coletivo das opiniões da comunidade.

## Naming rationale

- Curto e fácil de pronunciar.
- Relaciona-se diretamente ao universo de filmes e séries.
- “Pulse” sugere atividade, tendência, gosto e afinidade.
- Permite nomear funcionalidades de forma consistente: PulseScore e PulseMatch.
- Evita copiar nome, paleta ou símbolos centrais de concorrentes.

> Antes de uso comercial real, recomenda-se realizar pesquisa jurídica de marca e domínio. Para o projeto acadêmico, o nome funciona como identidade conceitual.

## Tagline

**Assista. Avalie. Conecte.**

## Personalidade da marca

- Curiosa.
- Social.
- Moderna.
- Inclusiva.
- Confiável.
- Sem elitismo.

## Tom de voz

### Fazer

- “O que vale a próxima sessão?”
- “Seu gosto, além das estrelas.”
- “Vocês têm 84% de PulseMatch.”

### Evitar

- Linguagem excessivamente técnica.
- Tom de “crítico profissional” que invalide opiniões casuais.
- Spoilers em notificações e cards.

## Paleta

| Token | Cor | Uso |
|---|---|---|
| Primary | `#8B5CF6` | CTAs, destaques, marca |
| Secondary | `#22D3EE` | Ícones, detalhes, Pulse |
| Background | `#090D18` | Fundo principal |
| Surface | `#121829` | Cards, campos, navegação |
| Surface Strong | `#1A2238` | Estados ativos e contraste |
| Text Primary | `#F8FAFC` | Texto principal |
| Text Secondary | `#94A3B8` | Metadados e apoio |
| Success | `#34D399` | Confirmações |
| Warning | `#FBBF24` | Estrelas/alertas leves |

## Tipografia

- **Títulos:** Space Grotesk, pesos 600–700.
- **Texto:** Inter, pesos 400–600.
- **Fallback no Flutter inicial:** fonte padrão do sistema, evitando dependência externa no CP4.

## Conceito do logo

O símbolo combina:

1. botão de “play”, representando audiovisual;
2. linha de pulso, representando gosto, atividade e afinidade;
3. bloco violeta arredondado, criando ícone simples para app.

Arquivos-base:

- `assets/brand/logo_symbol.svg`
- `assets/brand/logo_horizontal.svg`

## Diretrizes de UI

- Interface dark-first.
- Bordas arredondadas entre 14 e 22 px.
- Cards com pouco ruído visual.
- Violeta como ação; ciano como informação/diferencial.
- Posters e capas devem ser protagonistas quando catálogo real for integrado.
- Evitar replicar combinação visual característica de outros apps de review.

## Figma — telas mínimas para apresentação do CP4

1. Splash/logo.
2. Home/Descobrir.
3. Detalhe de filme/série.
4. Avaliação PulseScore.
5. Perfil com PulseMatch.

Mesmo que o Flutter do CP4 implemente apenas a base navegável, essas cinco telas deixam o conceito de produto apresentável.
