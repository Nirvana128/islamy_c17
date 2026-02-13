import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_colors.dart';
import '../../models/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = "sura_details";

  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as SuraModel;

    if (verses.isEmpty) {
      loadSuraFile(args.index);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/PNG Images/Mosque-02.png",
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),

          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                args.suraNameEn,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'Janna',
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: AppColors.primaryColor),
            ),
            body: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/PNG Images/img_left_corner.png",
                          height: 70),
                      Text(
                        args.suraNameAr,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 28,
                          fontFamily: 'Janna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset("assets/PNG Images/img_right_corner.png",
                          height: 70),
                    ],
                  ),
                ),

                Expanded(
                  child: verses.isEmpty
                      ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor))
                      : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      formatSuraText(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 22,
                        fontFamily: 'Janna',
                        height: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void loadSuraFile(int index) async {
    String content =
    await rootBundle.loadString("assets/Suras/${index + 1}.txt");
    List<String> lines = content.trim().split("\n");
    saveLastRead(index);

    setState(() {
      verses = lines;
    });
  }
  void saveLastRead(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> history = prefs.getStringList('readHistory') ?? [];

    String currentIndex = index.toString();

    if (history.contains(currentIndex)) {
      history.remove(currentIndex);
    }

    history.insert(0, currentIndex);

    if (history.length > 10) {
      history = history.sublist(0, 10);
    }

    await prefs.setStringList('readHistory', history);
  }

  String formatSuraText() {
    String fullSura = "";
    for (int i = 0; i < verses.length; i++) {
      fullSura += "${verses[i]} [${i + 1}] ";
    }
    return fullSura;
  }
}