import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<CartItem> cartItems = [
    CartItem(
      name: 'blue pullover',
      category: 'sweater',
      image: 'https://img01.ztat.net/article/spp-media-p1/babefc0ba99242a1be6e64978f764410/9c51ce0d5ba540d88f8859a909de3f5c.jpg?imwidth=762',
      unitPrice: 10.0,
      quantity: 0,
    ),
    CartItem(
      name: 'Red T-shirt',
      category: 'T-shirt',
      image: 'https://cdn-images.buyma.com/imgdata/item/230802/0097457899/558537232/org.jpg',
      unitPrice: 15.0,
      quantity: 0,
    ),
    CartItem(
      name: 'RM jersey',
      category: 'Sports wear',
      image: 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/622cae1412944d4090c0756d3ed31af8_9366/Real_Madrid_23-24_Third_Jersey_Black_IN9846_HM1.jpg',
      unitPrice: 20.0,
      quantity: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return buildCartItemCard(cartItems[index]);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showSnackbar();
              },
              child: Text('CHECK OUT'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItemCard(CartItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image on the left side
              Container(
                height: 80, // Adjust the height as needed
                width: 80,  // Adjust the width as needed
                child: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12), // Add padding between the image and text
              // Text content on the right side
              Padding(
                padding: const EdgeInsets.only(left: 12.0), // Add left padding
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Name: ${item.name}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Category: ${item.category}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                item.quantity++;
                              });
                            },
                          ),
                          Text('Quantity: ${item.quantity}'),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 0) {
                                  item.quantity--;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total: \$${(item.quantity * item.unitPrice).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the snackbar on checkout
  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }
}

class CartItem {
  final String name;
  final String category;
  final String image;
  final double unitPrice;
  int quantity;

  CartItem({
    required this.name,
    required this.category,
    required this.image,
    required this.unitPrice,
    required this.quantity,
  });
}
