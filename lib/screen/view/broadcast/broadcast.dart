import 'package:flutter/material.dart';
import '../../../widget/customeNavigation/widget_navigation.dart';

class Broadcast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17191D),
      appBar: AppBar(
        backgroundColor: Color(0xff17191D),
        title: Text(
          'Live Feed',
          style: TextStyle(color: Color(0xffE2E2B6)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // اضافه کردن اسکرول عمودی
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // فرض کنید broadcastCard یک تابع یا ویجت دیگر برای نمایش کارت‌ها است
              broadcastCard(),
              SizedBox(height: 40),
              Text(
                'Live Feed'  ,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffE2E2B6),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  // کارت‌های نمایش داده شده
                  buildCard("Live Poker", 'assets/image/freepik__3d-model-octane-render-volumetric-highly-detailed-__85210.jpeg'),
                  buildCard("Courtroom", 'assets/image/image1_0.jpg'),
                  buildCard("Arena", 'assets/image/ezgif-2-b1a99e6cb6.png'),
                ],
              ),
            ]
            ,
          ),
        ),
      ),
      bottomNavigationBar: Navigation(),
    );
  }

  // تابعی برای ساخت کارت‌ها
  Widget buildCard(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 350, // عرض کارت
        height: 200, // ارتفاع کارت
        decoration: BoxDecoration(
          color: Color(0xff03346E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // بخش تصویر در سمت چپ
            Container(
              width: 200, // عرض تصویر
              height: 200, // ارتفاع تصویر
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    offset: Offset(8, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            // بخش توضیحات در سمت راست
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xffE2E2B6),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "",
                      style: TextStyle(color: Color(0xffE2E2B6), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class broadcastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage('assets/image/5872854524849407812.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -7),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
          onPressed: () {
            // افزودن عملکرد پخش ویدیو
          },
        ),
      ],
    );
  }
}
