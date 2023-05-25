import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projeto_banco/utilitarios/padrao_cores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Even Bank',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _censurado = false;

  void _alternarCensura() {
    setState(() {
      _censurado = !_censurado;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _saldo = 420.69;

    dynamic _textoCensurado = _censurado ? '***' : _saldo;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(gradient: gradiente()),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/en/e/e1/PJAlive.jpg',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Pearl Jam',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey),
              child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Saldo \$',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'R\$ $_textoCensurado',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: ElevatedButton(
                              onPressed: _alternarCensura,
                              child: Text('Ver Saldo'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 16),
            Container(
              height: 200, // Altura da caixa grande
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/PearlJam-Ten2.jpg/220px-PearlJam-Ten2.jpg', // URL da imagem
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SegundaTela()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        'https://imagensfree.com.br/wp-content/uploads/2022/01/icone-pix.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text('Pix'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TerceiraTela()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        'https://cdn.icon-icons.com/icons2/2566/PNG/512/transfer_icon_153324.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text('Transferir'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuartaTela()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/4021/4021708.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text('Cartão'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SegundaTela()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/858/858151.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text('Cotação'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSize _appBar() {
  return PreferredSize(
      child: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      preferredSize: const Size.fromHeight(0));
}

class SegundaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Tela'),
      ),
      body: Center(
        child: Text('Conteúdo da segunda tela'),
      ),
    );
  }
}

class TerceiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terceira Tela'),
      ),
      body: Center(
        child: Text('Conteúdo da terceira tela'),
      ),
    );
  }
}

class QuartaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quarta Tela'),
      ),
      body: Center(
        child: Text('Conteúdo da quarta tela'),
      ),
    );
  }
}
