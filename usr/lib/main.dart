import 'package:flutter/material.dart';

void main() {
  runApp(const DivisionApp());
}

class DivisionApp extends StatelessWidget {
  const DivisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'División y Prueba',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DivisionHomePage(),
    );
  }
}

class DivisionHomePage extends StatefulWidget {
  const DivisionHomePage({super.key});

  @override
  State<DivisionHomePage> createState() => _DivisionHomePageState();
}

class _DivisionHomePageState extends State<DivisionHomePage> {
  final TextEditingController _dividendController = TextEditingController();
  final TextEditingController _divisorController = TextEditingController();

  String _resultText = '';
  String _proofText = '';

  void _calculateDivision() {
    final dividendString = _dividendController.text;
    final divisorString = _divisorController.text;

    if (dividendString.isEmpty || divisorString.isEmpty) {
      setState(() {
        _resultText = 'Por favor, ingresa ambos números.';
        _proofText = '';
      });
      return;
    }

    final dividend = int.tryParse(dividendString);
    final divisor = int.tryParse(divisorString);

    if (dividend == null || divisor == null) {
      setState(() {
        _resultText = 'Por favor, ingresa números enteros válidos.';
        _proofText = '';
      });
      return;
    }

    if (divisor == 0) {
      setState(() {
        _resultText = 'El divisor no puede ser cero.';
        _proofText = '';
      });
      return;
    }

    final quotient = dividend ~/ divisor;
    final remainder = dividend % divisor;

    setState(() {
      _resultText = 'Cociente: $quotient\nResto: $remainder';
      _proofText = 'Prueba:\n($divisor × $quotient) + $remainder = ${(divisor * quotient) + remainder}';
    });
  }

  @override
  void dispose() {
    _dividendController.dispose();
    _divisorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('División y Prueba'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingresa los números para realizar la división y ver su prueba.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _dividendController,
              decoration: const InputDecoration(
                labelText: 'Dividendo (Número a dividir)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _divisorController,
              decoration: const InputDecoration(
                labelText: 'Divisor',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateDivision,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Calcular', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 32),
            if (_resultText.isNotEmpty)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        _resultText,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _proofText,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
