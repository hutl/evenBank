import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_projeto_banco/utilitarios/padrao_cores.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Even Bank',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
        '/login': (context) => TelaLogin(),
        '/home': (context) => HomePage(),
        '/recuperar-senha': (context) => TelaRecuperarSenha(),
        '/transferencia': (context) => TelaTransferencia(),
        '/cotacao': (context) => TelaCotacao(),
        '/pix': (context) => TelaPix(),
        '/pagar-pix': (context) => TelaPagarPix(),
        '/receber-pix': (context) => TelaReceberPix(),
      },
    );
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  void initState() {
    super.initState();
    _navegarParaTela2();
  }

  void _navegarParaTela2() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaLogin()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(),
      body: Container(
        decoration: BoxDecoration(gradient: gradiente()),
        child: Center(
          child: Text(
            'E B',
            style: TextStyle(
              fontSize: 70,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        preferredSize: const Size.fromHeight(0));
  }
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, preencha todos os campos.';
      });
    } else {
      Navigator.pushReplacementNamed(context, '/home', arguments: username);
    }
  }

  void _navigateToPasswordRecovery() {
    Navigator.pushNamed(context, '/recuperar-senha');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradiente()),
        child: Column(
          children: [
            SizedBox(height: 5 * MediaQuery.of(context).size.height / 100),
            Container(
              color: Colors.red,
              height: 80,
              alignment: Alignment.center,
              child: Text(
                'Even Bank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Nome',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Login'),
                          ),
                          if (_errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                _errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          const SizedBox(height: 16.0),
                          TextButton(
                            onPressed: _navigateToPasswordRecovery,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaRecuperarSenha extends StatefulWidget {
  const TelaRecuperarSenha({Key? key}) : super(key: key);

  @override
  _TelaRecuperarSenhaState createState() => _TelaRecuperarSenhaState();
}

class _TelaRecuperarSenhaState extends State<TelaRecuperarSenha> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _recoverPassword() {
    final email = _emailController.text;

    if (email.isNotEmpty) {
      print('Recuperando a senha para o email: $email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperação de Senha'),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: gradiente()),
        child: Center(
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email de Confiança',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _recoverPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Recuperar Senha'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;
  double _saldo = 1000.00;
  bool _censurado = false;
  void _alternarCensura() {
    setState(() {
      _censurado = !_censurado;
    });
  }

  String _textoBotao = 'Ocultar Saldo';

  void _alternarTextoBotao() {
    setState(() {
      _textoBotao =
          (_textoBotao == 'Ocultar Saldo') ? 'Ver Saldo' : 'Ocultar Saldo';
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic _textoCensurado = _censurado ? '***' : _saldo;
    final username = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 237, 239),
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(gradient: gradiente()),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedImage =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        setState(() {
                          _selectedImage = File(pickedImage.path);
                        });
                      }
                    },
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Olá, $username!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Saldo \$',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          fit:
                              FlexFit.tight,
                          child: Text(
                            'R\$ $_textoCensurado',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              _alternarCensura();
                              _alternarTextoBotao(); 
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets
                                  .zero, 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Define a mesma borda do container
                              ),
                            ),
                            child: Text(
                              _textoBotao,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  height: 200,
                  width:
                      325, 
                  margin: EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20), 
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20), 
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/PearlJam-Ten2.jpg/220px-PearlJam-Ten2.jpg',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 135,
                  left: 100,
                  child: Text(
                    'PROPAGANDA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/pix');
                    },
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://imagensfree.com.br/wp-content/uploads/2022/01/icone-pix.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(height: 8),
                        Text('Pix'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/transferencia',
                      );
                    },
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://cdn.icon-icons.com/icons2/2566/PNG/512/transfer_icon_153324.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(height: 8),
                        Text('Transferir'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/cotacao');
                    },
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/512/858/858151.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(height: 8),
                        Text('Cotação'),
                      ],
                    ),
                  ),
                ],
              ),
            )
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

class TelaTransferencia extends StatefulWidget {
  @override
  _TelaTransferenciaState createState() => _TelaTransferenciaState();
}

class _TelaTransferenciaState extends State<TelaTransferencia> {
  TextEditingController agenciaController = TextEditingController();
  TextEditingController contaController = TextEditingController();
  TextEditingController digitoContaController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController titularController = TextEditingController();
  TextEditingController cpfController = TextEditingController();

  TelaTransferencia() {
    agenciaController = TextEditingController();
    contaController = TextEditingController();
    digitoContaController = TextEditingController();
    cpfController = TextEditingController();

    agenciaController.addListener(() {
      agenciaController.text =
          agenciaController.text.replaceAll(RegExp(r'[^0-9]'), '');
      agenciaController.selection = TextSelection.fromPosition(
          TextPosition(offset: agenciaController.text.length));
    });

    contaController.addListener(() {
      contaController.text =
          contaController.text.replaceAll(RegExp(r'[^0-9]'), '');
      contaController.selection = TextSelection.fromPosition(
          TextPosition(offset: contaController.text.length));
    });

    digitoContaController.addListener(() {
      digitoContaController.text =
          digitoContaController.text.replaceAll(RegExp(r'[^0-9]'), '');
      digitoContaController.selection = TextSelection.fromPosition(
          TextPosition(offset: digitoContaController.text.length));
    });

    cpfController.addListener(() {
      cpfController.text = cpfController.text.replaceAll(RegExp(r'[^0-9]'), '');
      cpfController.selection = TextSelection.fromPosition(
          TextPosition(offset: cpfController.text.length));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void realizarTransferencia() {
    if (agenciaController.text.isEmpty ||
        contaController.text.isEmpty ||
        digitoContaController.text.isEmpty ||
        valorController.text.isEmpty ||
        titularController.text.isEmpty ||
        cpfController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campos incompletos'),
            content: Text('Por favor, preencha todos os campos.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    String agencia = agenciaController.text;
    String conta = contaController.text;
    String digitoConta = digitoContaController.text;
    double valor = double.parse(valorController.text);
    String titular = titularController.text;
    String cpf = cpfController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transferência realizada'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Agência: $agencia'),
              Text('Conta: $conta'),
              Text('Dígito da Conta: $digitoConta'),
              Text('Valor da Transferência: R\$ $valor'),
              Text('Titular da Conta: $titular'),
              Text('CPF/CNPJ do Titular: $cpf'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );

    agenciaController.clear();
    contaController.clear();
    digitoContaController.clear();
    valorController.clear();
    titularController.clear();
    cpfController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradiente()),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Transferência',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Dados Bancários',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: agenciaController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Agência',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: contaController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Conta',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: digitoContaController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Dígito da Conta',
                              counterText: '',
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                          ),
                          TextField(
                            controller: valorController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Valor da Transferência',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: titularController,
                            decoration: InputDecoration(
                              labelText: 'Nome do Titular da Conta',
                            ),
                          ),
                          TextField(
                            controller: cpfController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'CPF/CNPJ do Titular',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: realizarTransferencia,
                            child: Text('Transferir'),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> getData() async {
  var url =
      Uri.parse('https://api.hgbrasil.com/finance?format=json&key=801a9dce');
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class TelaCotacao extends StatefulWidget {
  const TelaCotacao({Key? key}) : super(key: key);

  @override
  State<TelaCotacao> createState() => _TelaCotacaoState();
}

class _TelaCotacaoState extends State<TelaCotacao> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  double dolar = 0.0;
  double euro = 0.0;

  void _realChanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  Widget campoTexto(String label, String prefix, TextEditingController c,
      Function(String)? f) {
    return Material(
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.green),
          border: const OutlineInputBorder(),
          prefixText: prefix,
        ),
        style: const TextStyle(color: Colors.green, fontSize: 25.0),
        onChanged: f,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  void shareData() {
    final data = {
      'Reais': realController.text,
      'Euros': euroController.text,
      'Dólares': dolarController.text,
    };
    final jsonData = json.encode(data);
    Share.share(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradiente(),
      ),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          heightFactor: 0.85,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FutureBuilder<Map<String, dynamic>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(
                          child: Text(
                            "Aguarde...",
                            style:
                                TextStyle(color: Colors.green, fontSize: 30.0),
                            textAlign: TextAlign.center,
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          String? erro = snapshot.error.toString();
                          return Center(
                            child: Text(
                              "Ops, houve uma falha ao buscar os dados: $erro",
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 25.0),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          dolar = snapshot.data!["results"]["currencies"]["USD"]
                              ["buy"];
                          euro = snapshot.data!["results"]["currencies"]["EUR"]
                              ["buy"];
                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const Icon(Icons.attach_money,
                                    size: 180.0, color: Colors.green),
                                campoTexto("Reais", "R\$ ", realController,
                                    _realChanged),
                                const Divider(),
                                campoTexto("Euros", "€ ", euroController,
                                    _euroChanged),
                                const Divider(),
                                campoTexto("Dólares", "US\$ ", dolarController,
                                    _dolarChanged),
                                ElevatedButton(
                                  onPressed: shareData,
                                  child: const Text('Compartilhar Cotação'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    realController.clear();
                                    dolarController.clear();
                                    euroController.clear();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .red, // Set the desired color here
                                  ),
                                  child: Text('Limpar'),
                                ),
                              ],
                            ),
                          );
                        }
                    }
                  })),
        ),
      ),
    );
  }
}

class TelaPix extends StatefulWidget {
  const TelaPix({super.key});

  @override
  State<TelaPix> createState() => _TelaPixState();
}

class _TelaPixState extends State<TelaPix> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: gradiente()),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 300,
              ),
              child: AspectRatio(
                aspectRatio: 2 / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 100),
                          Text(
                            'Pix',
                            style: TextStyle(
                                fontSize: 28, fontFamily: 'ArialBold'),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 65),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(Icons.payment),
                          title: Text('Pagar'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.pushReplacementNamed(context,
                                "/pagar-pix"); // Ação do botão de pagar
                          },
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text('Receber'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.pushReplacementNamed(context,
                                "/receber-pix"); 
                          },
                        ),
                      ),
                      SizedBox(height: 65),
                      Column(
                        children: [
                          ListTile(
                            title: Text('Mais >'),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.vpn_key),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Disponível em breve'),
                                        content: Text(
                                            'Recurso "Minhas Chaves" estará disponível em breve.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Text('Minhas\nChaves'),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Disponível em breve'),
                                        content: Text(
                                            'Recurso "Meus Favoritos" estará disponível em breve.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ); // Ação do botão de Meus Favoritos
                                  },
                                ),
                                Text('  Meus\nFavoritos'),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.receipt),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Disponível em breve'),
                                        content: Text(
                                            'Recurso "Extrato Devolução" estará disponível em breve.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ); // Ação do botão de Extrato Devolução
                                  },
                                ),
                                Text('  Extrato\nDevolução'),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.keyboard_option_key_sharp),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Disponível em breve'),
                                        content: Text(
                                            'Recurso "Meus Limites" estará disponível em breve.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ); // Ação do botão de Meus Limites
                                  },
                                ),
                                Text(' Meus\nLimites'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class TelaPagarPix extends StatefulWidget {
  const TelaPagarPix({super.key});

  @override
  State<TelaPagarPix> createState() => _TelaPagarPixState();
}

class _TelaPagarPixState extends State<TelaPagarPix> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: gradiente(),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 300,
              ),
              child: AspectRatio(
                aspectRatio: 2 / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, 
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/pix",
                              ); 
                            },
                          ),
                          SizedBox(width: 40),
                          Text(
                            'Pagar com Pix',
                            style: TextStyle(
                                fontSize: 22, fontFamily: 'ArialBold'),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chave',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Colar chave',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(245, 164, 66, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Insira CPF, CNPJ, celular ou e-mail',
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Outros pagamentos',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.qr_code),
                                  onPressed: () {},
                                ),
                                Text('QR code'),
                              ],
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () {},
                                ),
                                Text('Pix Copia\n  e Cola'),
                              ],
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.account_balance),
                                  onPressed: () {},
                                ),
                                Text('Agência\ne Conta'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Favoritos recentes',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Ver todos',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(245, 164, 66, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class TelaReceberPix extends StatefulWidget {
  const TelaReceberPix({super.key});

  @override
  State<TelaReceberPix> createState() => _TelaReceberPixState();
}

class _TelaReceberPixState extends State<TelaReceberPix> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: gradiente()),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 300,
              ),
              child: AspectRatio(
                aspectRatio: 2 / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/pix",
                              ); // Ação do botão de voltar
                            },
                          ),
                          SizedBox(width: 50),
                          Text(
                            'Receber Pix',
                            style: TextStyle(
                                fontSize: 24, fontFamily: 'ArialBold'),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        '       Mostre ou compartilhe o\n       QR Code sem valor definido',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 126, 126, 126)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: QrImageView(
                              data: 'Even Bank',
                              version: QrVersions.auto,
                              size: 200,
                              gapless: false,
                            ) //por QR Code aqui
                            ),
                      ),
                      SizedBox(height: 15),
                      Text.rich(
                        TextSpan(
                          text: 'Chave de e-mail:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          children: <InlineSpan>[
                            TextSpan(
                              text: ' example@gmail.com',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class TelaPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Placeholder'),
      ),
      body: Center(
        child: Text('Tela não implementada'),
      ),
    );
  }
}
