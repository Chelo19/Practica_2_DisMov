import 'package:flutter/material.dart';

void main() => runApp(ColorEditApp());

class ColorEditApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ColorScreen(),
        '/edit': (context) => EditColorScreen(),
      },
    );
  }
}

class ColorScreen extends StatefulWidget {
  @override
  _ColorScreenState createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  Color _color = Color.fromARGB(255, 255, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            child: Text('Cambiar Color'),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/edit',
                arguments: _color,
              );
            },
          ),
        ),
      ),
    );
  }
}

class EditColorScreen extends StatefulWidget {
  @override
  _EditColorScreenState createState() => _EditColorScreenState();
}

class _EditColorScreenState extends State<EditColorScreen> {
  late List<TextEditingController> _controllers;

  @override
  void didChangeDependencies() {
    final Color color = ModalRoute.of(context).settings.arguments;
    final List<String> canales = [
      color.red.toString(),
      color.green.toString(),
      color.blue.toString(),
    ];
    _controllers = [
      for (int i = 0; i < 3; i++)
        TextEditingController(
          text: canales[i],
        ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> colores = ['red', 'green', 'blue'];
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Color'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  for (int i = 0; i < 3; i++)
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: _controllers[i],
                            decoration: InputDecoration(
                              labelText: colores[i],
                            ),
                          )),
                    )
                ],
              ),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
