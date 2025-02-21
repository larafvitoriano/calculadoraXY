import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _x = '0';
  String _y = '0';
  String _resultado = '';

  void _informarX() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreencheValoresScreen(title: 'Set X')),
    );
    
    if (result != null) {
      setState(() {
        _x = result;
      });
    }
  }

  void _informarY() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreencheValoresScreen(title: 'Set Y')),
    );

    if (result != null) {
      setState(() {
        _y = result;
      });
    }
  }

  void _calcular() {
    double? x = double.tryParse(_x);
    double? y = double.tryParse(_y);

    if (x != null && y != null) {
      double resultado = x + y;
      setState(() {
        _resultado = resultado.toString();
      });
    } else {
      setState(() {
        _resultado = 'Valores inválidos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('X: $_x'),
                SizedBox(width: 20),
                ElevatedButton(onPressed: _informarX, child: Text('Informar X')
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Y: $_y'),
                SizedBox(width: 20),
                ElevatedButton(onPressed: _informarY, child: Text('Informar Y')
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _calcular, child: Text('Calcular')
            ),
            SizedBox(height: 20),
            Text('Resultado: $_resultado'),
          ],
        ),
      ),
      );
  }
}

class PreencheValoresScreen extends StatelessWidget {
  PreencheValoresScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Set ${title.split(' ').last}:'),
            SizedBox(height: 8),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite um valor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _controller.text);
                },
                child: Text('OK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
