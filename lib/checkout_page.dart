import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, String>> cart;
  final int totalPrice;

  CheckoutPage({required this.cart, required this.totalPrice});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Variabel untuk menyimpan metode pembayaran yang dipilih
  String? paymentMethod;

  // Fungsi untuk menghapus semua produk di keranjang setelah checkout
  _clearCart(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart'); // Menghapus keranjang dari SharedPreferences

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Checkout berhasil! Keranjang dikosongkan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Pesanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Menampilkan produk yang dibeli
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  final product = widget.cart[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(product['name']!),
                      subtitle: Text('Harga: Rp ${product['price']}'),
                      leading: Image.asset(
                        product['image']!,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Menampilkan total harga
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Total Harga: Rp ${widget.totalPrice}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Opsi pembayaran
            const Text(
              'Metode Pembayaran:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Dompet Digital (OVO, DANA, Gopay)'),
              value: 'Digital Wallet',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value; // Mengubah nilai paymentMethod
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Transfer Bank'),
              value: 'Bank Transfer',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value; // Mengubah nilai paymentMethod
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Cash on Delivery'),
              value: 'COD',
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value; // Mengubah nilai paymentMethod
                });
              },
            ),
            // Tombol untuk konfirmasi checkout
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (paymentMethod == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih metode pembayaran!')),
                    );
                  } else {
                    _clearCart(context); // Hapus keranjang setelah checkout
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  }
                },
                child: const Text('Konfirmasi Pembayaran'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
