import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../widget/customeNavigation/widget_navigation.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hi, Anna'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // نوار جستجو
            SizedBox(height: 16),
            // دسته‌بندی‌ها
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.all(16),
                children: [
                  _buildCategoryItem(
                      'Home', icon: Image.asset("assets/icon/50819 1.png")),
                  _buildCategoryItem(
                      'Accessories', icon: Image.asset("assets/icon/ring.png")),
                  _buildCategoryItem('Furniture', icon: Image.asset(
                      "assets/icon/Living room interior set with couch.png")),
                  _buildCategoryItem(
                      'Gun', icon: Image.asset("assets/icon/33310 1.png")),
                  _buildCategoryItem('Clothes',
                      icon: Image.asset("assets/icon/wedding dress (1).png")),
                  _buildCategoryItem('Digital Tools',
                      icon: Image.asset("assets/icon/empty laptop.png")),
                  _buildCategoryItem('Car',
                      icon: Image.asset("assets/icon/pink retro car.png")),
                  _buildCategoryItem('Pet', icon: Image.asset(
                      "assets/icon/dog in pink dressing sitting.png")),
                ],
              ),
            ),
            // بخش "Most Expensive"
            Text(
              'Most Expensive',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                children: [
                  _buildMostExpensiveItem('Gray 3-seater Sofa', '210 cm',
                      'assets/image/chic-mid-century-modern-luxury-aesthetics-living-room-with-gray-velvet-couch-blue-rug 1.png'),
                  _buildMostExpensiveItem(
                      'Jack Russell dog', '6 months, female',
                      'assets/image/adorable-brown-white-basenji-dog-smiling-giving-high-five-isolated-white 1 (1).png'),
                ],
              ),
            ),
            // پنج دکمه در پایین صفحه
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 2'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 3'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 4'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 5'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, {required Image icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMostExpensiveItem(String title, String subtitle,
      String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 9),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'sell',
                      style: TextStyle(color: Colors.white),
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
