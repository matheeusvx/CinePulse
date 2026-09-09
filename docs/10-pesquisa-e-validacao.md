# 10 — Pesquisa e Validação

> **Responsável:** Rafael Ferreira (Product / UX) · **Checkpoint 4** · Atualizado em 09/09/2026
> Documentos irmãos: [01 — Visão do produto](01-visao-produto.md) · [02 — Público, personas e jornada](02-publico-personas-e-jornada.md) · [03 — MVP e requisitos](03-mvp-e-requisitos.md) · [06 — Wireframes e fluxos](06-wireframes-e-fluxos.md)

---

## 1. Status da validação

| Tipo de evidência | Status | Onde está |
|---|---|---|
| **Pesquisa desk (dados secundários)** | ✅ Feita | [doc 01, §2.1](01-visao-produto.md) — Nielsen, IBGE, Deadline |
| **Benchmark competitivo** | ✅ Feito | [doc 01, §7](01-visao-produto.md) |
| **Questionário com o público-alvo** | ⏳ Instrumento pronto, aplicação pendente | §4 deste documento |
| **Entrevistas em profundidade** | ⏳ Roteiro pronto, aplicação pendente | §5 deste documento |
| **Teste de usabilidade do protótipo** | ⏳ Plano pronto, aplicação pendente | §6 deste documento |

**Declaração honesta:** as personas e a jornada dos docs 01 e 02 foram construídas a partir de **dados secundários de mercado + observação do próprio comportamento do time e do círculo próximo**. Elas são **hipóteses estruturadas**, não conclusões de pesquisa primária. Este documento existe para tornar isso explícito e para deixar o instrumento de validação pronto para uso.

> Apresentar persona como fato sem ter falado com ninguém é o erro mais comum em trabalho de produto. Preferimos declarar a limitação e mostrar como ela seria resolvida.

---

## 2. Hipóteses e critérios de decisão

| # | Hipótese | Instrumento | **Falseada se…** | Decisão em caso de falha |
|---|---|---|---|---|
| **H1** | "Não sei o que assistir" é uma dor recorrente e irritante | Questionário Q4–Q6 | menos de 50% citarem espontaneamente | Repensar a proposta de valor: o produto vira só diário |
| **H2** | Querem registrar, mas desistem pelo esforço | Questionário Q7–Q9 | mais de 60% já usarem solução e estarem satisfeitos | Focar no diferencial social, não no registro |
| **H3** | PulseScore por critérios é valor, não formulário | Teste de usabilidade, tarefa 1 | menos de 20% expandirem a seção opcional | Rebaixar PulseScore para P2 |
| **H4** | PulseMatch aumenta a confiança na recomendação | Entrevista bloco 4 + teste, tarefa 4 | preferirem nota média da comunidade ao percentual | Manter apenas a nota agregada; PulseMatch vira P2 |
| **H5** | Filtrar por humor supera filtrar por gênero | Teste de usabilidade, tarefa 2 | uso do filtro de humor abaixo do de gênero | MoodTags voltam a ser só marcação, não descoberta |
| **H6** | Spoiler oculto aumenta o engajamento com reviews | Teste de usabilidade, tarefa 3 | taxa de revelação abaixo de 30% | Rever o desenho do card, não o princípio |

**Regra do time:** uma hipótese falseada gera **mudança documentada de escopo**, não uma nota de rodapé. O registro dessas mudanças vai no CP5.

---

## 3. Método

| Etapa | Técnica | Amostra | Duração |
|---|---|---|---|
| 1 | Pesquisa desk | — | ✅ concluída |
| 2 | Questionário online (Google Forms) | 40–60 respostas do público-alvo | 5 min por pessoa |
| 3 | Entrevistas semiestruturadas | 5 pessoas (3 do perfil Marina, 2 do perfil Lucas) | 25 min cada |
| 4 | Teste de usabilidade moderado sobre o protótipo HTML | 5 pessoas | 20 min cada |

**Por que 5 pessoas no teste:** cinco participantes revelam a maior parte dos problemas graves de usabilidade de uma interface (Nielsen Norman Group). Para trabalho acadêmico com prazo curto, cinco testes bem conduzidos valem mais do que trinta respostas de formulário.

**Recrutamento:** colegas de turma, redes pessoais e comunidades de cinema/séries. Critério de qualificação: assiste ≥ 2 títulos por semana **e** já tentou registrar o que assiste alguma vez.

---

## 4. Questionário — pronto para aplicar

**Título:** *Como você escolhe o que assistir?*
**Introdução:** "Estamos pesquisando hábitos de consumo de filmes e séries para um projeto de faculdade. Leva 5 minutos e é anônimo."

### Bloco A — Qualificação

| # | Pergunta | Tipo |
|---|---|---|
| Q1 | Quantos filmes ou episódios você assiste por semana? | 0 / 1 / 2–4 / 5–7 / 8+ |
| Q2 | Quais serviços você usa? | múltipla escolha |
| Q3 | Qual sua faixa etária? | 16–20 / 21–25 / 26–30 / 31–35 / 36+ |

> Quem responder "0" ou "1" em Q1 é **antipúblico** e deve ser separado na análise, não descartado — a comparação entre os dois grupos é informativa.

### Bloco B — Dor de descoberta *(testa H1)*

| # | Pergunta | Tipo |
|---|---|---|
| Q4 | Quanto tempo você costuma levar decidindo o que assistir? | < 2 min / 2–5 / 5–10 / 10–20 / mais |
| Q5 | Já aconteceu de você desistir e desligar a TV por não achar nada? | nunca / raramente / às vezes / sempre |
| Q6 | **O que mais te atrapalha na hora de escolher?** | **aberta** — não sugerir opções, para medir menção espontânea |

### Bloco C — Registro *(testa H2)*

| # | Pergunta | Tipo |
|---|---|---|
| Q7 | Você anota em algum lugar o que já assistiu? | não / às vezes / sempre |
| Q8 | Se sim, onde? | Letterboxd / IMDb / notas do celular / planilha / outro |
| Q9 | Se já tentou e parou, **por quê?** | aberta |
| Q10 | O que te faria voltar a registrar? | aberta |

### Bloco D — Diferenciais

| # | Pergunta | Tipo |
|---|---|---|
| Q11 | Ao avaliar, você sente que uma nota única expressa sua opinião? | escala 1–5 *(H3)* |
| Q12 | Você confiaria mais numa recomendação se soubesse o quanto seu gosto combina com o de quem recomendou? | escala 1–5 *(H4)* |
| Q13 | Você já escolheu o que assistir pelo tipo de sensação que queria (leve, tenso, emocionante)? | sim / não *(H5)* |
| Q14 | Já tomou spoiler sem querer lendo sobre um título? | nunca / raramente / às vezes / sempre *(H6)* |
| Q15 | Usaria um app que junta filmes **e** séries no mesmo histórico? | escala 1–5 |

### Bloco E — Aberta

| # | Pergunta |
|---|---|
| Q16 | Se existisse o app perfeito para isso, o que ele **precisaria** ter? |

**Como analisar Q6, Q9, Q10 e Q16:** codificação temática simples — agrupar respostas em categorias, contar frequência, e verificar se as quatro dores do doc 01 §2.2 aparecem espontaneamente. Se uma dor do documento **não aparecer em nenhuma resposta aberta**, ela é candidata a remoção.

---

## 5. Roteiro de entrevista (25 min)

Semiestruturada. Perguntar sobre **comportamento passado**, nunca sobre intenção futura — "você usaria?" produz respostas educadas e inúteis.

**Bloco 1 — Contexto (5 min)**
- Me conta como foi a última vez que você sentou para assistir algo. Começa do momento em que você decidiu assistir.
- Quem estava junto? Que horas eram?

**Bloco 2 — Descoberta (7 min)**
- Como você chegou naquele título específico?
- Antes de escolher esse, você considerou outros? O que fez você descartar?
- Quando foi a última vez que você desistiu de escolher?

**Bloco 3 — Registro (6 min)**
- Depois que terminou, você fez alguma coisa? Comentou, postou, anotou?
- Você lembra o que assistiu no mês passado? *(deixar a pessoa tentar — o silêncio aqui é o dado)*
- Já usou algum app para isso? O que aconteceu?

**Bloco 4 — Confiança e recomendação (5 min)**
- Quem te recomenda filme e você realmente ouve? Por que essa pessoa?
- *(mostrar o perfil com PulseMatch no protótipo)* O que esse número te diz? — **não explicar antes**, observar a interpretação espontânea.
- Isso mudaria sua decisão?

**Bloco 5 — Fechamento (2 min)**
- Se eu pudesse resolver **um** problema seu sobre filmes e séries, qual seria?

**Regras de condução:** não vender o produto; não corrigir o participante; após uma resposta curta, ficar em silêncio 3 segundos antes de seguir.

---

## 6. Teste de usabilidade do protótipo

**Material:** `docs/app_interativo.html`, aberto no celular do participante ou em janela de 390 px.
**Formato:** moderado, pensando em voz alta, 20 minutos, 5 participantes.

### Tarefas

| # | Tarefa (dita ao participante) | Mede | Sucesso |
|---|---|---|---|
| 1 | "Registre o último filme ou série que você assistiu, com a nota que você daria." | Meta dos 20 s e **H3** | Concluída sem ajuda em ≤ 20 s. Anotar se abriu o PulseScore |
| 2 | "É sexta à noite e você quer algo leve. Encontre uma opção." | **H5** | Usou o filtro por humor sem ser instruído |
| 3 | "Você quer comentar o final sem estragar para quem não viu. Faça isso." | **H6** | Ativou o controle de spoiler sem ajuda |
| 4 | "Você não conhece a Marina. Ela recomendou um filme. Vale a pena confiar?" | **H4** | Encontrou e interpretou o PulseMatch corretamente |

### Métricas coletadas

| Métrica | Como |
|---|---|
| Tempo por tarefa | Cronômetro, do fim do enunciado à conclusão |
| Taxa de sucesso | Concluiu sozinho / com dica / não concluiu |
| Erros e hesitações | Contagem de toques errados e pausas > 3 s |
| Satisfação | 3 perguntas ao final, escala 1–5: facilidade, clareza, vontade de usar |

### Ficha de observação

```text
Participante __  ·  Idade __  ·  Títulos/semana __  ·  Já registra? __

Tarefa 1 · tempo ____s · sucesso: sozinho / com dica / falhou
   abriu PulseScore?  sim / não      ← evidência direta de H3
   marcou MoodTag?    sim / não
   citação relevante: ______________________________

Tarefa 2 · tempo ____s · sucesso: sozinho / com dica / falhou
   usou filtro por humor? sim / não  ← evidência direta de H5
   citação relevante: ______________________________

Tarefa 3 · tempo ____s · sucesso: sozinho / com dica / falhou
   achou o controle de spoiler sozinho? sim / não
   citação relevante: ______________________________

Tarefa 4 · tempo ____s · sucesso: sozinho / com dica / falhou
   interpretou o PulseMatch corretamente? sim / não
   o que ele achou que o número significava: ________

Problemas observados (gravidade 1 a 3):
1. ____________________________________  [ ]1 [ ]2 [ ]3
2. ____________________________________  [ ]1 [ ]2 [ ]3
```

**Gravidade:** 1 = cosmético · 2 = atrapalha, mas conclui · 3 = impede a tarefa.
**Regra:** todo problema de gravidade 3 vira item obrigatório de backlog no CP5.

---

## 7. Cronograma sugerido

| Semana | Atividade | Entregável |
|---|---|---|
| 1 | Aplicar questionário | 40+ respostas |
| 2 | Entrevistas (5) | Notas + citações por bloco |
| 2 | Consolidar e revisar personas | Docs 01 e 02 atualizados com evidência |
| 3 | Teste de usabilidade (5) | Fichas preenchidas + lista de problemas |
| 3 | Revisar priorização | Doc 03 atualizado com hipóteses confirmadas ou falseadas |
| 4 | Fechar escopo do CP5 | Backlog priorizado com evidência |

---

## 8. Como registrar o resultado

Quando a pesquisa for aplicada, este documento ganha uma seção **§9 — Resultados**, com:

1. Amostra real (n, perfil, período).
2. Tabela de hipóteses com veredito: **confirmada / falseada / inconclusiva**.
3. Mudanças de escopo decorrentes, com link para o commit que as aplicou.
4. Citações literais dos participantes (anonimizadas) que sustentam cada veredito.

Enquanto essa seção não existir, tudo neste repositório sobre comportamento de usuário deve ser lido como **hipótese**.
