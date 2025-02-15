import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../widget/customeNavigation/widget_navigation.dart';
import '../../../widget/customeTextFild/Text_Fild.dart';

class StorePage extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'title': 'Jack Russell dog',
      'price': '600,000',
      'image': 'assets/image/5872854524849407807.jpg',
      'category': 'Pets'
    },
    {
      'title': 'Luxury Sofa',
      'price': '600,000',
      'image': 'assets/image/5872854524849407798.jpg',
      'category': 'Home'
    },
    {
      'title': 'Volvo XC90',
      'price': '600,000',
      'image': 'assets/image/5872854524849407813.jpg',
      'category': 'Cars'
    },
    {
      'title': 'Modern Rifle',
      'price': '600,000',
      'image': 'assets/image/5872854524849407812.jpg',
      'category': 'Tools'
    },
  ];
  int selectedIndex = 0; // برای ذخیره کردن اندیس انتخاب شده

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff17191D),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: 'Search for products...',
              labelText: 'Search',
              validator: (value) {},
              obscureText: Colors.white,
              backgroundColor: Color(0xff333333),
              focusedLabelColor: Color(0xffE2E2B6),
              keyboardType: TextInputType.text,

            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0,
                children: ['Home', 'Pet', 'Clothes', 'Digital Tools', 'Tools']
                    .map(
                      (category) => Chip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: Color(0xffE2E2B6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Color(0xff03346E),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Color(0xff6EACDA),
                        width: 2,
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: products[index],
                        ),
                      ),
                    );
                  },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff6EACDA), // رنگ اول
                              Color(0xff03346E), // رنگ دوم
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                child: Image.asset(
                                  products[index]['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                products[index]['title']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffE2E2B6),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Pol ${products[index]['price']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff6EACDA),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Navigation(), // Add the bottom navigation bar with your buttons
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2E2E2E),
      appBar: AppBar(
        backgroundColor: Color(0xff333333),
        title: Text(
          'Product Details',
          style: TextStyle(color: Color(0xffE2E2B6)),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)),
              child: Image.asset(
                product['image']!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['title']!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'The ${product['title']} is a premium quality product with a unique design and affordable price.',
              style: TextStyle(fontSize: 16, color: Color(0xff6EACDA)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Price: Pol ${product['price']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffE2E2B6),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        "Purchase Failed",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        "You don't have enough funds to purchase this NFT.",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Buy',
                  style: TextStyle(fontSize: 20, color: Color(0xffE2E2B6)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff03346E),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:Navigation(),

    );
  }
}
