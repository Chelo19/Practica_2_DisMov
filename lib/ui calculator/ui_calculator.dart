import 'package:flutter/material.dart';
import 'package:namer_app/ui%20calculator/widgets/widgets_calculator.dart';

class CalculatorUI extends StatefulWidget{
  const CalculatorUI({super.key});
  @override
  State<CalculatorUI> createState() => _CalculatorUIState();
}

class _CalculatorUIState extends State<CalculatorUI> {
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();
  String respuesta="RESPUESTA";
  double imc = 0.0;

  void _calcular(){
    setState(() {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;
      imc = peso / (altura * altura);
      respuesta = imc.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: MyContainer(
          child: Column(
            children: [
              Stack(
                children: [
                  MyAppContainer()
                ],
              ),
              _sizeEspacio(),
              MyTextInput(inputController: _pesoController, label: "Peso Kg"),
              MyTextInput(inputController: _alturaController, label: "Altura Cm"),
              _sizeEspacio(),
              MyText(text: respuesta.toString()),
              _sizeEspacio(),
              MyButton(
                lblText: Text("Calcular"),
                press: (() => _calcular()),
              ),
              _sizeEspacio(),
              MyTable(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _sizeEspacio(){
  return SizedBox(
    height: 30,
  );
}