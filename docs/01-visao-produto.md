# 01 — Visão do Produto

> **Responsável:** Rafael Ferreira (Product / UX) · **Checkpoint 4** · Atualizado em 09/09/2026
> Documentos irmãos: [02 — Público, personas e jornada](02-publico-personas-e-jornada.md) · [03 — MVP e requisitos](03-mvp-e-requisitos.md) · [06 — Wireframes e fluxos](06-wireframes-e-fluxos.md) · [10 — Pesquisa e validação](10-pesquisa-e-validacao.md)

---

## 1. Identidade do produto

| Campo | Definição |
|---|---|
| **Nome** | CinePulse |
| **Tagline** | Assista. Avalie. Conecte. |
| **Categoria** | Aplicativo mobile de registro e descoberta social de filmes e séries |
| **Plataforma do MVP** | Android/iOS via Flutter (protótipo web em HTML para validação de conceito) |
| **Frase-síntese** | Um diário social de filmes e séries que transforma avaliações em um mapa de gosto pessoal e usa esse mapa para gerar descobertas mais relevantes. |

---

## 2. O problema

### 2.1 Contexto de mercado

O problema que o CinePulse ataca não é falta de conteúdo — é excesso de conteúdo sem um filtro pessoal confiável.

| Sinal | Dado | Fonte |
|---|---|---|
| Catálogo disponível | Passou de **1,9 milhão** de títulos (jul/2021) para **2,7 milhões** (jun/2023) | Nielsen, *State of Play* 2023 |
| Tempo gasto decidindo | **10,5 minutos por sessão** em 2023, contra ~7,4 minutos em 2019 — e ~12 minutos nos EUA em 2025 | Nielsen / Gracenote |
| Desistência | **1 em cada 5 espectadores** abandona a sessão quando não encontra algo que valha a pena | Nielsen, *State of Play* 2023 |
| Penetração no Brasil | Streaming pago em **44,4% dos lares com internet** (~33,4 milhões de domicílios) em 2025 | IBGE / Poder360 |
| Apetite por registro social | Letterboxd chegou a **17 milhões de membros** em jan/2025 (~20 milhões em meados do ano), crescendo com um produto essencialmente de diário e avaliação de **filmes** | Deadline |

**Leitura do time:** existe demanda comprovada por registrar e discutir cinema (o crescimento do Letterboxd prova isso), e existe uma dor de descoberta que o mercado ainda resolve mal (o tempo de decisão só sobe). Nenhum dos dois lados está bem atendido para quem consome **filmes e séries juntos** e em português.

### 2.2 As quatro dores

1. **Memória fragmentada.** O histórico de quem assiste muito fica espalhado entre serviços de streaming, prints, o app de notas e conversas de WhatsApp. A pessoa não consegue responder "o que eu assisti em maio?".
2. **Nota única é pobre.** Um "4 estrelas" não separa "roteiro fraco, mas atuação impecável" de "tudo mediano". Duas experiências opostas viram o mesmo número.
3. **Descoberta impessoal.** Rankings e notas médias respondem "esse título é bom?", mas não "esse título combina comigo, hoje, nesse humor?".
4. **Spoiler acidental.** Ler qualquer discussão sobre um título recente é apostar. O custo de um spoiler é alto e irreversível, e o comportamento padrão da maioria das plataformas é expor primeiro e avisar depois.

### 2.3 Declaração de problema

> Pessoas de 16 a 35 anos que assistem filmes e séries semanalmente **perdem tempo decidindo o que assistir e perdem o registro do que já assistiram**, porque as ferramentas disponíveis oferecem catálogo e nota média, mas não um retrato do gosto individual nem um caminho seguro para conversar sobre o que viram.
> Sabemos que resolvemos isso quando a pessoa **registra sem esforço** e volta ao app **para decidir o que assistir**, não apenas para arquivar.

---

## 3. Hipóteses (e o que ainda não sabemos)

Este documento é honesto quanto ao seu estágio: as afirmações abaixo são **hipóteses derivadas de pesquisa desk**, não de pesquisa primária com usuários. O plano para testá-las está em [10 — Pesquisa e validação](10-pesquisa-e-validacao.md).

| # | Hipótese | Confiança hoje | Como falsear |
|---|---|---|---|
| **H1** | O público-alvo considera "não saber o que assistir" um problema recorrente e irritante | Alta (dado Nielsen) | Menos de 50% dos respondentes citarem a dor espontaneamente |
| **H2** | O público-alvo quer registrar o que assiste, mas desiste por causa do esforço | Média | Mais de 60% dizerem que já usam uma solução e estão satisfeitos com ela |
| **H3** | Avaliar por critérios (PulseScore) é percebido como valor, e não como formulário | **Baixa** | Menos de 20% dos usuários de teste abrirem a seção opcional |
| **H4** | Afinidade explícita entre perfis (PulseMatch) aumenta a confiança em recomendações | Média | Usuários preferirem a nota média da comunidade ao percentual de afinidade em teste A/B |
| **H5** | Filtrar por humor (MoodTags) é um caminho de descoberta melhor do que filtrar por gênero | Média | Taxa de uso do filtro por humor ficar abaixo da de gênero no protótipo |
| **H6** | Spoilers ocultos por padrão aumentam o engajamento com reviews, em vez de reduzi-lo | Média | Taxa de abertura de reviews marcadas cair abaixo de 30% |

> **H3 é a hipótese mais frágil do produto.** É por isso que, no MVP, o PulseScore por critérios é opcional e fica recolhido atrás de um toque — ver [03 — MVP e requisitos](03-mvp-e-requisitos.md) e o wireframe WF-05.

---

## 4. Solução e proposta de valor

### 4.1 O loop de valor

O CinePulse não é um catálogo com nota. É um ciclo fechado:

```text
   assistir  ──▶  registrar em segundos  ──▶  o mapa de gosto fica mais preciso
       ▲                                                    │
       └────────  descoberta mais relevante  ◀───────────────┘
```

Cada avaliação registrada tem retorno imediato (o diário cresce) e retorno composto (a próxima recomendação melhora). É esse retorno composto que separa o CinePulse de um app de listas.

### 4.2 Canvas de proposta de valor

| Dor do usuário | Como o CinePulse alivia |
|---|---|
| "Não lembro o que assisti" | Diário em linha do tempo, com registro de dois toques |
| "Nota única não expressa o que senti" | PulseScore por critérios (opcional) + MoodTags |
| "Não sei em quem confiar para recomendar" | PulseMatch: percentual de afinidade explicado e auditável |
| "Levo spoiler sem querer" | Spoiler Safe: conteúdo marcado nasce oculto |
| "Não sei o que assistir hoje" | Descoberta por humor, não só por gênero ou popularidade |

| Ganho desejado | Como o CinePulse cria |
|---|---|
| Ver o próprio gosto tomando forma | Perfil com mapa de gêneros e estatísticas |
| Ser referência entre os amigos | Perfil público, listas e reviews |
| Decidir rápido em uma noite qualquer | Filtro por MoodTag + selo de afinidade no detalhe do título |

### 4.3 Benefício central

> O CinePulse não quer apenas responder **"que nota esse título recebeu?"**, e sim **"por que ele combina comigo?"**.

---

## 5. Jobs to be Done

Escritos no formato *quando… quero… para…*, com a funcionalidade que atende cada um.

| # | Job | Atendido por |
|---|---|---|
| JTBD-1 | Quando termino um filme ou episódio, quero registrar minha experiência em segundos, para não perder o histórico nem quebrar o clima do momento | Avaliação rápida (WF-05) |
| JTBD-2 | Quando não sei o que assistir, quero uma sugestão coerente com meu gosto **e com meu humor de hoje**, para não gastar 15 minutos rolando catálogos | MoodTags + Home (WF-02) |
| JTBD-3 | Quando um amigo me recomenda algo, quero saber o quanto nosso gosto realmente combina, para calibrar a expectativa | PulseMatch (WF-08) |
| JTBD-4 | Quando quero falar sobre um final, quero fazer isso sem estragar a experiência de quem ainda não viu | Spoiler Safe (WF-06) |
| JTBD-5 | Quando olho para trás, quero ver meu próprio gosto tomando forma, para sentir que registrar valeu a pena | Diário e perfil (WF-07, WF-08) |

---

## 6. Diferenciais

| Diferencial | O que é | Por que importa | Risco |
|---|---|---|---|
| **PulseScore** | Avaliação opcional por história, atuação, visual e trilha | Enriquece o mapa de gosto e permite recomendação por dimensão ("você valoriza trilha") | Fricção. Mitigado por ser opcional e recolhido (H3) |
| **MoodTags** | Tags de sensação (leve, tenso, reflexivo…) usadas para marcar **e** para filtrar | É o critério real de escolha de quem senta no sofá sem plano | Vocabulário aberto vira bagunça. Mitigado com lista fechada e curada no MVP |
| **PulseMatch** | Percentual de afinidade entre dois perfis | Transforma recomendação social em algo calibrável | Vira número mágico sem explicação. Mitigado exibindo em que os perfis concordam e divergem, com link para os títulos em comum |
| **Spoiler Safe** | Conteúdo marcado nasce oculto; revelar é ação deliberada | Remove o custo de participar da conversa | Depende do autor marcar. Mitigado com o controle em destaque e prévia do card fechado antes de publicar |

**Defensabilidade:** nenhum dos quatro é tecnicamente difícil de copiar. O ativo defensável é o **acúmulo do mapa de gosto**: quanto mais tempo a pessoa registra, mais caro fica migrar. Por isso o MVP prioriza o loop de registro acima de qualquer recurso social avançado.

---

## 7. Benchmark competitivo

| Produto | Foco | Filmes | Séries | Avaliação multidimensional | Afinidade entre perfis | Descoberta por humor | Spoiler oculto por padrão |
|---|---|:--:|:--:|:--:|:--:|:--:|:--:|
| **Letterboxd** | Diário social de cinema | ✅ | ❌ | ❌ | ❌ | ❌ | Parcial (aviso manual) |
| **IMDb** | Base de dados e nota agregada | ✅ | ✅ | ❌ | ❌ | ❌ | Parcial |
| **Trakt** | Rastreamento automático de consumo | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Serializd** | Diário de séries | ❌ | ✅ | ❌ | ❌ | ❌ | Parcial |
| **JustWatch** | Onde assistir | ✅ | ✅ | ❌ | ❌ | ❌ | n/a |
| **CinePulse** | Diário social + descoberta por gosto | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

**Conclusão do benchmark:** o espaço vazio não é "mais um app de listas". É a combinação de **filmes e séries no mesmo diário** com **descoberta guiada por gosto e humor** — hoje ninguém entrega os dois lados bem.

---

## 8. Posicionamento

> Para **quem assiste filmes e séries toda semana e não quer perder tempo escolhendo**,
> o **CinePulse** é um **diário social de entretenimento**
> que **transforma cada avaliação em uma descoberta melhor na próxima vez**.
> Diferente do **Letterboxd**, que cobre só cinema e trata todo mundo pela mesma nota média,
> o CinePulse **junta filmes e séries e mostra o quanto cada título combina com você**.

**Tom de voz:** direto, curioso, leve, inclusivo. Sem elitismo cinematográfico — quem só assiste comédia romântica é tão bem-vindo quanto quem assiste cinema autoral.

---

## 9. Métricas de sucesso

### 9.1 North Star Metric

> **Títulos avaliados por usuário ativo semanal (avaliações / WAU).**

Escolhida porque é a única métrica que só sobe quando o produto entrega valor dos dois lados: a pessoa está assistindo (consumo) **e** registrando (o loop está funcionando). Downloads e cadastros não medem nada disso.

### 9.2 Métricas de apoio (HEART)

| Dimensão | Métrica | Meta do MVP |
|---|---|---|
| **Happiness** | Nota do app / pesquisa curta de satisfação | ≥ 4,0 |
| **Engagement** | Avaliações por usuário ativo por semana | ≥ 2 |
| **Adoption** | % de novos usuários que registram ≥ 1 título no primeiro dia | ≥ 60% |
| **Retention** | Usuários que voltam a registrar em D7 / D30 | ≥ 35% / ≥ 20% |
| **Task success** | Tempo mediano para registrar um título já encontrado | **≤ 20 segundos** |

### 9.3 Métrica de ativação

> Um usuário está **ativado** quando registra **3 títulos nos primeiros 7 dias**.

Abaixo disso, o diário está vazio demais para gerar retorno visível e o mapa de gosto é pobre demais para alimentar PulseMatch. Toda a UX de onboarding é desenhada para atravessar essa linha.

---

## 10. Riscos e premissas

| Risco | Impacto | Mitigação |
|---|---|---|
| Catálogo depende de API de terceiros (TMDB ou equivalente) | Alto — sem catálogo não existe produto | Definir a API já no CP5 e isolar atrás de uma camada de repositório |
| Rede social vazia no início (*cold start*) | Alto — PulseMatch sem amigos é inútil | MVP entrega valor solo (diário e estatísticas); o social é bônus, não pré-requisito |
| PulseScore ser percebido como formulário (H3) | Médio | Opcional, recolhido, nunca bloqueia o salvamento |
| Escopo maior do que o prazo acadêmico | Alto | Priorização RICE com linha de corte explícita no doc 03 |
| Direitos de imagem de pôsteres | Médio | Usar apenas os artefatos fornecidos pela API do catálogo, respeitando os termos de uso |

**Premissas assumidas:** existe API de catálogo gratuita e adequada; o grupo consegue publicar um build Android; o público de teste é acessível (colegas de turma e redes pessoais).

---

## 11. O que o CinePulse *não* é

Delimitar o anti-escopo é parte da proposta de valor:

- **Não é um serviço de streaming.** Não reproduz conteúdo.
- **Não é um agregador de "onde assistir".** Isso é uma funcionalidade futura (P2), não o produto.
- **Não é uma rede social genérica.** Não há feed aberto, DMs ou stories.
- **Não é um site de crítica profissional.** O conteúdo é gerado pela comunidade.
- **Não é um app só de cinema.** Séries são cidadãs de primeira classe desde o MVP — essa é uma decisão de produto, não uma omissão.

---

## Fontes

- Nielsen — [State of Play 2023: content discovery challenges](https://www.nielsen.com/news-center/2023/nielsens-state-of-play-report-delivers-new-insights-as-streamings-next-evolution-brings-content-discovery-challenges-for-viewers/)
- Nielsen / Gracenote — [Impact of ineffective content discovery on consumer happiness (2025)](https://www.nielsen.com/news-center/2025/new-gracenote-report-highlights-impact-of-ineffective-content-discovery-on-consumer-happiness-with-streaming/)
- Deadline — [Letterboxd hits 17 million members (jan/2025)](https://deadline.com/2025/01/letterboxd-indie-films-members-surge-in-2024-favorite-films-1236251217/)
- Poder360 / IBGE — [Streaming pago chega a 44,4% dos lares brasileiros em 2025](https://www.poder360.com.br/poder-tech/streaming-pago-chega-a-444-dos-lares-brasileiros-em-2025/)
