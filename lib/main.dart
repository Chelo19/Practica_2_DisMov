import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

List<Product> shoppingCart = [];

class _GalleryScreenState extends State<GalleryScreen> {
  List<Product> products = [];

  void addToCart(Product product) {
    setState(() {
      shoppingCart.add(product);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(_fetchDataInIsolate, receivePort.sendPort);

    List<Product> productData = await receivePort.first;
    setState(() {
      products = productData;
    });
  }

  static void _fetchDataInIsolate(SendPort sendPort) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<Product> products = jsonList.map((e) => Product.fromJson(e)).toList();
      sendPort.send(products);
    } else {
      sendPort.send([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos Disponibles',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.orange[500],
      ),
      backgroundColor: Colors.orange[50],
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            addToCart: addToCart, // Pass addToCart function
            navigateToCartScreen: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            }, // Pass function to navigate to CartScreen
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
        backgroundColor: Colors.orange[500], //33,150,243, 100
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}


class Product {
  final int id;
  final String title;
  int get price => 10; //final double price; // Ensure that 'price' is not nullable

  Product({
    required this.id,
    required this.title, // Make 'price' required
     //QUITAR required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      // QUITAR price: 10.0,
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function(Product) addToCart;
  final void Function() navigateToCartScreen;

  ProductCard({
    required this.product,
    required this.addToCart,
    required this.navigateToCartScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Icon(
            Icons.shopping_cart,
            size: 60.0,
            color: Color.fromARGB(255, 33, 150, 243), //33,150,243, 100
          ),
          Text(
            product.title,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text('ID: ${product.id}'),
          Text('Price: ${product.price}' ),
          ElevatedButton(
            onPressed: () {
              addToCart(product); // Call addToCart function
              navigateToCartScreen(); // Call function to navigate to CartScreen
            },
            child: Text('Add to cart'),
          ),
        ],
      ),
    );
  }
}