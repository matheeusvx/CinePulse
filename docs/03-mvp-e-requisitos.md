# 03 — MVP, User Stories e Priorização

> **Responsável:** Rafael Ferreira (Product / UX) · **Checkpoint 4** · Atualizado em 09/09/2026
> Documentos irmãos: [01 — Visão do produto](01-visao-produto.md) · [02 — Público, personas e jornada](02-publico-personas-e-jornada.md) · [06 — Wireframes e fluxos](06-wireframes-e-fluxos.md) · [10 — Pesquisa e validação](10-pesquisa-e-validacao.md)

---

## 1. Objetivo do MVP

> **Hipótese que o MVP testa:** se registrar um título custar menos de 20 segundos, as pessoas vão registrar o suficiente para que o mapa de gosto gere descobertas melhores — e voltarão ao app **para decidir o que assistir**, não só para arquivar.

O MVP é considerado bem-sucedido quando:

| Critério | Meta |
|---|---|
| Tempo mediano para registrar um título já encontrado | **≤ 20 segundos** |
| Usuários que registram ≥ 3 títulos nos primeiros 7 dias (ativação) | **≥ 40%** |
| Usuários ativados que voltam a registrar em D7 | **≥ 35%** |
| Usuários que usam o filtro por humor ao menos uma vez | **≥ 30%** |

Se a primeira linha falhar, nenhuma das outras acontece. Ela é a restrição de projeto que governa todo o desenho de interface do doc 06.

---

## 2. O loop mínimo

O menor conjunto de funcionalidades que fecha o ciclo de valor descrito no doc 01:

```text
buscar → abrir detalhe → marcar assistido + nota → ver no diário
```

Tudo o que não estiver nesse caminho precisa **provar** que merece existir no MVP. É esse o papel da priorização abaixo.

---

## 3. Épicos

| Épico | Descrição | User stories |
|---|---|---|
| **E1 — Acesso** | Entrar no app com o menor atrito possível | US-01 a US-03 |
| **E2 — Descoberta** | Encontrar um título por busca, humor ou prova social | US-04 a US-07 |
| **E3 — Registro e avaliação** | Registrar o que foi assistido e o quanto valeu | US-08, US-09, US-17 |
| **E4 — Review e Spoiler Safe** | Expressar opinião sem estragar a de ninguém | US-10, US-13 |
| **E5 — Listas e diário** | Guardar para depois e consultar o histórico | US-11, US-12, US-14, US-20 |
| **E6 — Social e afinidade** | Comparar gosto e confiar em recomendação | US-15, US-16, US-19 |
| **E7 — Perfil** | Ver o próprio gosto tomando forma | US-18 |

---

## 4. User stories com critérios de aceite

Formato: *Como <persona>, quero <ação> para <benefício>*, seguido de critérios de aceite verificáveis.

### E1 — Acesso

#### US-01 · Criar conta · `P0`
> Como visitante, quero criar uma conta com e-mail e senha para que meus registros fiquem salvos.

- **Dado** que estou na aba "Criar conta", **quando** preencho e-mail válido e senha com ao menos 8 caracteres, **então** a conta é criada e sou levado ao app já autenticado.
- **Dado** que informo um e-mail já cadastrado, **quando** confirmo, **então** vejo a mensagem "Esse e-mail já tem conta" com um atalho para entrar.
- **Dado** que a senha tem menos de 8 caracteres, **então** o botão de confirmar permanece inativo e o requisito é exibido antes de eu tentar enviar.
- O formulário exige **apenas e-mail e senha**. Nome, avatar e gêneros favoritos são pedidos depois do primeiro acesso.

#### US-02 · Entrar · `P0`
> Como usuário cadastrado, quero entrar rapidamente para retomar meu diário.

- **Dado** que abro o app tendo entrado antes, **então** minha sessão é restaurada sem novo login.
- **Dado** que informo credenciais inválidas, **então** vejo um erro em linguagem humana, sem revelar qual dos dois campos está errado.

#### US-03 · Explorar sem conta · `P0`
> Como visitante, quero navegar pelo catálogo e ler reviews antes de criar conta, para entender se o app vale a pena.

- **Dado** que toco em "Explorar sem criar conta", **então** consigo buscar, abrir detalhes e ler reviews.
- **Dado** que tento avaliar, salvar ou seguir alguém, **então** o cadastro é oferecido **naquele contexto**, e a ação é concluída automaticamente após o cadastro.

---

### E2 — Descoberta

#### US-04 · Buscar filmes e séries · `P0`
> Como Lucas, quero buscar um título pelo nome para registrá-lo rapidamente.

- **Dado** que digito ao menos 2 caracteres, **então** os resultados aparecem em até 1,5 s em conexão normal.
- **Dado** que a busca retorna resultados, **então** cada linha mostra pôster, título, ano, tipo (filme/série), duração ou temporadas e a nota da comunidade.
- **Dado** que existe um resultado, **então** consigo salvá-lo na watchlist **sem abrir a tela de detalhe**.
- **Dado** que a busca não retorna nada, **então** vejo um estado vazio com sugestão de correção, não uma tela em branco.
- **Dado** que a rede falha, **então** vejo um erro com ação de "tentar de novo" e um caminho alternativo para o diário.

#### US-05 · Ver detalhe do título · `P0`
> Como Lucas, quero ver informações de um título para decidir se assisto e registrar minha opinião.

- **Dado** que abro um título, **então** vejo capa, sinopse, ano, gênero, duração e nota da comunidade.
- **Dado** que estou autenticado, **então** as ações "Assistido" e "Watchlist" ficam visíveis sem rolagem.
- **Dado** que existem reviews com spoiler, **então** elas aparecem **fechadas** por padrão.

#### US-06 · Descobrir por humor (MoodTags) · `P0` *(promovida — ver §7)*
> Como Marina, quero filtrar por sensação para decidir o que assistir agora, sem saber o nome do título.

- **Dado** que estou na Home, **então** os chips de humor aparecem acima da dobra.
- **Dado** que seleciono "Leve", **então** vejo títulos cuja MoodTag mais frequente da comunidade é "Leve", ordenados por relevância.
- **Dado** que seleciono duas tags, **então** o resultado considera as duas (interseção), e a contagem de resultados é exibida.
- **Dado** que uma tag tem menos de 5 títulos, **então** ela não é oferecida como filtro.

#### US-07 · Ver o que os amigos avaliaram · `P1`
> Como Marina, quero ver o que pessoas que sigo avaliaram, para usar recomendação de gente real.

- **Dado** que sigo ao menos uma pessoa, **então** a Home mostra as avaliações recentes dela com o percentual de PulseMatch ao lado.
- **Dado** que não sigo ninguém, **então** o bloco não aparece vazio — é substituído por uma sugestão de pessoas com gosto parecido.

---

### E3 — Registro e avaliação

#### US-08 · Marcar como assistido e avaliar · `P0` ⭐ *funcionalidade central*
> Como Lucas, quero registrar um título com nota em poucos toques, para não perder o histórico.

- **Dado** que toco em "Assistido", **então** uma folha de avaliação sobe sobre o detalhe, **sem trocar de tela**.
- **Dado** que toco em uma estrela e em "Salvar", **então** o registro é criado. **Esse caminho tem exatamente dois toques.**
- **Dado** que toco na metade esquerda de uma estrela, **então** a nota registrada é meia estrela (escala de 0,5 a 5,0).
- **Dado** que fecho a folha sem salvar, **então** nada é registrado e volto ao detalhe no mesmo ponto.
- **Dado** que salvei, **então** vejo confirmação com opção de desfazer por 5 segundos.
- Nenhum campo além da nota pode bloquear o salvamento.

#### US-09 · Detalhar o PulseScore · `P1`
> Como Pedro, quero avaliar história, atuação, visual e trilha separadamente, para que minha opinião não seja achatada em um número.

- **Dado** que estou na folha de avaliação, **então** "Detalhar PulseScore" aparece **recolhido**, marcado como opcional.
- **Dado** que expando, **então** avalio até quatro critérios independentes, cada um de 0,5 a 5.
- **Dado** que preencho apenas dois critérios, **então** o registro é salvo assim mesmo — critério não preenchido não vira zero.
- **Dado** que o título já tem PulseScore de outras pessoas, **então** vejo a média por critério depois de salvar.

#### US-17 · Marcar MoodTags · `P0` *(promovida — ver §7)*
> Como Marina, quero marcar como me senti para que o app aprenda meu humor, e não só meu gênero preferido.

- **Dado** que estou na folha de avaliação, **então** vejo uma lista **fechada e curada** de MoodTags (sem campo livre no MVP).
- **Dado** que seleciono até 3 tags, **então** elas são salvas junto com o registro.
- **Dado** que não seleciono nenhuma, **então** o registro é salvo normalmente.

---

### E4 — Review e Spoiler Safe

#### US-10 · Escrever review · `P0`
> Como Pedro, quero escrever um texto sobre o título para registrar minha análise e ser lido.

- **Dado** que marquei "Escrever uma review" na avaliação, **então** o editor abre **com a nota e as MoodTags já preenchidas** — não avalio duas vezes.
- **Dado** que o texto está vazio, **então** o botão "Publicar" permanece inativo.
- **Dado** que publico, **então** a review aparece no detalhe do título e no meu perfil.
- Limite de 2000 caracteres, com contador visível.

#### US-13 · Marcar e revelar spoiler · `P0`
> Como Pedro, quero sinalizar que minha review tem spoiler para não estragar a experiência de quem ainda não assistiu.

- **Dado** que ativo "Contém spoiler", **então** vejo, antes de publicar, uma **prévia do card fechado** como os outros verão.
- **Dado** que uma review está marcada, **então** ela aparece oculta em **todos** os lugares: detalhe, perfil, feed e notificação.
- **Dado** que toco em "revelar", **então** o conteúdo aparece **apenas naquele card**, sem revelar os demais.
- **Dado** que saio da tela e volto, **então** o card volta ao estado fechado.
- Título da obra, autor e nota permanecem visíveis mesmo com o texto oculto.

---

### E5 — Listas e diário

#### US-11 · Watchlist · `P0`
> Como Lucas, quero salvar um título para assistir depois, para não esquecer a recomendação.

- **Dado** que toco em "+ Watchlist", **então** o título é salvo e o botão muda de estado imediatamente (resposta otimista).
- **Dado** que marco como assistido um título da watchlist, **então** ele sai da watchlist automaticamente e entra no diário.
- **Dado** que estou offline, **então** a ação é enfileirada e sincronizada ao voltar a conexão.

#### US-12 · Ver o diário · `P0`
> Como Lucas, quero ver tudo o que assisti em ordem de data, para acompanhar meu histórico.

- **Dado** que tenho registros, **então** eles aparecem agrupados por mês, do mais recente para o mais antigo.
- **Dado** que estou no diário, **então** vejo três números no topo: títulos no mês, títulos no ano e nota média.
- **Dado** que não tenho nenhum registro, **então** vejo um estado vazio que explica o valor e oferece a ação de registrar o primeiro.
- Filmes e episódios aparecem na **mesma linha do tempo**, diferenciados por rótulo.

#### US-14 · Editar ou excluir um registro · `P0`
> Como Lucas, quero corrigir uma nota que dei errado, porque avaliei com pressa.

- **Dado** que toco em "editar" num registro, **então** reabro a mesma folha de avaliação com os valores atuais.
- **Dado** que excluo um registro, **então** confirmo a ação e as estatísticas do diário são recalculadas.

#### US-20 · Criar lista personalizada · `P1`
> Como Lucas, quero agrupar títulos em listas próprias, para organizar por tema.

- **Dado** que crio uma lista, **então** informo nome e, opcionalmente, descrição.
- **Dado** que a lista existe, **então** posso adicionar títulos a partir da busca ou do detalhe.
- **Dado** que a lista é pública, **então** ela aparece no meu perfil.

---

### E6 — Social e afinidade

#### US-15 · Ver o perfil de outra pessoa · `P1`
> Como Marina, quero ver o perfil de quem me recomendou algo, para entender o gosto dela.

- **Dado** que abro um perfil, **então** vejo avaliações recentes, gêneros mais avaliados, listas públicas e contagens.
- **Dado** que o perfil é privado, **então** vejo apenas nome e a opção de seguir.

#### US-16 · Ver o PulseMatch · `P1` ⭐ *diferencial*
> Como Marina, quero saber o quanto meu gosto combina com o de alguém, para calibrar a confiança na recomendação.

- **Dado** que temos **5 ou mais títulos avaliados em comum**, **então** vejo o percentual de afinidade.
- **Dado** que temos menos de 5, **então** vejo "poucos dados para comparar" — **nunca** um número inventado.
- **Dado** que o percentual aparece, **então** ele vem sempre acompanhado de: (a) em que gêneros concordamos, (b) em que divergimos e (c) um link para os títulos em comum.
- O cálculo é determinístico e explicável (ver §6).

#### US-19 · Seguir pessoas · `P1`
> Como Marina, quero seguir quem tem gosto parecido, para receber recomendações melhores.

- **Dado** que sigo alguém, **então** as avaliações dessa pessoa passam a aparecer no bloco de amigos da Home.
- **Dado** que deixo de seguir, **então** a mudança é imediata e sem confirmação.

---

### E7 — Perfil

#### US-18 · Ver meu perfil e meu mapa de gosto · `P0`
> Como Lucas, quero ver meu histórico e minhas estatísticas, para sentir que registrar valeu a pena.

- **Dado** que abro meu perfil, **então** vejo total de títulos assistidos, reviews publicadas, listas e gêneros mais avaliados.
- **Dado** que tenho menos de 5 registros, **então** as estatísticas mostram o progresso até o mínimo, em vez de gráficos vazios.

---

## 5. Priorização

### 5.1 Método

**RICE** — `RICE = (Reach × Impact × Confidence) ÷ Effort`

| Variável | Como foi medida |
|---|---|
| **Reach** | % estimado de usuários ativos que tocam a funcionalidade por mês (0–100) |
| **Impact** | 3 = massivo · 2 = alto · 1 = médio · 0,5 = baixo · 0,25 = mínimo |
| **Confidence** | 100% = evidência ou obviedade · 80% = raciocínio sólido · 50–60% = hipótese não testada · 30–40% = aposta |
| **Effort** | Pessoa-semana estimada para o time (5 integrantes, contexto acadêmico) |

> **Aviso metodológico:** Reach e Impact são estimativas do time, não medições. O RICE aqui serve para **tornar a discussão explícita e comparável**, não para produzir uma verdade. As duas exceções estratégicas em §5.3 mostram exatamente onde o julgamento sobrepõe o número.

### 5.2 Tabela

| # | Funcionalidade | US | R | I | C | E | **RICE** | Faixa |
|---|---|---|---:|---:|---:|---:|---:|:--:|
| 1 | Marcar assistido + nota | US-08 | 90 | 3 | 100% | 2,0 | **135,0** | P0 |
| 2 | Busca de filmes e séries | US-04 | 95 | 3 | 100% | 3,0 | **95,0** | P0 |
| 3 | Detalhe do título | US-05 | 95 | 2 | 100% | 2,0 | **95,0** | P0 |
| 4 | Watchlist | US-11 | 70 | 2 | 90% | 1,5 | **84,0** | P0 |
| 5 | Diário | US-12 | 80 | 2 | 95% | 2,0 | **76,0** | P0 |
| 6 | MoodTags na avaliação | US-17 | 55 | 2 | 70% | 1,5 | **51,3** | P0 |
| 7 | Cadastro e login | US-01/02 | 100 | 1 | 100% | 2,0 | **50,0** | P0 |
| 8 | Descoberta por MoodTag | US-06 | 50 | 3 | 60% | 2,5 | **36,0** | P0 |
| 9 | Editar/excluir registro | US-14 | 35 | 1 | 100% | 1,0 | **35,0** | P0 |
| 10 | Review + Spoiler Safe | US-10/13 | 45 | 2 | 80% | 2,5 | **28,8** | P0 |
| 11 | Explorar sem conta | US-03 | 40 | 1 | 70% | 1,0 | **28,0** | P0 |
| 12 | Perfil e mapa de gosto | US-18 | 60 | 1 | 90% | 2,0 | **27,0** | P0 |
| — | — | — | — | — | — | — | — | **corte do MVP** |
| 13 | Perfil de outra pessoa | US-15 | 45 | 1 | 85% | 1,5 | **25,5** | P1 |
| 14 | Seguir pessoas | US-19 | 45 | 1 | 80% | 1,5 | **24,0** | P1 |
| 15 | Feed de amigos | US-07 | 45 | 2 | 60% | 3,0 | **18,0** | P1 |
| 16 | Listas personalizadas | US-20 | 40 | 1 | 80% | 2,0 | **16,0** | P1 |
| 17 | **PulseMatch** | US-16 | 40 | 3 | 50% | 4,0 | **15,0** | **P1** ⚠ |
| 18 | Onde assistir (integração) | — | 60 | 2 | 40% | 5,0 | **9,6** | P2 |
| 19 | **PulseScore por critérios** | US-09 | 25 | 1 | 70% | 2,0 | **8,8** | **P1** ⚠ |
| 20 | Recomendação personalizada | — | 50 | 3 | 30% | 8,0 | **5,6** | P2 |
| 21 | Gamificação / conquistas | — | 30 | 0,5 | 40% | 2,0 | **3,0** | P2 |
| 22 | Listas colaborativas | — | 15 | 1 | 50% | 3,0 | **2,5** | P2 |

### 5.3 Exceções estratégicas (⚠)

Duas funcionalidades ficam **acima** da posição que o RICE daria a elas. As duas exceções são declaradas, não escondidas:

**PulseMatch (RICE 15) mantido em P1.**
O RICE penaliza o PulseMatch por confiança baixa e esforço alto — exatamente as características de qualquer hipótese ainda não testada. Mas um MVP composto só de P0 é um clone de Letterboxd com séries: entregaria um produto funcional e **nenhum aprendizado**. O PulseMatch é a materialização da hipótese H4 do doc 01; sem ele o MVP não responde à pergunta que o projeto existe para responder. O esforço é contido usando a fórmula determinística de §6, não aprendizado de máquina.

**PulseScore (RICE 8,8) mantido em P1.**
Uso projetado baixo (só o perfil do Pedro), mas: (a) é um dos quatro pilares da marca, (b) o esforço real é menor do que a tabela sugere porque ele reaproveita a mesma folha de avaliação do US-08, e (c) ele testa a hipótese H3 — a mais frágil do produto. Se o teste de usabilidade mostrar menos de 20% de abertura, o recurso **é rebaixado a P2 sem drama**.

### 5.4 MoSCoW

| Faixa | Classificação | Itens |
|---|---|---|
| **Must have** | Sem isso não existe produto | US-01, US-02, US-04, US-05, US-08, US-11, US-12, US-14, US-18 |
| **Should have** | Sem isso o produto é genérico | US-03, US-06, US-10, US-13, US-17 |
| **Could have** | Enriquece se houver tempo | US-07, US-09, US-15, US-16, US-19, US-20 |
| **Won't have (agora)** | Fora do CP5/CP6 | Onde assistir, recomendação por ML, listas colaborativas, gamificação |

---

## 6. PulseMatch v1 — fórmula determinística

Especificação de produto para o CP6. O objetivo é ser **explicável e auditável**, não sofisticado.

```text
Entrada:  perfis A e B
Comum  =  títulos avaliados pelos dois

1. Se |Comum| < 5  →  exibir "poucos dados para comparar". Fim.

2. sobreposicao = min(1 ; |Comum| / 30)
   (30 títulos em comum = crédito máximo; evita distorção com poucos dados)

3. divergencia_media = média( |nota_A(t) - nota_B(t)| ) para t em Comum
   concordancia = 1 - (divergencia_media / 4,5)
   (4,5 é a amplitude máxima possível na escala de 0,5 a 5,0)

4. PulseMatch = arredondar( 100 × (0,35 × sobreposicao + 0,65 × concordancia) )

5. Explicação exibida junto do número:
   - gênero com maior concordância  →  "vocês combinam em ..."
   - gênero com maior divergência   →  "vocês divergem em ..."
   - link para a lista dos |Comum| títulos
```

**Por que 65% para concordância:** assistir as mesmas coisas não é o mesmo que gostar das mesmas coisas. O peso maior fica em **concordar sobre as notas**, que é o que o usuário realmente quer saber ao pedir uma recomendação.

**Requisito de transparência:** nenhuma versão futura pode exibir o percentual sem os três elementos do passo 5. Isso é um requisito de produto, não uma sugestão de interface.

---

## 7. Ajustes recomendados à priorização original do CP4

A revisão de Product/UX alterou três pontos em relação à primeira versão deste documento:

| # | Antes | Agora | Por quê |
|---|---|---|---|
| 1 | MoodTags eram P1 | **MoodTags viram P0** (marcar e filtrar) | RICE 51,3 e 36,0 — acima de review+spoiler, que já era P0. É o recurso mais barato que ataca diretamente a fase 2 da jornada, o ponto mais baixo do mapa. Sem MoodTags no MVP, a dor da persona primária fica sem resposta |
| 2 | "Explorar sem conta" não existia | **Criado como P0 (US-03)** | Cadastro obrigatório na porta de entrada contradiz o princípio de UX nº 7 e é a principal causa de abandono em apps sociais novos |
| 3 | "Editar registro" não estava listado | **Criado como P0 (US-14)** | Uma UX que promete registro em 20 segundos **assume** que haverá erro. Correção precisa ser barata, senão o usuário passa a avaliar devagar |

Mantidos como estavam: PulseScore e PulseMatch em P1; listas colaborativas, gamificação, "onde assistir" e recomendação personalizada em P2.

---

## 8. Requisitos não funcionais

| Categoria | Requisito |
|---|---|
| **Desempenho** | Busca responde em ≤ 1,5 s; abertura do detalhe em ≤ 1 s com cache de pôster |
| **Offline** | Diário e watchlist legíveis sem rede; ações de escrita enfileiradas e sincronizadas depois |
| **Acessibilidade** | Contraste AA (4.5:1); alvos de toque ≥ 44×44 pt; rótulos de leitor de tela em todo ícone sem texto |
| **Estados** | Toda tela que carrega dados implementa os três estados: vazio, carregando e erro (ver WF-09) |
| **Privacidade** | Perfil pode ser privado; diário é privado por padrão; nada é publicado sem ação explícita |
| **Internacionalização** | Textos centralizados; pt-BR no MVP, estrutura pronta para outros idiomas |
| **Compatibilidade** | Android 8+ e iOS 13+; telas a partir de 360 pt de largura |
| **Dados** | Catálogo por API de terceiros, isolado atrás de uma camada de repositório para permitir troca de provedor |

---

## 9. Definição de pronto (DoD)

Uma user story só é considerada pronta quando:

1. Os critérios de aceite passam em teste manual no dispositivo.
2. Os três estados (vazio, carregando, erro) estão implementados quando a tela carrega dados.
3. Funciona em tela de 360 pt sem quebra de layout.
4. Ícones sem texto têm rótulo de acessibilidade.
5. Nenhum texto está fixo no código fora do arquivo de textos.
6. `flutter analyze` passa sem avisos novos.
7. Existe pelo menos um teste de widget cobrindo o caminho feliz.

---

## 10. Fora de escopo — e o motivo

| Fora | Motivo | Volta quando |
|---|---|---|
| Backend próprio e autenticação real | Não é o aprendizado do CP4 | CP6 |
| API de catálogo integrada | Depende de decisão técnica do time | CP5 |
| Recomendação por IA/ML | Sem base de avaliações, qualquer modelo é ruído. PulseMatch determinístico entrega 80% do valor percebido com 5% do esforço | Depois de uma base real de dados |
| Listas colaborativas | Atende o segmento terciário, não o primário | Pós-MVP |
| "Onde assistir" | Depende de integração externa cara e de disponibilidade regional | P2 |
| Gamificação | Risco de incentivar registro sem valor, poluindo o mapa de gosto | Só se a retenção pedir |
| Comentários em reviews | Abre superfície de moderação que o time não tem como sustentar | Fora do horizonte |

---

## 11. Métricas por funcionalidade

| Funcionalidade | Métrica de sucesso | Meta |
|---|---|---|
| Avaliação rápida (US-08) | Tempo mediano até salvar | ≤ 20 s |
| Busca (US-04) | Buscas que terminam em detalhe aberto | ≥ 60% |
| MoodTags (US-06/17) | Usuários que usam ao menos uma vez | ≥ 30% |
| PulseScore (US-09) | Usuários que expandem a seção opcional | ≥ 20% *(teste de H3)* |
| Spoiler Safe (US-13) | Reviews marcadas que são reveladas | ≥ 30% |
| PulseMatch (US-16) | Usuários que abrem "títulos em comum" | ≥ 25% |
| Diário (US-12) | Retorno ao diário em D7 | ≥ 35% |
