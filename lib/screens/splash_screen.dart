import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isIntroShown = prefs.getBool('isIntroShown') ?? false;

    if (!mounted) return;

    if (isIntroShown) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. الخلفية الكبيرة
          Image.asset(
            "assets/PNG Images/background.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // 2. المسجد العلوي (تم التعديل: تصغير وإنزال للأسفل)
          Positioned(
            top: size.height * 0.06, // نزلناه شوية (6% من الشاشة)
            right: 0,
            left: 0,
            child: Image.asset(
              "assets/PNG Images/Mosque-01.png",
              fit: BoxFit.contain, // يحافظ على أبعاد الصورة
              height: size.height * 0.17, // صغرنا الارتفاع ليكون أرشق
            ),
          ),

          // 3. الفانوس
          Positioned(
            top: 0,
            right: 20,
            child: Image.asset(
              "assets/PNG Images/Glow.png",
              height: size.height * 0.25,
              fit: BoxFit.contain,
            ),
          ),

          // 4. الزخرفة اليسرى
          Positioned(
            top: size.height * 0.30,
            left: 0,
            child: Image.asset(
              "assets/PNG Images/Shape-07.png", // تأكدي أن هذه هي الزخرفة اليسرى
              width: size.width * 0.20,
              fit: BoxFit.contain,
            ),
          ),

          // 5. الزخرفة اليمنى السفلية
          Positioned(
            bottom: size.height * 0.15,
            right: 0,
            child: Image.asset(
              "assets/PNG Images/Shape-04.png", // تأكدي أن هذه هي الزخرفة اليمنى
              width: size.width * 0.20,
              fit: BoxFit.contain,
            ),
          ),

          // 6. اللوجو الرئيسي (إسلامي)
          Center(
            child: Image.asset(
              "assets/PNG Images/islami_logo.png",
              width: size.width * 0.40,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/PNG Images/branding.png",
                width: size.width * 0.65,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}