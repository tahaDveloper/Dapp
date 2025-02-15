import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/customeNavigation/widget_navigation.dart';
import '../../viweModel/balance_NFT/balance_NFT.dart';

class ExpensiveItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, // آیکن دلخواه خود را انتخاب کنید
            color: Color(0xffE2E2B6), // رنگ آیکن
          ),
          onPressed: () {
            Get.toNamed("WalletScreen");
            // تابعی برای عملکرد آیکن می‌توانید اضافه کنید
            print("Menu button pressed");
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Color(0xff03346E),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Color(0xff6EACDA)),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          color: Color(0xffE2E2B6)),
                      decoration: InputDecoration(
                          hintText: 'Find you needed...',
                          focusColor: Color(0xffE2E2B6),
                          border: InputBorder.none,
                          fillColor: Color(0xff6EACDA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Categories Section
            GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryItem('Home', 'assets/icon/icons8-home-375.png', () {Get.toNamed("page");}),
                _buildCategoryItem('Jewelry', 'assets/icon/diamond (1).png', () {Get.toNamed("page");}),
                _buildCategoryItem('Furniture', 'assets/icon/furniture.png', () {Get.toNamed("page");}),
                _buildCategoryItem('Gun', 'assets/icon/gun (1).png', () {Get.toNamed("page");}),
                _buildCategoryItem('Clothes', 'assets/icon/3d-design.png', () {Get.toNamed("page");}),
                _buildCategoryItem('Digital Tools', 'assets/icon/download.jpg', () {Get.toNamed("page");}),
                _buildCategoryItem('Car', 'assets/icon/3d-car.png', () {Get.toNamed("page");}),
                _buildCategoryItem('Pet', 'assets/icon/shiba-inu_10118959.png', () {Get.toNamed("/PetCategoryView");}),
              ],



            ),
            SizedBox(height: 20),
            // Most Expensive Section
            Text(
              'Most Expensive',
              style: TextStyle(
                color: Color(0xffE2E2B6),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // اسکرول افقی
            Container(
              height: 250, // ارتفاع برای نمایش آیتم‌ها
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProductItem('Gray 3-seater Sofa', '210 cm', ''),
                  _buildProductItem('Jack Russell dog', '6 months, female', ''),
                  _buildProductItem('Volvo XC90 Inscription', '2017', ''),
                  _buildProductItem('PCP gun Kural Super Jumbo', '', ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imagePath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xff6EACDA),
            radius: 30,
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.contain,  // Adjusted fit to BoxFit.cover
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(color: Color(0xffE2E2B6), fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(String title, String subtitle, String imagePath) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10), // فاصله بین آیتم‌ها
      child: Card(
        color: Color(0xff6EACDA),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(color: Color(0xffE2E2B6), fontSize: 12),
              ),
              SizedBox(height: 5),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: TextStyle(color:Color(0xff03346E), fontSize: 12),
                ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffE2E2B6),
                  ),
                  child: Text('Sell', style: TextStyle(color: Color(0xff03346E),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
