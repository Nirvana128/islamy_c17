import 'package:flutter/material.dart';
import 'package:islamy1/screens/sebha_tab/sebha_tab.dart';
import '../theme/app_assets.dart';
import '../theme/app_colors.dart';
import 'quran_tab/quran_tab.dart';
import 'hadeeth_tab/hadeth_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<String> backgroundImages = [
    AppAssets.background,
    AppAssets.background,
    AppAssets.backgroundsebha,
    AppAssets.background,
    AppAssets.background,
  ];

  List<Widget> tabs = [
    const QuranTab(),
    const HadethTab(),
    const SebhaTab(),
    const Center(child: Text("Radio Screen", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Time Screen", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
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
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.7),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Image.asset(
                    AppAssets.logo,
                    height: size.height * 0.15,
                    fit: BoxFit.contain,
                  ),
                ),

                Expanded(
                  child: tabs[selectedIndex],
                ),
              ],
            ),
          ),

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