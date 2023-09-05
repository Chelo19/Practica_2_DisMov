import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  MyTextInput({super.key, required this.inputController, required this.label});

  final TextEditingController inputController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: inputController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Color.fromARGB(255, 25, 211, 133)),
          prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 25, 211, 133)),
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  MyText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromARGB(255, 13, 141, 88),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.lblText, required this.press});

  final Text lblText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 25, 211, 133),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: lblText,
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:Color.fromARGB(255, 25, 211, 133).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class MyAppContainer extends StatelessWidget {
  const MyAppContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 25, 211, 133).withOpacity(0.7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Center(
        child: Text(
          "Calculadora de Peso Ideal",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color del texto
          ),
        ),
      ),
    );
  }
}

      class MyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Tabla de Pesos',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20), // Espacio entre el título y la tabla
          Table(
            border: TableBorder(
              horizontalInside: BorderSide(color: Colors.blue, width: 1.0),
              verticalInside: BorderSide(color: Colors.blue, width: 1.0),
            ),
            children: [
              _buildTableRow('Menor a 18.5', 'Peso Bajo'),
              _buildTableRow('18.6 a 24.9', 'Peso Normal'),
              _buildTableRow('25 a 29.9', 'Sobrepeso'),
              _buildTableRow('30 a 34.9', 'Obesidad Leve'),
              _buildTableRow('35 a 39.9', 'Obesidad Media'),
              _buildTableRow('Mayor a 40', 'Obesidad Mórbida'),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String leftText, String rightText) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              leftText,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              rightText,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

