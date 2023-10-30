import 'package:flutter/material.dart';
import 'main.dart'; // Import the Product class and shoppingCart list from main.dart

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping cart',
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
        Text(
          'Total Cost: \$${calculateTotalCost().toStringAsFixed(2)}', // Display the total cost
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      subtitle: Text('ID: ${product.id}' + '    Price: ${product.price}'),
      // You can display additional product information here.
    );
  }
}