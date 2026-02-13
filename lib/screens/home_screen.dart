import 'package:flutter/material.dart';
import '../theme/app_assets.dart';
import '../theme/app_colors.dart';
import 'quran_tab/quran_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // قائمة الخلفيات
  List<String> backgroundImages = [
    AppAssets.background,
    AppAssets.background,
    AppAssets.background,
    AppAssets.background,
    AppAssets.background,
  ];

  List<Widget> tabs = [
    const QuranTab(), // التاب الأول (تم إزالة اللوجو منه في الخطوة القادمة)
    const Center(child: Text("Hadeth Screen", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Sebha Screen", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Radio Screen", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Time Screen", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // لجعل حجم اللوجو متجاوب

    return Stack(
      children: [
        // 1. الخلفية المتحركة
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Image.asset(
            backgroundImages[selectedIndex],
            key: ValueKey<int>(selectedIndex),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,

          // 2. الجسم الرئيسي (تم التعديل هنا)
          body: SafeArea(
            child: Column(
              children: [
                // أ. اللوجو الثابت (Header)
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Image.asset(
                    AppAssets.logo, // تأكدي ان الصورة دي موجودة في Assets
                    height: size.height * 0.15, // ارتفاع 15% من الشاشة
                    fit: BoxFit.contain,
                  ),
                ),

                // ب. المحتوى المتغير (التابات)
                Expanded(
                  child: tabs[selectedIndex], // Expanded عشان ياخد باقي المساحة
                ),
              ],
            ),
          ),

          // 3. شريط التنقل السفلي (كما هو)
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppColors.primaryColor,
            ),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.primaryColor,
              selectedItemColor: AppColors.whiteColor,
              unselectedItemColor: AppColors.blackColor,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.iconQuran)),
                  label: "Quran",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.iconHadeth)),
                  label: "Hadeth",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.iconSebha)),
                  label: "Sebha",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.iconRadio)),
                  label: "Radio",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(AppAssets.iconTime)),
                  label: "Time",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}