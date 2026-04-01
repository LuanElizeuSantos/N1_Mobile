import '../models/curriculum.dart';

List<PhaseData> get allPhases => _phases;

final List<PhaseData> _phases = [
  PhaseData(
    globalIndex: 0,
    world: 1,
    indexInWorld: 1,
    titulo: 'Tipos, variáveis e primeiras saídas',
    descricao:
        'main(), tipos básicos, var e anotação, final/const, null safety leve, print.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'O Dart começa a executar em uma função chamada <code>main</code>. '
            'Esse é o ponto de entrada do programa: sem ela, o arquivo não sobe '
            'como app de console nem como alvo do Flutter.\n\n'
            'Quando você roda o arquivo, o runtime avalia <code>main</code> '
            'e executa o corpo em ordem. O que vier depois depende só do que '
            'você chamou dentro de <code>main</code>.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<strong>Tipos que você usa o tempo todo:</strong> '
            '<code>int</code> (inteiros), <code>double</code> (ponto flutuante), '
            '<code>String</code> (texto entre aspas simples ou duplas), '
            '<code>bool</code> (<code>true</code> ou <code>false</code>).\n\n'
            'Anotar o tipo deixa explícito o que a variável pode guardar. '
            'O analisador estático usa isso para avisar erro antes de rodar: '
            'por exemplo, não dá para guardar texto num <code>int</code>.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>var</code> pede ao compilador que infira o tipo a partir do '
            'valor inicial. Serve quando o tipo óbvio deixa o código legível.\n\n'
            'Anote o tipo (<code>String nome</code>) quando a inferência não '
            'ajuda quem lê o código ou quando você quer um contrato explícito '
            'na API de uma função.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>final</code> significa: uma vez atribuído em tempo de '
            'execução, não reatribuir. <code>const</code> significa: valor '
            'fixo já conhecido em <em>tempo de compilação</em>.\n\n'
            '<strong>Erro comum:</strong> tratar <code>final</code> e '
            '<code>const</code> como sinônimos. <code>DateTime.now()</code> '
            'pode ir em <code>final</code>, não em <code>const</code>, porque '
            'o relógio só existe em runtime.\n\n'
            'Lista literal <code>const [1, 2]</code> é imutável na prática de '
            'uso comum; lista criada com <code>[1, 2]</code> sem const permite '
            '<code>add</code> se o tipo for mutável.',
      ),
      ContentBlock(
        style: 'code',
        body: 'void main() {\n'
            '  final agora = DateTime.now();\n'
            '  const taxa = 0.13;\n'
            "  var contador = 0;\n"
            '  contador = contador + 1;\n'
            "  print(agora);\n"
            '  print(taxa);\n'
            '}',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<strong>Null safety (introdução):</strong> <code>int?</code> '
            'admite <code>null</code>; <code>int</code> não. O operador '
            '<code>?</code> no tipo marca opcionalidade.\n\n'
            '<strong>Erro comum:</strong> espalhar <code>!</code> só para '
            'calar o analisador. Só use quando a lógica já garantiu que o '
            'valor não é null (teste, early return, ou padrão com <code>??</code>).',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>print</code> manda texto para o console. Interpolação: '
            "<code>'Olá, \$nome'</code> ou <code>'Total: \${a + b}'</code>.\n\n"
            '<strong>Regra:</strong> se a expressão dentro de '
            '<code>\${...}</code> ficar grande, guarde em um <code>final</code> '
            'intermediário e imprima a variável. Legibilidade vale mais que '
            'uma linha “compacta”.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 1,
    world: 1,
    indexInWorld: 2,
    titulo: 'Exercício: tipos e variáveis',
    descricao: 'Tipos, nullability e final/const.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt:
            'Quais das afirmações abaixo sobre tipos em Dart são verdadeiras?',
        options: const [
          '<code>double</code> é adequado para <code>3.14</code>',
          '<code>int</code> pode armazenar <code>"vinte"</code>',
          '<code>bool</code> só aceita <code>true</code> ou <code>false</code>',
          'Uma variável <code>int?</code> pode receber <code>null</code>',
        ],
        correctIndices: const {0, 2, 3},
        explanation:
            'Texto entre aspas é String. Nullable com ? inclui null.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual declaração é válida em Dart?',
        options: const [
          '<code>int preco = 49.90;</code>',
          '<code>String ativo = true;</code>',
          '<code>double altura = 1.75;</code>',
          "<code>bool nome = 'João';</code>",
        ],
        singleCorrectIndex: 2,
        explanation: 'Tipo e literal precisam combinar.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt:
            'Sobre <code>var</code>, <code>final</code> e <code>const</code>, '
            'qual afirmação está <strong>incorreta</strong>?',
        options: const [
          '<code>var</code> infere o tipo pelo valor inicial',
          '<code>final</code> permite mudar o valor depois da primeira atribuição',
          '<code>const</code> exige valor conhecido em compile time',
          '<code>final</code> não pode ser reatribuído',
        ],
        singleIncorrectIndex: 1,
        explanation: 'final amarra a referência após a primeira atribuição.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 2,
    world: 1,
    indexInWorld: 3,
    titulo: 'Operadores e expressões',
    descricao: 'Aritmética, comparação, lógica e ternário.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'Operadores aritméticos: <code>+</code>, <code>-</code>, '
            '<code>*</code>, <code>/</code> (resultado double se algum operando '
            'for double), <code>~/</code> (divisão inteira descartando resto), '
            '<code>%</code> (resto).\n\n'
            'Parênteses definem ordem de avaliação; use-os para deixar a '
            'intenção óbvia, não só para “passar no compilador”.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Comparação: <code>==</code>, <code>!=</code>, '
            '<code>&lt;</code>, <code>&gt;</code>, '
            '<code>&lt;=</code>, <code>&gt;=</code>. '
            'Para <code>String</code>, <code>==</code> compara conteúdo, '
            'não identidade de objeto — o que importa no dia a dia.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Lógicos: <code>&&</code> (e), <code>||</code> (ou), '
            '<code>!</code> (não). Com curto-circuito: em <code>a && b</code>, '
            'se <code>a</code> for falso, <code>b</code> nem é avaliado; '
            'em <code>a || b</code>, se <code>a</code> for verdadeiro, '
            '<code>b</code> é ignorado.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Ternário: <code>condicao ? valorSeVerdade : valorSeFalso</code>. '
            'Útil para escolher entre dois valores em uma expressão.\n\n'
            '<strong>Quando evitar:</strong> encadear vários ternários. '
            'Nesse caso, prefira <code>if</code>/<code>else</code> com nomes '
            'de variáveis claros.',
      ),
      ContentBlock(
        style: 'code',
        body: 'void main() {\n'
            '  final a = 10;\n'
            '  final b = 3;\n'
            '  print(a ~/ b); // 3 divisão inteira\n'
            '  print(a % b);  // 1 resto\n'
            '  print(a > 0 && b > 0); // true\n'
            "  final msg = a > 5 ? 'maior' : 'menor ou igual';\n"
            '  print(msg);\n'
            '}',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 3,
    world: 1,
    indexInWorld: 4,
    titulo: 'Exercício: operadores',
    descricao: 'Módulo, lógicos e ternário.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre operadores em Dart são verdadeiras?',
        options: const [
          '<code>~/</code> descarta a parte fracionária da divisão inteira',
          '<code>||</code> exige que os dois lados sejam verdadeiros',
          '<code>!</code> inverte um bool',
          '<code>x > 0 ? x : 0</code> retorna x se x for positivo, senão 0',
        ],
        correctIndices: const {0, 2, 3},
        explanation: '|| é OU: basta um lado verdadeiro.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual é o resultado de <code>10 % 3</code>?',
        options: const ['3', '1', '0', '3.33'],
        singleCorrectIndex: 1,
        explanation: '% devolve o resto da divisão inteira.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre expressões, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          '<code>10 / 3</code> em inteiros produz double em Dart',
          '<code>&&</code> para se ambos forem verdadeiros',
          'Interpolação com cifrão e chaves avalia a expressão dentro da String',
          '<code>~/</code> sempre retorna double',
        ],
        singleIncorrectIndex: 3,
        explanation: '~/ retorna int quando os operandos são int.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 4,
    world: 1,
    indexInWorld: 5,
    titulo: 'Fluxo, repetição e coleções',
    descricao: 'if, switch, laços, break/continue, List, Set e Map.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            '<code>if</code>, <code>else if</code> e <code>else</code> escolhem '
            'blocos por condição booleana. Variáveis declaradas dentro de um '
            'bloco só existem ali — escopo de bloco vale para código novo e '
            'para refatoração segura.',
      ),
      ContentBlock(
        style: 'code',
        body: 'void exemploNota(int nota) {\n'
            "  if (nota >= 90) {\n    print('A');\n"
            "  } else if (nota >= 70) {\n    print('B');\n"
            "  } else {\n    print('C');\n  }\n"
            '}',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>switch</code> compara um valor contra casos constantes. '
            'Use quando vários desvios dependem do mesmo valor e os casos são '
            'fixos; cadeias longas de <code>if</code> repetindo a mesma '
            'variável costumam ficar piores de ler.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<strong>Laços:</strong> <code>for</code> com contador; '
            '<code>while</code> testa a condição antes de cada iteração; '
            '<code>do-while</code> executa o corpo pelo menos uma vez e só '
            'depois pergunta se continua.\n\n'
            '<code>for-in</code> percorre elementos de algo iterável — no '
            'próximo bloco, isso liga direto a <code>List</code>.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>break</code> sai do laço ou do <code>switch</code> mais '
            'interno que o contém. <code>continue</code> pula para a próxima '
            'iteração do laço.\n\n'
            '<strong>Erro comum:</strong> em laço com <code>switch</code> '
            'dentro, confundir qual construto o <code>break</code> encerra — '
            'no Dart, <code>break</code> no <code>switch</code> não sai do '
            '<code>for</code> externo.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>List</code> ordena por índice (0 .. length-1). '
            '<code>Set</code> não guarda duplicata; iteração tem ordem '
            'definida em versões recentes do Dart, mas não trate Set como '
            'substituto de lista ordenada por posição.\n\n'
            '<code>Map</code> associa chave a valor; acesso '
            '<code>map[chave]</code> devolve nullable se a chave pode faltar.\n\n'
            '<strong>Erro comum:</strong> assumir que <code>Set</code> se '
            'comporta como <code>List</code> com os mesmos índices.',
      ),
      ContentBlock(
        style: 'code',
        body: 'void main() {\n'
            "  final nomes = ['Ana', 'Beto', 'Ana'];\n"
            '  for (final n in nomes) {\n'
            "    if (n == 'Beto') continue;\n"
            '    print(n);\n'
            '  }\n'
            "  final unicos = nomes.toSet();\n"
            '  print(unicos.length); // 2\n'
            "  final idadePorNome = {'Ana': 30, 'Beto': 25};\n"
            "  print(idadePorNome['Ana']);\n"
            '}',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 5,
    world: 1,
    indexInWorld: 6,
    titulo: 'Exercício: fluxo e coleções',
    descricao: 'Condicionais, laços e estruturas de dados.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre laços são verdadeiras?',
        options: const [
          '<code>while</code> pode não executar o corpo nenhuma vez',
          '<code>do-while</code> executa o corpo pelo menos uma vez',
          '<code>break</code> interrompe o laço mais interno relevante',
          '<code>continue</code> encerra o programa',
        ],
        correctIndices: const {0, 1, 2},
        explanation: 'continue só pula para a próxima iteração.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt:
            'Dado <code>int nota = 70;</code> e if/else if (>=90 A, >=70 B, '
            'senão C), o que imprime?',
        options: const [
          'A',
          'B',
          'C',
          'Nada; erro de compilação',
        ],
        singleCorrectIndex: 1,
        explanation: '70 >= 70 aciona o ramo B.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre coleções, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'List indexa a partir de 0',
          'Set permite duplicatas',
          'Map guarda pares chave-valor',
          '<code>list.length</code> retorna quantidade de elementos',
        ],
        singleIncorrectIndex: 1,
        explanation: 'Set elimina duplicata.',
      ),
    ],
  ),

  PhaseData(
    globalIndex: 6,
    world: 2,
    indexInWorld: 1,
    titulo: 'Flutter, projeto e o primeiro widget',
    descricao: 'Motor, estrutura, runApp, Stateless e Stateful.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'Flutter desenha a interface no dispositivo a partir de uma '
            'descrição em Dart: uma árvore de widgets. O framework compara a '
            'árvore nova com a anterior e atualiza só o que mudou.\n\n'
            'Seu código não manipula pixels direto; ele declara widgets e '
            'parâmetros. O motor (Skia/Impeller) faz o desenho.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Pastas usuais: <code>lib/</code> com o código Dart; '
            '<code>pubspec.yaml</code> lista nome, versão do SDK e '
            'dependências. O arquivo de entrada costuma ser '
            '<code>lib/main.dart</code>.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>main()</code> roda primeiro. <code>runApp(widget)</code> '
            'liga o widget raiz ao binding do Flutter e inicia o frame de '
            'layout e pintura.\n\n'
            '<strong>Erro comum:</strong> chamar <code>runApp</code> várias '
            'vezes sem motivo (por exemplo dentro de <code>build</code>). '
            'A raiz deve ser definida na subida do app, não a cada reconstrução.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Widget é uma descrição de configuração: em geral imutável. '
            'Quando algo precisa mudar na tela, ou você troca o widget '
            '(novo pai com novos filhos) ou usa estado mutável no lugar certo '
            '(<code>StatefulWidget</code>).',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>StatelessWidget</code> implementa <code>build</code> e não '
            'guarda estado mutável típico de tela. Use quando tudo pode vir '
            'de parâmetros ou de ancestrais.\n\n'
            '<code>StatefulWidget</code> separa o objeto de configuração '
            'imutável do objeto <code>State</code>, onde ficam os campos que '
            'mudam. <code>setState(() { ... })</code> avisa o Flutter para '
            'chamar <code>build</code> de novo naquele subtree.\n\n'
            '<strong>Erro comum:</strong> chamar <code>setState</code> dentro '
            'do próprio <code>build</code> — gera loop ou assert.',
      ),
      ContentBlock(
        style: 'code',
        body: 'class Ola extends StatelessWidget {\n'
            '  const Ola({super.key});\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            "    return const Text('Olá');\n"
            '  }\n'
            '}\n\n'
            'class Contador extends StatefulWidget {\n'
            '  const Contador({super.key});\n'
            '  @override\n'
            '  State<Contador> createState() => _ContadorState();\n'
            '}\n\n'
            'class _ContadorState extends State<Contador> {\n'
            '  int n = 0;\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    return GestureDetector(\n'
            '      onTap: () => setState(() => n++),\n'
            "      child: Text('Toques: \$n'),\n"
            '    );\n'
            '  }\n'
            '}',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 7,
    world: 2,
    indexInWorld: 2,
    titulo: 'Exercício: estrutura do app',
    descricao: 'runApp, widgets e Material.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt:
            'Quais afirmações sobre StatelessWidget e StatefulWidget são '
            'verdadeiras?',
        options: const [
          'StatelessWidget não costuma guardar estado mutável de UI',
          'O State do StatefulWidget pode chamar setState',
          'StatelessWidget chama setState no próprio build',
          'Ambos implementam build',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'setState pertence ao State.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'O que <code>runApp</code> faz?',
        options: const [
          'Gera o pubspec.yaml',
          'Anexa o widget raiz ao binding e inicia o pipeline de frames',
          'Compila o projeto para release',
          'Abre o emulador',
        ],
        singleCorrectIndex: 1,
        explanation: 'runApp é o gancho entre main e o motor Flutter.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt:
            'Sobre a estrutura básica do app, qual afirmação está '
            '<strong>incorreta</strong>?',
        options: const [
          '<code>main</code> é o ponto de entrada',
          'Scaffold costuma funcionar bem sem MaterialApp acima',
          'Dependências ficam no pubspec.yaml',
          'O código Dart de produção fica em lib/',
        ],
        singleIncorrectIndex: 1,
        explanation: 'MaterialApp fornece tema, direcionalidade, rotas raiz…',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 8,
    world: 2,
    indexInWorld: 3,
    titulo: 'Árvore, Material e layout em linha/coluna',
    descricao: 'Context, MaterialApp, Scaffold, Row, Column, Container.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'Widgets formam uma árvore: cada nó tem um pai e filhos opcionais. '
            'A ordem dos filhos importa: é a ordem de pintura e de layout na '
            'maioria dos pais.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>BuildContext</code> identifica onde o widget está na árvore. '
            'APIs pedem <code>context</code> para achar ancestrais (tema, '
            'navegação, tamanho herdado). É um gancho operacional, não um '
            'conceito abstrato “extra”.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>MaterialApp</code> configura o app Material: tema, rotas, '
            'home. <code>Scaffold</code> dá estrutura de tela: '
            '<code>AppBar</code>, <code>body</code>, FAB, drawer.\n\n'
            '<strong>Erro comum:</strong> colocar <code>Scaffold</code> sem '
            '<code>MaterialApp</code> acima — perde-se tema consistente e '
            'comportamento esperado de Material.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>Row</code> alinha filhos no eixo horizontal; '
            '<code>Column</code> no vertical. '
            '<code>mainAxisAlignment</code> distribui ao longo do eixo '
            'principal; <code>crossAxisAlignment</code> no eixo perpendicular.\n\n'
            'Em <code>Column</code>, o eixo principal é vertical — não confunda '
            'com alinhamento “horizontal” do main.',
      ),
      ContentBlock(
        style: 'code',
        body: 'Scaffold(\n'
            "  appBar: AppBar(title: const Text('Titulo')),\n"
            '  body: Column(\n'
            '    mainAxisAlignment: MainAxisAlignment.center,\n'
            '    children: const [\n'
            "      Text('Linha 1'),\n"
            "      SizedBox(height: 12),\n"
            "      Text('Linha 2'),\n"
            '    ],\n'
            '  ),\n'
            ')',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>Container</code> combina cor, padding, margem e tamanho em '
            'um só widget. <code>SizedBox</code> fixa largura/altura ou só '
            'espaço em branco — útil para afastar filhos sem pintar fundo.\n\n'
            '<code>Expanded</code> (filho de <code>Row</code>/<code>Column</code>) '
            'aparece com detalhe na próxima fase de conteúdo; aqui basta '
            'saber que ele divide o espaço flexível que sobrou no pai.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 9,
    world: 2,
    indexInWorld: 4,
    titulo: 'Exercício: árvore e layout básico',
    descricao: 'Context, MaterialApp/Scaffold, Row e Column.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt:
            'Quais afirmações sobre MaterialApp, Scaffold e layout são '
            'verdadeiras?',
        options: const [
          'MaterialApp costuma envolver o app inteiro',
          'Scaffold oferece AppBar e body',
          'Row e Column são intercambiáveis no mesmo problema sem mudar eixo',
          'Vários Scaffolds podem existir em telas diferentes',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'Row é horizontal; Column é vertical.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'O que o BuildContext representa em build()?',
        options: const [
          'O estado mutável global do app',
          'A localização do widget na árvore',
          'Somente o tema de cores',
          'A lista de dependências do pubspec',
        ],
        singleCorrectIndex: 1,
        explanation: 'Context liga o nó atual ao restante da árvore.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt:
            'Sobre Column e Row, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'Em Column, mainAxisAlignment age no eixo vertical',
          'SizedBox pode espaçar filhos',
          'Em Column, mainAxisAlignment controla o eixo horizontal principal',
          'Row organiza filhos na horizontal',
        ],
        singleIncorrectIndex: 2,
        explanation: 'Em Column o main axis é vertical.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 10,
    world: 2,
    indexInWorld: 5,
    titulo: 'Pilha, flex e navegação entre telas',
    descricao: 'Stack, Expanded/Flexible, Navigator e rotas.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            '<code>Stack</code> sobrepõe filhos. O primeiro desenhado fica '
            'atrás; os seguintes cobrem por cima. <code>Positioned</code> '
            'ancora um filho com top/bottom/left/right dentro do Stack.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>Expanded</code> e <code>Flexible</code> só fazem sentido '
            'como filhos de <code>Row</code>, <code>Column</code> ou '
            '<code>Flex</code>. <code>Expanded</code> força o filho a ocupar '
            'o espaço restante no eixo. <code>Flexible</code> com '
            '<code>FlexFit.loose</code> permite o filho ser menor que o '
            'espaço oferecido.\n\n'
            'Se a linha “estoura” sem overflow visível, muitas vezes falta '
            'flex ou o filho precisa poder encolher (Text com overflow, etc.).',
      ),
      ContentBlock(
        style: 'code',
        body: 'Navigator.push(\n'
            '  context,\n'
            '  MaterialPageRoute<void>(\n'
            '    builder: (context) => const DetalhePage(),\n'
            '  ),\n'
            ');\n\n'
            'Navigator.pop(context);',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<code>Navigator</code> mantém uma pilha de rotas. '
            '<code>push</code> empilha uma nova tela; <code>pop</code> remove '
            'a do topo. <code>MaterialPageRoute</code> é a forma imperativa '
            'mais direta de criar uma rota com transição Material.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Você pode aguardar um valor de retorno: '
            'Com <code>await Navigator.push</code> você pode esperar o '
            'resultado. Na outra tela, <code>Navigator.pop(context, \'ok\')</code> '
            'devolve esse valor ao chamador.\n\n'
            '<strong>Erro comum:</strong> esquecer que <code>pop</code> pode '
            'devolver dado — útil para formulários e seleção.\n\n'
            'Rotas nomeadas e pacotes como <code>go_router</code> existem para '
            'apps maiores; aqui o imperativo já basta para entender a pilha.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 11,
    world: 2,
    indexInWorld: 6,
    titulo: 'Exercício: stack, flex e navegação',
    descricao: 'Stack, Expanded/Flexible e Navigator.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt:
            'Quais afirmações sobre Expanded, Flexible e Stack são verdadeiras?',
        options: const [
          'Expanded é filho válido de Row ou Column',
          'Flexible pode permitir filho menor que o espaço oferecido',
          'Expanded e Flexible são sempre idênticos em comportamento',
          'Positioned posiciona um filho dentro de Stack',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'Expanded força preenchimento; Flexible nem sempre.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt: 'Qual o papel de Positioned dentro de um Stack?',
        options: const [
          'Centralizar todos os filhos igualmente',
          'Ancorar um filho com offsets em relação ao Stack',
          'Substituir o Stack por um único filho',
          'Adicionar padding ao MaterialApp',
        ],
        singleCorrectIndex: 1,
        explanation: 'Positioned usa top/bottom/left/right.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt: 'Sobre Navigator, qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'push adiciona uma rota no topo da pilha',
          'pop remove a rota atual',
          'Só é possível passar dados com pushNamed',
          'pop pode devolver um valor ao chamador',
        ],
        singleIncorrectIndex: 2,
        explanation: 'Construtor da página e genéricos em push bastam.',
      ),
    ],
  ),

  PhaseData(
    globalIndex: 12,
    world: 3,
    indexInWorld: 1,
    titulo: 'O que é Firebase e o que entra no app',
    descricao: 'BaaS, projeto no console e visão dos serviços usados com Flutter.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'Firebase é um conjunto de serviços de backend hospedados pela Google. '
            'O app Flutter continua em Dart; o que muda é que parte dos dados, '
            'usuários e filas passa a viver na nuvem em vez de só no dispositivo.\n\n'
            'Você cria um <strong>projeto</strong> no Firebase Console, registra '
            'o app (Android/iOS/Web) e baixa arquivos de configuração. O SDK '
            'Flutter usa esses arquivos para saber a qual projeto se conectar.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<strong>Serviços que aparecem com frequência:</strong> '
            '<code>Authentication</code> (login), '
            '<code>Cloud Firestore</code> ou <code>Realtime Database</code> '
            '(dados em tempo real), <code>Cloud Storage</code> (arquivos), '
            '<code>Cloud Messaging</code> (push). Não é obrigativo usar todos; '
            'cada app liga só o que precisa.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<strong>Erro comum:</strong> achar que Firebase substitui o código '
            'de UI. Ele não desenha telas; responde por identidade, persistência '
            'e regras no servidor. A tela continua sendo Flutter.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 13,
    world: 3,
    indexInWorld: 2,
    titulo: 'Firestore e Authentication em conceito',
    descricao: 'Modelo de dados, consultas e fluxo de login.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'No <strong>Cloud Firestore</strong> os dados ficam em '
            '<strong>coleções</strong> de <strong>documentos</strong>. Cada '
            'documento é um mapa chave-valor; subcoleções podem ficar dentro de '
            'documentos. Caminhos como <code>users/uid123/profile</code> são '
            'comuns.',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Consultas usam filtros (<code>where</code>), ordenação e limite. '
            'Índices compostos podem ser exigidos quando você combina vários '
            '<code>where</code> ou <code>orderBy</code>; o console avisa o link '
            'para criar o índice.',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<strong>Regras de segurança</strong> definem quem pode ler ou '
            'escrever. Em desenvolvimento é fácil abrir tudo; em produção as '
            'regras devem exigir usuário autenticado e limitar caminhos '
            '(por exemplo, só o dono do <code>uid</code> escreve em '
            '<code>users/{uid}</code>).',
      ),
      ContentBlock(
        style: 'text',
        body:
            '<strong>Authentication</strong> oferece provedores (e-mail/senha, '
            'Google, anônimo, etc.). O fluxo típico: usuário autentica, você obtém '
            'um <code>User</code> com <code>uid</code> e usa esse id como '
            'chave em documentos do Firestore.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 14,
    world: 3,
    indexInWorld: 3,
    titulo: 'Firebase no Flutter: pacotes e inicialização',
    descricao: 'flutterfire_cli, Firebase.initializeApp e uso básico de Auth/Firestore.',
    kind: PhaseKind.conteudo,
    contentBlocks: const [
      ContentBlock(
        style: 'text',
        body:
            'No Flutter os pacotes oficiais costumam ser <code>firebase_core</code> '
            '(obrigatório), mais <code>cloud_firestore</code>, '
            '<code>firebase_auth</code>, etc., conforme o recurso. '
            'A CLI <code>flutterfire configure</code> gera '
            '<code>lib/firebase_options.dart</code> com as chaves do projeto.',
      ),
      ContentBlock(
        style: 'code',
        body: 'import ' 'package:firebase_core/firebase_core.dart;\n'
            "import 'firebase_options.dart';\n\n"
            'Future<void> main() async {\n'
            '  WidgetsFlutterBinding.ensureInitialized();\n'
            '  await Firebase.initializeApp(\n'
            '    options: DefaultFirebaseOptions.currentPlatform,\n'
            '  );\n'
            '  runApp(const MyApp());\n'
            '}',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Sem <code>WidgetsFlutterBinding.ensureInitialized()</code> e '
            '<code>await Firebase.initializeApp</code> antes de '
            '<code>runApp</code>, chamadas aos outros plugins Firebase podem '
            'falhar ou disparar assert.\n\n'
            '<strong>Erro comum:</strong> chamar Auth/Firestore em '
            '<code>main()</code> síncrono sem esperar o '
            '<code>initializeApp</code> terminar.',
      ),
      ContentBlock(
        style: 'code',
        body: "import 'package:cloud_firestore/cloud_firestore.dart';\n\n"
            'Future<void> salvarNome(String uid, String nome) async {\n'
            "  await FirebaseFirestore.instance\n"
            "      .collection('users')\n"
            '      .doc(uid)\n'
            "      .set({'displayName': nome}, SetOptions(merge: true));\n"
            '}',
      ),
      ContentBlock(
        style: 'text',
        body:
            'Para login com e-mail/senha você usaria '
            '<code>FirebaseAuth.instance.createUserWithEmailAndPassword</code> '
            'ou <code>signInWithEmailAndPassword</code>, tratando exceções '
            '(senha fraca, e-mail já usado, credenciais inválidas). '
            'O detalhe de cada API fica na documentação; aqui o padrão é: '
            'inicializar o app uma vez, depois usar instâncias singleton dos '
            'plugins.',
      ),
    ],
  ),
  PhaseData(
    globalIndex: 15,
    world: 3,
    indexInWorld: 4,
    titulo: 'Exercício: Firebase e Flutter',
    descricao: 'Seis questões sobre conceitos e integração.',
    kind: PhaseKind.exercicio,
    activities: [
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais afirmações sobre Firebase são verdadeiras?',
        options: const [
          'Firebase oferece serviços de backend na nuvem',
          'O Flutter deixa de ser Dart quando você usa Firebase',
          'É comum registrar o app no Firebase Console com id de pacote',
          'Authentication pode fornecer um uid para associar dados',
        ],
        correctIndices: const {0, 2, 3},
        explanation: 'O app continua em Dart/Flutter; Firebase é backend.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt:
            'No Firestore, qual estrutura descreve melhor um caminho como '
            '<code>users/abc123/settings</code>?',
        options: const [
          'Coleção users, documento abc123, subcoleção settings',
          'Um único documento com id users',
          'Três coleções independentes sem hierarquia',
          'Apenas um campo chamado users',
        ],
        singleCorrectIndex: 0,
        explanation: 'Documento abc123 dentro da coleção users; settings costuma ser subcoleção ou mapa no doc.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt:
            'Sobre regras de segurança do Firestore em produção, qual afirmação '
            'está <strong>incorreta</strong>?',
        options: const [
          'Regras podem exigir request.auth != null',
          'É prudente limitar escrita ao dono do documento',
          'Abrir leitura e escrita para qualquer um é recomendado em produção',
          'Regras são avaliadas no servidor a cada requisição',
        ],
        singleIncorrectIndex: 2,
        explanation: 'Produção exige regras restritivas; teste aberto só em dev controlado.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.multiplasVerdadeiras,
        prompt: 'Quais itens costumam fazer parte da integração Firebase + Flutter?',
        options: const [
          'Pacote firebase_core',
          'Arquivo firebase_options.dart gerado pelo FlutterFire',
          'Chamar runApp antes de qualquer plugin nativo',
          'firebase_auth ou cloud_firestore conforme o recurso',
        ],
        correctIndices: const {0, 1, 3},
        explanation: 'initializeApp antes de runApp; runApp antes dos plugins quebra a ordem correta.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueCorreta,
        prompt:
            'Com Firebase, após <code>WidgetsFlutterBinding.ensureInitialized()</code>, '
            'o que costuma vir antes de <code>runApp</code>?',
        options: const [
          'Apenas runApp, sem await',
          'await Firebase.initializeApp(...)',
          'Navigator.push',
          'setState no primeiro frame',
        ],
        singleCorrectIndex: 1,
        explanation: 'Inicializa o Firebase antes de subir o widget raiz.',
      ),
      ExerciseActivity(
        kind: ExerciseKind.marqueIncorreta,
        prompt:
            'Sobre <code>FirebaseFirestore.instance.collection(\'x\').doc(\'y\')</code>, '
            'qual afirmação está <strong>incorreta</strong>?',
        options: const [
          'doc identifica um documento dentro da coleção x',
          'set com merge true pode atualizar campos sem apagar os outros',
          'instance aponta para o projeto após initializeApp',
          'collection e doc só funcionam com internet desligada e sem cache',
        ],
        singleIncorrectIndex: 3,
        explanation: 'Firestore tem persistência offline opcional; não é “só offline” nem exige offline.',
      ),
    ],
  ),
];
