import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart'; // وارد کردن این پکیج برای شناسایی پلتفرم‌ها

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Get.toNamed("PrivateKeyScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    // تشخیص پلتفرم و تعیین عکس مربوطه
    String imagePath;
    if (kIsWeb) {
      imagePath = 'assets/image/DALL·E 2024-12-14 14.24.41 - A vibrant and futuristic metaverse game environment, combining a sci-fi cityscape with neon-lit streets. One area features holographic poker tables wi.png'; // مسیر عکس وب
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      imagePath = 'assets/image/pixlr-image-generator-674722617c55655b3083c7d3.png'; // مسیر عکس iOS
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      imagePath = 'assets/image/pixlr-image-generator-674722617c55655b3083c7d3.png'; // مسیر عکس اندروید
    } else {
      imagePath = 'assets/image/pixlr-image-generator-674722617c55655b3083c7d3.png'; // عکس پیش‌فرض
    }

    return Scaffold(
      backgroundColor: Colors.white12,
      body: Center(
        child: Image.asset(
          imagePath, // نمایش تصویر مطابق با پلتفرم
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
