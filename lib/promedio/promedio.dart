import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class AverageCalculator extends StatefulWidget {
  @override
  _AverageCalculatorState createState() => _AverageCalculatorState();
}

class _AverageCalculatorState extends State<AverageCalculator> {
  double? _average;
  bool _calculating = true;

  @override
  void initState() {
    super.initState();
    _calculateAverage();
  }

  Future<void> _calculateAverage() async {
    final receivePort = ReceivePort();
    final completer = Completer<void>();

    Isolate isolate;
    isolate = await Isolate.spawn(
      _isolateFunction,
      {'receivePort': receivePort},
    );

    receivePort.listen((message) {
      if (message is double) {
        setState(() {
          _average = message;
          _calculating = false;
        });

        completer.complete();
      }
    });

    await completer.future;
    isolate.kill();
  }

  static void _isolateFunction(Map<String, dynamic> message) {
    final sendPort = message['receivePort'] as SendPort;

    final data = List.generate(10000, (index) => index + 1);
    final sum = data.reduce((value, element) => value + element).toDouble();
    final average = sum / data.length;

    sendPort.send(average);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _calculating
          ? CircularProgressIndicator()
          : _average == null
              ? Text("Calculating...")
              : Text("Average: $_average"),
    );
  }
}
