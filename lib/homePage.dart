import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menyembunyikan Tulisan debug dipojok kanan
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  final List<Map<String, String>> categorys = [
    {'imagePath': 'Image/Breakfast.png', 'labelText': 'Sarapan'},
    {'imagePath': 'Image/Breakfast.png', 'labelText': 'Fast Food'},
    {'imagePath': 'Image/Breakfast.png', 'labelText': 'Kue'},
    {'imagePath': 'Image/Breakfast.png', 'labelText': 'Minuman'},
  ];

  final List<Map<String, dynamic>> favorites = [
    {
      'imagePath': 'Image/AyamGoreng.jpg',
      'title': 'Nasi Ayam Bakar',
      'price': 20000,
    },
    {
      'imagePath': 'Image/AyamGoreng.jpg',
      'title': 'Sarapan Pagi',
      'price': 15000,
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi Pengunjung',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: Colors.black54,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.asset(
                      'Image/PhotoProfile.jpeg', // Gambar profil
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Apa yang ingin kamu makan hari ini?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Mulish',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  // Input Field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mie Ayam, Es Teh',
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 95,
                child: Align(
                  alignment: Alignment.center,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categorys
                        .map((category) => buildCategoryCard(
                              context,
                              category['imagePath']!,
                              category['labelText']!,
                            ))
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Popular Section
              const Text(
                'Paling diminati',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Mulish',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: favorites
                    .map((food) => buildFavoriteCard(
                          food['imagePath']!,
                          food['title']!,
                          food['price']!,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Kategori
  Widget buildCategoryCard(
      BuildContext context, String imagePath, String labelText) {
    return Container(
      width: 95,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      // padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          FractionallySizedBox(
            widthFactor: 0.75, // 85% dari lebar parent
            child: Text(
              labelText,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'Mulish',
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat card makanan paling diminati
  Widget buildFavoriteCard(String ImagePath, String title, int Price) {
    String formatPriceToRupiah(int price) {
      final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
      return formatter.format(price);
    }

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Details()),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar untuk makanan
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.asset(
                ImagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),

            // Informasi makanan
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Mulish',
                      color: Colors.black,
                    ),
                  ),
                  // Jarak untuk jdusm dan prisw
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    formatPriceToRupiah(Price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Mulish',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
