import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/home_screen.dart';
import 'screens/quran_tab/sura_details_screen.dart';
import 'theme/app_colors.dart';
import 'screens/hadeeth_tab/hadeth_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Janna',
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          titleTextStyle: TextStyle(
              fontFamily: 'Janna',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor
          ),
        ),
      ),

      initialRoute: SplashScreen.routeName,

      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        IntroScreen.routeName: (context) => const IntroScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        SuraDetailsScreen.routeName: (context) => const SuraDetailsScreen(),
        HadethDetailsScreen.routeName: (context) => const HadethDetailsScreen(),
      },
    );
  }
}