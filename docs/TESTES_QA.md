# Plano de Testes de Execução & Garantia da Qualidade (QA) — CinePulse 🧪📋

**Projeto:** CinePulse — Aplicativo Social de Filmes e Séries  
**Objetivo:** Validar a estabilidade, os fluxos de navegação e a integridade da interface do início ao fim, garantindo uma execução livre de erros, travamentos ou exceções não tratadas.  
**Ambiente:** Flutter / Dart • Dark Theme • Layout Responsivo (Mobile & Desktop)

---

## 1. Roteiro Passo a Passo para Execução dos Testes

Para validar a integridade técnica da aplicação a partir do terminal, execute a sequência padrão:

```bash
# 1. Instalar as dependências do projeto
flutter pub get

# 2. Executar a análise estática de código (Clean Code & Boas Práticas)
flutter analyze

# 3. Executar os testes automatizados de widgets
flutter test

# 4. Iniciar a aplicação no ambiente desejado
flutter run
```

---

## 2. Matriz de Casos de Teste (CT-01 a CT-12)

Esta matriz cobre todos os componentes de interface, interações e fluxos do aplicativo:

| ID | Fluxo / Módulo | O que é testado | Ação de Teste | Resultado Esperado | Status |
|:---:|:---|:---|:---|:---|:---:|
| **CT-01** | Inicialização | Inicialização do app e injeção do tema escuro | Executar a aplicação | O app abre diretamente na aba **Descobrir** com fundo escuro (`#090D18`), tipografia nítida e sem piscar telas em branco. | ✅ Aprovado |
| **CT-02** | Navegação Base | Alternância entre as abas principais | Clicar em: *Descobrir*, *Diário*, *Listas* e *Perfil* | As telas alternam de imediato via `IndexedStack`, preservando o estado sem recarregamento. O ícone ativo recebe a cor de destaque. | ✅ Aprovado |
| **CT-03** | Responsividade | Adaptação para telas expandidas | Redimensionar a janela para largura $\ge 760px$ | A barra inferior é ocultada e entra o menu lateral (*NavigationRail* de 88px) com divisor vertical e largura máxima de leitura mantida. | ✅ Aprovado |
| **CT-04** | MoodTags | Filtro interativo por clima emocional | Na Home, clicar nos chips: *Leve*, *Épico*, *Tenso* | O chip selecionado recebe fundo violeta e ícone em destaque. O estado atualiza instantaneamente via `setState`. | ✅ Aprovado |
| **CT-05** | Carrossel 'Em Alta' | Rolagem horizontal das obras em cartaz | Deslizar horizontalmente os cards (*Duna 2*, *Severance*, *Interestelar*) | Deslize fluido a 60fps exibindo títulos, badges de gênero e notas sem qualquer corte ou estouro de layout (*overflow*). | ✅ Aprovado |
| **CT-06** | PulseScore™ | Visualização dos indicadores por dimensão | Rolar a Home até o card de destaque do PulseScore | Barras de progresso e percentuais proporcionais para História (96%), Atuação (98%), Visual (100%) e Trilha (94%). | ✅ Aprovado |
| **CT-07** | Spoiler Safe™ | Interação de proteção e revelação de spoiler | Clicar no botão **"Mostrar spoiler"** e depois em **"Ocultar"** | O conteúdo censurado expande com animação suave; o segundo clique volta a recolher e proteger o texto. | ✅ Aprovado |
| **CT-08** | Campo de Busca | Feedback amigável na barra de busca | Tocar na barra "Buscar filmes, séries ou pessoas..." | Dispara um `SnackBar` informativo na parte inferior da tela avisando sobre a futura conexão com a API externa, sem travar o app. | ✅ Aprovado |
| **CT-09** | Diário | Listagem do histórico de títulos assistidos | Acessar a aba **Diário** | Exibe as obras com data de consumo, ícones correspondentes e notas atribuídas em estrelas. | ✅ Aprovado |
| **CT-10** | Listas | Organização por pastas e coleções | Acessar a aba **Listas** | Exibe as categorias (*Quero assistir*, *Filmes para o fim de semana*, *Favoritos*) acompanhadas dos contadores numéricos de itens. | ✅ Aprovado |
| **CT-11** | Perfil & Match | Visualização do perfil e afinidade social | Acessar a aba **Perfil** | Exibe dados do usuário, métricas de consumo (142 assistidos, 38 reviews) e o gráfico circular com 88% de sintonia do PulseMatch. | ✅ Aprovado |
| **CT-12** | Teste Automatizado | Validação formal do ciclo de vida dos widgets | Executar `flutter test` no terminal | O teste automatizado localiza e valida a existência dos widgets principais com sucesso (`All tests passed!`). | ✅ Aprovado |

---

## 3. Registro Técnico de Mocks & Próximas Implementações

Mapeamento transparente do estado atual dos dados e funcionalidades:

1. **Dados em Memória (Estado Volátil):**  
   - *Comportamento:* Alterações de interface (ex: alternar tags de humor ou expandir spoiler) residem na memória do componente (`StatefulWidget`). Caso o app seja reiniciado, retorna ao estado inicial.  
   - *Próxima etapa:* Adição de banco de dados local (Hive/SQLite) e sincronização remota via nuvem.

2. **Catálogo de Obras:**  
   - *Comportamento:* Títulos, sinopses e notas utilizam dados mockados consistentes com as produções reais (*Duna: Parte 2*, *Severance*, *Interestelar*). A barra de pesquisa exibe feedback visual sem disparar requisições de rede.  
   - *Próxima etapa:* Integração com a API pública do The Movie Database (TMDB).

3. **Adição Dinâmica de Registros:**  
   - *Comportamento:* Diário e Listas operam em modo de visualização dos registros existentes.  
   - *Próxima etapa:* Formulário modal de cadastro com seletores de data e atribuição das 4 notas do PulseScore.

4. **Autenticação:**  
   - *Comportamento:* Perfil pré-carregado para navegação imediata.  
   - *Próxima etapa:* Tela de login/cadastro com autenticação de usuários (e-mail/senha e Google Sign-In).

5. **Cálculo de Afinidade (PulseMatch):**  
   - *Comportamento:* Percentual de 88% fixado estaticamente para exibição do componente visual de gráfico circular.  
   - *Próxima etapa:* Processamento algorítmico comparativo de vetores de avaliação entre usuários no backend.

---

## 4. Roteiro de Demonstração Passo a Passo

Sequência recomendada para demonstrar o funcionamento sem erros e com máxima fluidez:

1. **Tela Descobrir (Home):**
   - Inicie na tela principal;
   - Role a página e toque em 2 ou 3 chips de humor em **"Para o seu humor"** (*Leve*, *Épico*, *Tenso*);
   - Deslize o carrossel horizontal de filmes em alta para a esquerda e direita;
   - No card **PulseScore**, aponte as barras de História, Atuação, Visual e Trilha;
   - No card **Review com Spoiler Safe**, clique em **"Mostrar spoiler"** para abrir e depois em **"Ocultar"** para fechar;
   - Toque na barra de busca para exibir a notificação amigável na base da tela.
2. **Tela Diário:**
   - Clique na aba **Diário** e mostre a listagem cronológica com datas e notas.
3. **Tela Listas:**
   - Clique na aba **Listas** e mostre a separação por categorias temáticas e contadores.
4. **Tela Perfil:**
   - Clique na aba **Perfil**, mostre as métricas de usuário e o gráfico circular animado com o **PulseMatch de 88%**.
