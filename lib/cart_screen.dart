import 'package:flutter/material.dart';
import 'main.dart'; // Importa la clase Product y la lista shoppingCart de main.dart
import 'purchase_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String email = ''; // Variable para el correo electrónico

  void makePurchase(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PurchaseScreen(
          purchasedProducts: shoppingCart,
          totalCost: calculateTotalCost(),
          email: email, // Pasa el correo electrónico a la pantalla de compra
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrito de Compras',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.orange[500],
      ),
      body: buildCartContents(),
    );
  }

  double calculateTotalCost() {
    double totalCost = 0;
    for (final product in shoppingCart) {
      totalCost += product.price;
    }
    return totalCost;
  }

  Widget buildCartContents() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shoppingCart.length,
            itemBuilder: (context, index) {
              return CartItem(product: shoppingCart[index]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Correo Electrónico', // Etiqueta para el campo de correo electrónico
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                email = value; // Actualiza la variable con el correo electrónico
              });
            },
          ),
        ),
        Text(
          'Total Costo: \$${calculateTotalCost().toStringAsFixed(2)}', // Muestra el costo total
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            makePurchase(context);
          },
          child: Text('Hacer Compra'),
        ),
      ],
    );
  }
}

class CartItem extends StatelessWidget {
  final Product product;

  CartItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text('ID: ${product.id}' + '    ' + 'Precio: ${product.price}'),
      // Puedes mostrar información adicional del producto aquí.
    );
  }
}
