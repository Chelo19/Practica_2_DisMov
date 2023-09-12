import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:math';

class AverageCalculator extends StatefulWidget {
  @override
  _AverageCalculatorState createState() => _AverageCalculatorState();
}

class _AverageCalculatorState extends State<AverageCalculator> {
  List<double?> _averages = List.filled(5, null);
  List<bool> _calculating = List.filled(5, true);

  @override
  void initState() {
    super.initState();
    _calculateAverages();
  }

  Future<void> _calculateAverages() async {
    for (var i = 0; i < 5; i++) {
      final receivePort = ReceivePort();
      final completer = Completer<void>();

      Isolate isolate;
      isolate = await Isolate.spawn(
        _isolateFunction,
        {'receivePort': receivePort.sendPort},
      );

      receivePort.listen((message) {
        if (message is double) {
          setState(() {
            _averages[i] = message;
            _calculating[i] = false;
          });

          completer.complete();
        }
      });

      await completer.future;
      receivePort.close();
      isolate.kill();
    }
  }

  static void _isolateFunction(Map<String, dynamic> message) {
    final sendPort = message['receivePort'] as SendPort;

    final random = Random();
    final data = List.generate(10000, (index) => random.nextInt(1000));

    final sum = data.reduce((value, element) => value + element);
    final average = data.isNotEmpty ? sum / data.length : 0.0;

    sendPort.send(average);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (i) {
          return _calculating[i]
              ? CircularProgressIndicator()
              : _averages[i] == null
                  ? Text("Calculating...")
                  : Text("Average ${i + 1}: ${_averages[i]}");
        }),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Average Calculator'),
      ),
      body: AverageCalculator(),
    ),
  ));
}
