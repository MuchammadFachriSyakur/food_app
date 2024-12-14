import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For converting String back to Map
import 'checkout_page.dart'; // Import checkout page

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, String>> cart = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  _loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartStrings = prefs.getStringList('cart');

    if (cartStrings != null && cartStrings.isNotEmpty) {
      setState(() {
        cart = cartStrings.map((productString) {
          return Map<String, String>.from(json.decode(productString));
        }).toList();
      });
    }
  }

  _removeProduct(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      cart.removeAt(index);
    });

    List<String> updatedCart = cart.map((product) {
      return json.encode(product);
    }).toList();

    await prefs.setStringList('cart', updatedCart);
  }

  int _getTotalPrice() {
    int totalPrice = 0;
    for (var product in cart) {
      totalPrice += int.parse(product['price']!);
    }
    return totalPrice;
  }

  int _getTotalItems() {
    return cart.length;
  }

  _clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    setState(() {
      cart = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.white, // Updated app bar color
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text('Keranjang kosong',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final product = cart[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 5, // Added elevation for shadow
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          child: ListTile(
                            title: Text(product['name']!,
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text('Harga: Rp ${product['price']}',
                                style: TextStyle(fontFamily: 'Mulish')),
                            leading: Image.asset(
                              product['image']!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _removeProduct(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Produk: ${_getTotalItems()}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mulish'),
                      ),
                      Text(
                        'Total Harga: Rp ${_getTotalPrice()}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mulish'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  cart: cart,
                                  totalPrice: _getTotalPrice(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize:
                                  18, // Slightly larger font size for better visibility
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Mulish',
                              color: Colors
                                  .white, // Text color is white for contrast
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal:
                                    32), // Added horizontal padding for a more spacious button
                            backgroundColor:
                                Colors.blueAccent, // Background color

                            elevation: 5, // Adding a shadow for depth
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Rounded corners for a more modern look
                            ),
                            side: BorderSide(
                                color: Colors.blue,
                                width: 2), // Optional border around the button
                          )),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _clearCart,
                        child: const Text(
                          'Clear Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mulish',
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal:
                                  32), // Added horizontal padding for a more spacious button
                          backgroundColor:
                              Colors.blueAccent, // Background color

                          elevation: 5, // Adding a shadow for depth
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Rounded corners for a more modern look
                          ),
                          side: BorderSide(
                              color: Colors.blue,
                              width: 2), // Optional border around the button
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
