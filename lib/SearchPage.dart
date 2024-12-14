import 'package:flutter/material.dart';
import 'DetailPages.dart';

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> filters = <String>[
    'All',
    'Makanan',
    'Minuman',
    'Camilan',
  ];

  final List<Map<String, String>> products = [
    {
      'name': 'Nasi Goreng',
      'description': 'Nasi goreng khas kantin dengan telur dan ayam',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Makanan',
      'price': '12000',
    },
    {
      'name': 'Mie Goreng',
      'description': 'Mie goreng pedas dengan sayuran dan daging',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Makanan',
      'price': '10000',
    },
    {
      'name': 'Es Teh Manis',
      'description': 'Es teh manis yang segar dan menyegarkan',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Minuman',
      'price': '5000',
    },
    {
      'name': 'Kue Cubir',
      'description': 'Kue cubir manis dengan lapisan kelapa parut',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Camilan',
      'price': '4000',
    },
    {
      'name': 'Roti Bakar',
      'description': 'Roti bakar dengan selai coklat atau keju',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Camilan',
      'price': '8000',
    },
    {
      'name': 'Sate Ayam',
      'description': 'Sate ayam dengan bumbu kacang spesial',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Makanan',
      'price': '15000',
    },
    {
      'name': 'Pop Mie',
      'description': 'Mie instan siap saji dengan rasa pedas',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Makanan',
      'price': '8000',
    },
    {
      'name': 'Es Krim',
      'description': 'Es krim dengan berbagai rasa favorit',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Minuman',
      'price': '7000',
    },
    {
      'name': 'Kebab',
      'description': 'Kebab daging sapi dengan sayuran segar',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Makanan',
      'price': '18000',
    },
    {
      'name': 'Bakso',
      'description': 'Bakso daging sapi dengan kuah segar',
      'image': 'assets/Image/AyamGoreng.jpg',
      'type': 'Makanan',
      'price': '10000',
    },
  ];

  String selectedFilter = 'All';
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  List<Map<String, String>> get filteredProducts {
    List<Map<String, String>> filteredByType = selectedFilter == 'All'
        ? products
        : products
            .where((product) => product['type'] == selectedFilter)
            .toList();

    if (searchQuery.isEmpty) {
      return filteredByType;
    } else {
      return filteredByType
          .where((product) => product['name']!
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(45),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Mie Ayam, Es Teh',
                  icon: Icon(Icons.search, color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.grey),
            onPressed: () {
              setState(() {
                searchQuery = '';
                searchController.clear();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = selectedFilter == filter;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 10.0),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final dataProduct = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(product: dataProduct),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              dataProduct['image'] ?? '',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataProduct['name'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    dataProduct['price'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
