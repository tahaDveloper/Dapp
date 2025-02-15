import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../transfer/transferNFT/transferNFTviwe.dart';
import '../../../../../widget/customeNavigation/widget_navigation.dart';
import '../../../../../widget/customeTextFild/Text_Fild.dart';
import '../../../../../widget/elevatedButton/ElevatedButton.dart';

class PetCategoryView extends StatefulWidget {
  @override
  _PetCategoryViewState createState() => _PetCategoryViewState();
}

class _PetCategoryViewState extends State<PetCategoryView> {
  List<Map<String, String?>> pets = [
    {
      'title': 'Scottish Fold Cat',
      'subtitle': 'Female, Two Months Old',
      'buttonText': 'Sell & Set Price',
      'imagePath': 'assets/image/5872854524849407811.jpg',
      'price': null,
    },
    {
      'title': 'Pekin Duck',
      'subtitle': 'Two Days Old, Female',
      'buttonText': null,
      'imagePath': 'assets/image/5872854524849407808.jpg',
      'price': '\$136.000',
    },
    {
      'title': 'Pug Puppy, Black',
      'subtitle': '2 Months Old, Male',
      'buttonText': null,
      'imagePath': 'assets/image/5872854524849407814.jpg',
      'price': '\$1.570.000',
    },
    {
      'title': 'Turkish Angora Cat',
      'subtitle': 'Female, Two Months Old',
      'buttonText': null,
      'imagePath': 'assets/image/5872854524849407810.jpg',
      'price': '\$1.570.000',
    },
  ];

  void _sellPet(int index) {
    setState(() {
      pets.removeAt(index); // Remove the pet from the list
    });
    Navigator.pushNamed(context, '/StorePage'); // Navigate to the store page
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(
            'Pet Category',
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {
                navigator?.pop();
                // Functionality for the back button can be added here
              },
            ),
          ],
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // 5% of screen width for padding
            vertical: screenHeight * 0.02, // 2% of screen height for vertical padding
          ),
          itemCount: pets.length,
          itemBuilder: (context, index) {
            final pet = pets[index];
            return _buildPetItem(
              context,
              pet['title']!,
              pet['subtitle']!,
              pet['buttonText'],
              pet['imagePath']!,
              pet['price'],
              index, // Pass the index to remove the pet later
            );
          },
        ),
      ),
    );
  }


  Widget _buildPetItem(
      BuildContext context,
      String title,
      String subtitle,
      String? buttonText,
      String imagePath,
      String? price,
      int index, // Receive index here
      ) {
    return Card(
      color: Color(0xff6EACDA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imagePath,
                    width: 110,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Color(0xffE2E2B6),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: TextStyle(color: Color(0xff03346E),fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(height: 40),
                      if (price != null)
                        Text(
                          price,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (buttonText != null)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextButton(
                    onPressed: () {
                      _showBottomSheetSell(context, 'Sell', title, index);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Color(0xFFCDDBF7),
                  //   ),
                  //   onPressed: () {
                  //     _showGiftNFTModal(context);
                  //   },
                  //   child: Text(
                  //     "Gift",
                  //     style: TextStyle(color: Colors.deepPurpleAccent),
                  //   ),
                  // ),
                ),
              ),
          ],
        ),
      ),
    );
  }




  void _showBottomSheetSell(
      BuildContext context,
      String actionType,
      String title,
      int index, // Add index here
      ) {
    final TextEditingController priceController = TextEditingController();
    String? enteredPrice;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xff26272B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            Color _buttonColor = Color(0xff03346E);

            void _changeButtonColor() {
              setState(() {
                _buttonColor = Color(0xffE2E2B6);
              });
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'price',
                          labelText: 'Enter the price',
                          focusedLabelColor: Color(0xffE2E2B6),
                          controller: priceController,
                          obscureText: false,
                          backgroundColor: Color(0xff6EACDA), validator: (value) {  }, keyboardType: null,
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomElevatedButton(
                        text: 'Set',
                        onPressed: () {
                          setState(() {
                            enteredPrice = priceController.text;
                          });
                        },
                        backgroundColor: Color(0xff03346E),
                        width: 70,
                        height: 53, style: null, size: 10, foregroundColor: null, shape: null,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (enteredPrice != null)
                    Text(
                      'Price Set: $enteredPrice',
                      style: TextStyle(color: Color(0xffE2E2B6), fontSize: 18),
                    ),
                  SizedBox(height: 5),
                  CustomElevatedButton(
                    text: 'Sell',
                    textColor: Color(0xffE2E2B6),
                    onPressed: () {
                      _changeButtonColor();
                      _sellPet(index); // Remove pet and navigate
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    backgroundColor: _buttonColor,
                    width: 100,
                    height: 54, style: null, size: 12, foregroundColor: null, shape: null,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showGiftNFTModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: EdgeInsets.all(16.0),
          child: GiftNFTForm(scrollController: ScrollController()),
        );
      },
    );
  }
}
