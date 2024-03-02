import 'package:flutter/material.dart';

// Esta é a função principal do programa. É o ponto de entrada para o aplicativo Flutter. Tudo o que acontece no aplicativo começa aqui.
void main() {
  // runApp é uma função fornecida pelo Flutter que recebe um widget como argumento e o torna a raiz da hierarquia de widgets do aplicativo. É responsável por iniciar o aplicativo com o widget fornecido.
  runApp(
    // MaterialApp é um widget fornecido pelo Flutter que implementa o conceito de Material Design. Ele configura várias configurações padrão para o aplicativo, como tema, localização da barra de status e roteamento de navegação.
    // MaterialApp aceita vários parâmetros, mas neste caso, estamos passando dois parâmetros:
    // home: Este é o primeiro widget que será exibido quando o aplicativo for iniciado. Neste caso, é definido como Homepage(), que provavelmente é um widget que representa a tela inicial do aplicativo.
    // debugShowCheckedModeBanner: Este parâmetro controla se o banner de modo de depuração é exibido no canto superior direito da tela. Ao definir como false, estamos desabilitando esse banner.
    MaterialApp(
      // Homepage é um widget que representa a tela inicial do aplicativo. É passado como o parâmetro home para o MaterialApp. Este widget provavelmente contém a interface de usuário e a lógica relacionada à tela inicial do aplicativo.
      home: Homepage(),
      debugShowCheckedModeBanner: false,
  ));
}

class Homepage extends StatefulWidget {
  Homepage({super.key});

  // This widget is the root of your application.
    @override
  State<Homepage> createState() => _HomepageState();
}
 
class _HomepageState extends State<Homepage> {
  int contador = 0;

  List pages = [];
 
 
  incremento() {
 
    setState(() {
       contador++;
    });
   
    (print(contador));
  }
 
  decremento() {
    setState(() {
    if (contador > 0) {
      contador--;
    }
  });
  }
 
  zerar() {
    setState(() {
      contador = 0;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nubank'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        actions: [
          Icon(Icons.favorite),
          Icon(Icons.search),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              Text(contador.toString(), style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold),),
          ],
        )),
       drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'Home'),
      ],),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0), // Margem para cada botão
      child: FloatingActionButton(
        onPressed: incremento,
        child: Icon(Icons.add),
      ),
    ),
            Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0), // Margem para cada botão
      child: FloatingActionButton(
        onPressed: decremento,
        child: Icon(Icons.remove),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0), // Margem para cada botão
      child: FloatingActionButton(
        onPressed: zerar,
        child: Icon(Icons.refresh),
      ),
    ),
     
        ]));
     
  }
}