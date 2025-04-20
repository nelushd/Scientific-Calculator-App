import 'package:flutter/material.dart';

void main() {
  runApp(const ScientificCalculatorApp());
}

class ScientificCalculatorApp extends StatelessWidget {
  const ScientificCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: ' Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        try {
          _result = _evaluate(_input).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  double _evaluate(String expression) {
    // Very simple evaluation using Dart's 'Expression' (not full parser)
    // Use a real expression parser like math_expressions in future!
    return double.parse(_SciCalc(expression).toString());
  }

  num _SciCalc(String expr) {
    // Supports single operations like 12+5, 8*9 etc.
    if (expr.contains('+')) {
      var parts = expr.split('+');
      return num.parse(parts[0]) + num.parse(parts[1]);
    } else if (expr.contains('-')) {
      var parts = expr.split('-');
      return num.parse(parts[0]) - num.parse(parts[1]);
    } else if (expr.contains('*')) {
      var parts = expr.split('*');
      return num.parse(parts[0]) * num.parse(parts[1]);
    } else if (expr.contains('/')) {
      var parts = expr.split('/');
      return num.parse(parts[0]) / num.parse(parts[1]);
    }
    return num.parse(expr);
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      '7',
      '8',
      '9',
      '/',
      '4',
      '5',
      '6',
      '*',
      '1',
      '2',
      '3',
      '-',
      'C',
      '0',
      '=',
      '+',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sicientific Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_input, style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  Text(_result,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              final btn = buttons[index];
              return ElevatedButton(
                onPressed: () => _onPressed(btn),
                child: Text(btn, style: const TextStyle(fontSize: 24)),
              );
            },
          ),
        ],
      ),
    );
  }
}
