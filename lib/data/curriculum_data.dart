import '../models/curriculum.dart';

List<PhaseData> get allPhases => _phases;

final List<PhaseData> _phases = [
  PhaseData(
    globalIndex: 0,
    world: 1,
    indexInWorld: 1,
    titulo: 'Olá, Dart! Tipos primitivos',
    descricao: 'Entender Dart, tipos básicos e null safety introdutório.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'Dart é a linguagem do Flutter: tipada, compilada e pensada para UI reativa.\n\n'
            'Tipos primitivos: int, double, String, bool.\n'
            'Variáveis tipadas guardam um tipo fixo; use print() para ver valores no console.\n\n'
            '> 💡 Dica: prefira tipos explícitos no começo — ajuda o compilador a te guiar.',
      ),
      ContentBlock(
        style: 'code',
        body: "int idade = 25;\n"
            "double altura = 1.75;\n"
            "String nome = 'Ana';\n"
            "bool ativo = true;\n"
            '\nprint(nome); // Ana',
      ),
      ContentBlock(
        style: 'tip',
        body:
            'Erro comum: misturar tipo e valor (ex.: int x = "10") — o analisador estático barra isso.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Null safety básico: int? aceita null; int não aceita. Na fase anterior você só precisa reconhecer o ?.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 1,
    world: 1,
    indexInWorld: 2,
    titulo: 'Variáveis: var, final e const',
    descricao: 'Três formas de declarar variáveis e quando usar cada uma.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'var: inferência de tipo, valor pode mudar.\n'
            'final: atribuído uma vez em runtime.\n'
            'const: constante em tempo de compilação.\n\n'
            'Boas práticas: use final quando não for reatribuir.',
      ),
      ContentBlock(
        style: 'code',
        body: "var nome = 'Carlos';       // String inferida\n"
            'final dataNascimento = DateTime.now();\n'
            'const pi = 3.14159;',
      ),
      ContentBlock(
        style: 'tip',
        body: 'Erro comum: achar que final pode ser alterado depois — não pode.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 2,
    world: 1,
    indexInWorld: 3,
    titulo: 'Exercício: tipos e variáveis',
    descricao: 'Pratique tipos primitivos e var/final/const (A + B + C).',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt:
            'Quais das afirmações abaixo sobre tipos primitivos em Dart são verdadeiras? (marque todas)',
        options: const [
          '<code>double</code> é o tipo correto para armazenar <code>3.14</code>',
          '<code>int</code> pode armazenar o valor <code>"vinte"</code>',
          '<code>bool</code> aceita apenas <code>true</code> ou <code>false</code>',
          'Uma variável <code>int?</code> pode receber <code>null</code>',
        ],
        correctIndices: const {0, 2, 3},
        explanation:
            '"vinte" é String. As demais estão corretas: double para decimais, bool binário, ? torna nullable.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual declaração abaixo é válida e correta em Dart?',
        options: const [
          '<code>int preco = 49.90;</code>',
          '<code>String ativo = true;</code>',
          '<code>double altura = 1.75;</code>',
          "<code>bool nome = 'João';</code>",
        ],
        singleCorrectIndex: 2,
        explanation: '1.75 é double; as outras misturam tipo e valor.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt:
            'Sobre <code>var</code>, <code>final</code> e <code>const</code>, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          '<code>var</code> infere o tipo a partir do valor',
          '<code>final</code> permite alterar o valor após a primeira atribuição',
          '<code>const</code> é constante em tempo de compilação',
          '<code>final</code> e <code>const</code> aceitam só uma atribuição',
        ],
        singleIncorrectIndex: 1,
        explanation: '<code>final</code> não pode ser reatribuído; <code>var</code> sim.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 3,
    world: 1,
    indexInWorld: 4,
    titulo: 'Operadores e expressões',
    descricao: 'Aritmética, comparação, lógica, ternário e interpolação.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'Aritméticos: +, -, *, /, ~/ (inteira), % (módulo).\n'
            'Comparação: ==, !=, >, <, >=, <=.\n'
            'Lógicos: &&, ||, !.\n'
            'Ternário: condicao ? a : b.\n'
            "Interpolação: 'Olá, \$nome' e '\${expr}'.",
      ),
      ContentBlock(
        style: 'tip',
        body: 'Erro comum: confundir / com ~/ — o segundo descarta decimais.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 4,
    world: 1,
    indexInWorld: 5,
    titulo: 'Exercício: operadores',
    descricao: 'B + C + A conforme o plano.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual é o resultado de <code>10 % 3</code> em Dart?',
        options: const ['3', '3.33', '1', '0'],
        singleCorrectIndex: 2,
        explanation: '% retorna o resto da divisão inteira: 10 ÷ 3 resto 1.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre operadores em Dart, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          '<code>~/</code> faz divisão inteira',
          '<code>&&</code> exige ambas verdadeiras',
          '<code>||</code> exige ambas verdadeiras',
          '<code>!</code> inverte bool',
        ],
        singleIncorrectIndex: 2,
        explanation: '<code>||</code> é OU — basta uma verdadeira.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre interpolação e operadores são verdadeiras?',
        options: const [
          "'Olá, \$nome' insere o valor de nome",
          "'\${nome.toUpperCase()}' deixa o nome em maiúsculas",
          '<code>10 ~/ 3</code> retorna 3.33',
          '<code>x > 0 ? x : 0</code> é válido em Dart',
        ],
        correctIndices: const {0, 1, 3},
        explanation: '~/ retorna 3, não 3.33.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 5,
    world: 1,
    indexInWorld: 6,
    titulo: 'Condicionais: if e switch',
    descricao: 'Controlar fluxo com if/else e switch.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'code',
        body: 'int nota = 75;\n\n'
            "if (nota >= 90) {\n  print('A');\n} else if (nota >= 70) {\n  print('B');\n} else {\n  print('C');\n}",
      ),
      ContentBlock(
        style: 'text',
        body: 'Use switch quando comparar um valor contra várias constantes conhecidas.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 6,
    world: 1,
    indexInWorld: 7,
    titulo: 'Exercício: lógica condicional',
    descricao: 'C + A + B.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre condicionais em Dart, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'O <code>else</code> é opcional em um if',
          '<code>switch</code> pode comparar String',
          'Um <code>if</code> sem <code>else</code> causa erro de compilação',
          'O ternário é um if/else compacto',
        ],
        singleIncorrectIndex: 2,
        explanation: 'if sem else é válido; só não executa o bloco se falso.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt:
            'Dado <code>int nota = 70;</code> e if/else if (>=90 A, >=70 B, senão C), quais afirmações são verdadeiras?',
        options: const [
          "O código imprime 'B'",
          "O código imprime 'C'",
          'A condição nota >= 70 é verdadeira para nota = 70',
          'O bloco else é executado',
        ],
        correctIndices: const {0, 2},
        explanation: '70 >= 70 entra no else if e imprime B.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt:
            'Qual estrutura é mais adequada para comparar <code>String diaSemana</code> contra 7 valores fixos?',
        options: const [
          'if com && para cada dia',
          'switch com um case por dia',
          'ternários aninhados',
          'while com parada',
        ],
        singleCorrectIndex: 1,
        explanation: 'switch é legível para muitos valores fixos.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 7,
    world: 1,
    indexInWorld: 8,
    titulo: 'Laços: for, while e do-while',
    descricao: 'Repetir ações e usar break/continue.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'code',
        body: 'for (int i = 0; i < 5; i++) {\n  print(i);\n}\n\n'
            "List<String> frutas = ['maçã', 'banana', 'laranja'];\n"
            'for (var fruta in frutas) {\n  print(fruta);\n}',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 8,
    world: 1,
    indexInWorld: 9,
    titulo: 'Coleções: List, Set e Map',
    descricao: 'Armazenar e acessar múltiplos valores.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'code',
        body: 'List<int> numeros = [1, 2, 3];\n'
            "Set<String> tags = {'dart', 'flutter', 'dart'}; // 2 elementos\n"
            "Map<String, int> idades = {'Ana': 25, 'Pedro': 30};\n\n"
            "print(idades['Ana']); // 25",
      ),
      ContentBlock(
        style: 'tip',
        body: 'Set não mantém duplicatas; List mantém ordem e índice 0..',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 9,
    world: 1,
    indexInWorld: 10,
    titulo: 'Exercício: laços e coleções',
    descricao: 'A + C + B + A.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre laços em Dart são verdadeiras?',
        options: const [
          '<code>while</code> verifica a condição antes do bloco',
          '<code>do-while</code> verifica antes da primeira execução',
          '<code>break</code> encerra o laço',
          '<code>continue</code> pula para a próxima iteração',
        ],
        correctIndices: const {0, 2, 3},
        explanation: 'do-while executa pelo menos uma vez antes de checar.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre coleções, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'List mantém ordem de inserção',
          'Set permite duplicatas',
          'Map guarda chave-valor',
          'Set tem contains()',
        ],
        singleIncorrectIndex: 1,
        explanation: 'Set garante unicidade.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: "Qual o resultado de print(idades['Ana']) no mapa {'Ana':25,'Pedro':30}?",
        options: const ["'Ana'", 'null', '25', 'Erro de compilação'],
        singleCorrectIndex: 2,
        explanation: 'A chave Ana mapeia para 25.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre List em Dart são verdadeiras?',
        options: const [
          'Índices começam em 0',
          'length retorna a quantidade',
          'add() remove um elemento',
          'for-in pode iterar uma List',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'add() adiciona; remove/removeAt removem.',
      ),
    ],
  ),

  PhaseData(
    globalIndex: 10,
    world: 2,
    indexInWorld: 1,
    titulo: 'O que é Flutter e como funciona',
    descricao: 'Motor de renderização, Dart e estrutura do projeto.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'Flutter compila para nativo; desenha pixels com Skia/Impeller.\n'
            'Um código: mobile, web, desktop.\n'
            'main.dart inicia com main() → runApp(raiz).\n'
            'pubspec.yaml declara dependências.\n\n'
            'Analogia: a widget tree é uma árvore — cada widget pode ter filhos.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 11,
    world: 2,
    indexInWorld: 2,
    titulo: 'Tudo é widget: Stateless vs Stateful',
    descricao: 'Text, Icon, Container e o papel do build().',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'code',
        body: 'class MeuTexto extends StatelessWidget {\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            "    return Text('Olá, Flutter!');\n"
            '  }\n'
            '}',
      ),
      ContentBlock(
        style: 'text',
        body:
            'StatelessWidget: imutável após construir. StatefulWidget + setState(): UI pode mudar.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 12,
    world: 2,
    indexInWorld: 3,
    titulo: 'Exercício: estrutura do app',
    descricao: 'B + A + C.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual é a função de <code>runApp()</code>?',
        options: const [
          'Compilar Dart para nativo',
          'Inflar o widget raiz e ligar ao motor de renderização',
          'Criar o pubspec.yaml',
          'Inicializar banco local',
        ],
        singleCorrectIndex: 1,
        explanation: 'runApp conecta o widget raiz ao Flutter.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre StatelessWidget e StatefulWidget são verdadeiras?',
        options: const [
          'StatelessWidget não tem estado mutável interno típico',
          'StatefulWidget pode chamar setState() no State',
          'StatelessWidget pode chamar setState()',
          'build() é obrigatório nos dois',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'setState pertence ao State do StatefulWidget.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre a estrutura básica do app Flutter, qual está <strong>incorreta</strong>?',
        options: const [
          'Precisamos de main() como entrada',
          'Scaffold funciona bem sem MaterialApp acima',
          'Dependências ficam no pubspec.yaml',
          'lib/main.dart é o arquivo principal típico',
        ],
        singleIncorrectIndex: 1,
        explanation: 'Scaffold espera MaterialApp para tema, direção de texto, etc.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 13,
    world: 2,
    indexInWorld: 4,
    titulo: 'Widget tree e build()',
    descricao: 'Rebuild, BuildContext, MaterialApp e Scaffold.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body: 'MaterialApp\n└── Scaffold\n    ├── AppBar\n    └── body → Center / Column …',
      ),
      ContentBlock(
        style: 'tip',
        body: 'setState reconstrói o subtree afetado, não necessariamente o app inteiro.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 14,
    world: 2,
    indexInWorld: 5,
    titulo: 'Exercício: tree e BuildContext',
    descricao: 'C + B + A.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre widget tree e build(), qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'A árvore é hierárquica',
          'setState reconstrói sempre o app inteiro do zero',
          'build() é chamado quando o Flutter precisa renderizar',
          'MaterialApp costuma ficar no topo',
        ],
        singleIncorrectIndex: 1,
        explanation: 'Rebuild é localizado ao subtree.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'O que representa o BuildContext em build()?',
        options: const [
          'O estado interno mutável',
          'A posição do widget na árvore',
          'O arquivo de tema',
          'A lista de filhos do Scaffold',
        ],
        singleCorrectIndex: 1,
        explanation: 'Context localiza o widget na árvore e acessa ancestrais.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre MaterialApp e Scaffold são verdadeiras?',
        options: const [
          'MaterialApp costuma ficar no topo',
          'Scaffold dá AppBar, body, FAB…',
          'São intercambiáveis como raiz',
          'Vários Scaffolds podem existir em telas diferentes',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'Papéis diferentes: MaterialApp global, Scaffold por tela.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 15,
    world: 2,
    indexInWorld: 6,
    titulo: 'Layouts: Column, Row e Container',
    descricao: 'Eixos, alinhamento, SizedBox e Spacer.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'code',
        body: 'Row(\n'
            '  mainAxisAlignment: MainAxisAlignment.spaceBetween,\n'
            '  children: [\n'
            "    Text('Preço'),\n"
            "    Text(r'R\$ 49,90', style: TextStyle(fontWeight: FontWeight.bold)),\n"
            '  ],\n'
            ')',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 16,
    world: 2,
    indexInWorld: 7,
    titulo: 'Exercício: Column, Row e Container',
    descricao: 'A + C + B.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre Column e Row são verdadeiras?',
        options: const [
          'Column empilha na vertical',
          'Row organiza na horizontal',
          'Em Column, mainAxisAlignment controla o eixo horizontal',
          'SizedBox pode espaçar filhos na Column',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'Em Column o main axis é vertical.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre Container, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'Pode ter color de fundo',
          'Aceita padding e margin',
          'Só pode ter um child',
          'Nunca aceita width e height',
        ],
        singleIncorrectIndex: 3,
        explanation: 'Container aceita width e height explícitos.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual widget empurra dois filhos para extremidades opostas num Row?',
        options: const ['Padding', 'Center', 'Spacer', 'Align'],
        singleCorrectIndex: 2,
        explanation: 'Spacer ocupa o espaço flexível entre os lados.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 17,
    world: 2,
    indexInWorld: 8,
    titulo: 'Stack, Expanded e Flexible',
    descricao: 'Camadas, flex em Row/Column.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'code',
        body: 'Stack(\n'
            '  children: [\n'
            '    Image.network(\'https://...\'),\n'
            '    Positioned(\n'
            '      bottom: 8, left: 8,\n'
            "      child: Text('Legenda', style: TextStyle(color: Colors.white)),\n"
            '    ),\n'
            '  ],\n'
            ')',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 18,
    world: 2,
    indexInWorld: 9,
    titulo: 'Navegação: Navigator e rotas',
    descricao: 'Pilha de rotas, push, pop e rotas nomeadas.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'code',
        body: 'Navigator.push(\n'
            '  context,\n'
            '  MaterialPageRoute(builder: (context) => DetalhesScreen(id: 1)),\n'
            ');\n\n'
            'Navigator.pop(context);',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 19,
    world: 2,
    indexInWorld: 10,
    titulo: 'Exercício: Stack, Expanded e navegação',
    descricao: 'B + A + C + B.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual o papel de <code>Positioned</code> dentro de um <code>Stack</code>?',
        options: const [
          'Centralizar todos os filhos',
          'Definir posição absoluta de um filho',
          'Substituir o Stack com um filho',
          'Adicionar padding ao Stack',
        ],
        singleCorrectIndex: 1,
        explanation: 'Positioned usa top/bottom/left/right no Stack.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre Expanded e Flexible são verdadeiras?',
        options: const [
          'Expanded é filho direto de Row/Column/Flex',
          'Expanded força o filho a preencher o espaço restante',
          'Flexible e Expanded são sempre idênticos',
          'Flexible pode deixar o filho menor que o espaço',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'Expanded ≈ Flexible com fit tight.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre Navigator, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'push adiciona no topo da pilha',
          'pop remove a tela atual',
          'Passar dados exige pushNamed',
          'popUntil pode esvaziar até uma condição',
        ],
        singleIncorrectIndex: 2,
        explanation: 'Dados podem ir pelo construtor da rota.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt:
            'Home → Lista → Detalhe: em Detalhe, voltar direto para Home. O que é mais adequado?',
        options: const [
          'Navigator.pop(context)',
          'Navigator.push(...)',
          'Navigator.popUntil(context, (route) => route.isFirst)',
          'pushReplacement',
        ],
        singleCorrectIndex: 2,
        explanation: 'popUntil com isFirst derruba até a primeira rota.',
      ),
    ],
  ),
];
