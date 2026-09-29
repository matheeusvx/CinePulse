# Propósito do CinePulse

**[README](README.md) | [Propósito](PROPOSITO.md) | [Contribuindo](CONTRIBUTING.md)**

## Problema e propósito

Escolher o próximo filme ou série, lembrar o que se quer assistir e registrar a própria experiência costuma envolver serviços e anotações separados. Notas agregadas também não explicam quais aspectos de uma obra importaram para cada pessoa; reviews abertas podem expor spoilers antes da decisão de assistir.

O CinePulse procura reunir **descoberta, organização e memória pessoal de consumo audiovisual** em um fluxo curto. No CP6, a proposta é individual e verificável: dados de catálogo vêm do TMDB e os registros pessoais ficam vinculados à conta no Firebase. A ambição social descrita em documentos antigos permanece como hipótese futura.

## Proposta de valor e público

O produto atende quem assiste filmes e séries com frequência e quer guardar títulos, avaliar com alguma nuance e revisitar o próprio histórico. O fluxo principal é: **descobrir → colocar na Watchlist → assistir e avaliar → consultar Diário e Perfil**.

A proposta diferencia o registro pessoal em três pontos: avaliação rápida com aprofundamento opcional, descoberta por clima de forma explicável e proteção de spoilers nas reviews. O aplicativo não promete recomendar por IA nem medir afinidade com outros usuários nesta versão.

## Diferenciais: conceito e implementação

### PulseScore

Uma nota geral continua obrigatória para registrar um título assistido. Quem quiser pode detalhar **história, atuação, visual e trilha sonora**, cada critério entre 0,5 e 5. Critérios ausentes permanecem sem valor; a média pessoal considera apenas os preenchidos. O cartão visual converte essa média para a escala 0–10 multiplicando por 2. Sem critérios preenchidos, o app mostra um estado sem dados, nunca uma nota zero ou média comunitária fictícia.

### MoodTags

Na avaliação, a pessoa pode selecionar até três tags opcionais. Na Home, chips de humor filtram títulos reais por um mapeamento fixo para gêneros TMDB, documentado em [SETUP.md](SETUP.md). Esse mecanismo é determinístico: aproxima um clima por gênero e **não** analisa emoções, comportamento social ou dados de IA.

### Spoiler Safe

Uma review pessoal pode ser marcada como contendo spoiler. Quando exibida no detalhe, na Home ou no Perfil, o texto inicia oculto e é revelado por ação explícita naquele card. Não há feed público de reviews no CP6.

### PulseMatch

A ideia original é explicar afinidade entre pessoas com base em títulos avaliados em comum. Existe um **núcleo puro e testado** conforme [a especificação do MVP](docs/03-mvp-e-requisitos.md): menos de cinco títulos em comum significa dados insuficientes; com dados suficientes, calcula-se sobreposição, divergência média de notas e concordância. O resultado combina **35% de sobreposição e 65% de concordância**. Ainda não há perfis de terceiros, comparação entre contas nem percentual PulseMatch na interface.

## Decisões de produto e tecnologia

- **Profundidade opcional:** PulseScore, MoodTags e review não bloqueiam o registro rápido de uma nota geral.
- **Números honestos:** Home e Perfil mostram métricas do próprio usuário quando existem; falta de dados vira estado vazio, não demonstração com valores fictícios.
- **Dados por conta:** Watchlist e avaliações estão em subcoleções do usuário no Firestore, com regras de isolamento por `uid`.
- **Catálogo externo:** TMDB fornece títulos e imagens. O app mantém separados os repositórios de catálogo e dados pessoais.
- **Marca consistente:** tema escuro, violeta e ciano acompanham a identidade oficial sem substituir a navegação e as telas consolidadas desde o CP4.

## Limitações atuais

- PulseMatch não compara usuários na interface; seguidores, feed social e perfis públicos não foram implementados.
- MoodTags na descoberta são filtros de gênero, não recomendação personalizada ou IA/ML.
- Reviews são pessoais, não publicações sociais.
- Não há listas personalizadas. A Watchlist é a lista persistente disponível.
- O token TMDB passado ao Flutter por `--dart-define-from-file` integra o binário; uma distribuição pública exige uma arquitetura de proteção apropriada.
- O APK release atual usa assinatura de debug e é destinado a demonstração acadêmica/testes.

## Roadmap proposto

1. **Qualidade de integração:** validar a jornada completa em dispositivos e contas reais, incluindo estados de rede e acessibilidade.
2. **Distribuição:** proteger o acesso ao TMDB fora do binário e configurar assinatura própria para publicação.
3. **Hipóteses futuras de produto:** pesquisar a utilidade de listas personalizadas e comparação consentida entre usuários antes de projetar feed, seguidores ou qualquer recomendação social.

Esses itens são **planos**, não funcionalidades disponíveis no CP6. O [README](README.md) descreve o produto executável e sua configuração.
