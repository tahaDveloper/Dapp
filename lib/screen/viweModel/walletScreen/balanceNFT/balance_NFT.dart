import 'package:flutter/material.dart';

class PetCategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> pets = [
    {
      "name": "Scottish Fold Cat",
      "details": "Female, Two Months Old",
      "price": "Sell & Set Price",
      "image":
      "assets/image/¿Qué cuidados debe tener mi gato recién nacido_.png"
    },
    {
      "name": "Pekin Duck",
      "details": "Two Days Old, Female",
      "price": "\$ 136.000",
      "image": "assets/image/download (1).png"
    },
    {
      "name": "Pug Puppy, Black",
      "details": "2 Months Old, Male",
      "price": "\$ 1.570.000",
      "image":
      "assets/image/22 Pug Facts - How Well Do You Really Know Your Favorite Dog_.png"
    },
    {
      "name": "Turkish Angora Cat",
      "details": "Female, Two Months Old",
      "price": "\$ 1.570.000",
      "image":
      "assets/image/50 Times People Captured Their Cats Losing Their Single Brain Cell (Best Pics) i 2024.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Pet Category", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          pet["image"],
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet["name"],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              pet["details"],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              pet["price"],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // نمایش قیمت بالای Bottom Sheet
                                Text(
                                  "Price: \$",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                // جای وارد کردن قیمت
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Enter your price",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                // دکمه تایید
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // بستن Bottom Sheet
                                  },
                                  child: Text("Submit"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                        Icons.card_giftcard, color: Colors.white, size: 18),
                    label: Text("Gift", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
    }
  }
