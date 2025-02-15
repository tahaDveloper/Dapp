

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widget/customeNavigation/widget_navigation.dart';
import '../../../widget/customeTextFild/Text_Fild.dart';
import '../../../widget/custumeText/widget_Text.dart';
import '../../../widget/elevatedButton/ElevatedButton.dart';
import '../../model/storeModel/StoreViweModel.dart';


class StorePageSelf extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/your_image.png'), // Replace with your image path
            ),
            SizedBox(width: 10),
            Custume_Text(
              text: 'Hi, Anna',
              color: Colors.black,
              Size: 16,
              fontWeight: null,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: '',
              labelText: "Find you needed...",
              obscureText: null,
              validator: (value) {
                // Add your validation logic here
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            Custume_Text(
              text: 'Most Expensive',
              color: Colors.black,
              Size: 18,
              fontWeight: null,
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.69,
                  ),
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(product.url),
                          SizedBox(height: 8),
                          Text(
                            product.Name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(product.Description),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

}

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  ProductCard(
      {required this.image, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(image,
                height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomElevatedButton(
                    text: 'sell',
                    onPressed: () {
                      Get.toNamed("/PetCategoryScreen");
                    },
                    icon: Icons.arrow_forward,
                    size: 18,
                    backgroundColor: Colors.white,
                    foregroundColor: null,
                    shape: null,
                    width: 20,
                    height: 20,
                    style: null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
