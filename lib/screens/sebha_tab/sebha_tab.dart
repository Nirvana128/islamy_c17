import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_colors.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  double rotationAngle = 0;
  int index = 0;
  List<dynamic> tasbeehList = [];

  @override
  void initState() {
    super.initState();
    loadAzkarFile();
  }

  void loadAzkarFile() async {
    try {
      String content = await rootBundle.loadString("assets/azkar.json");
      Map<String, dynamic> jsonMap = jsonDecode(content);
      setState(() {
        tasbeehList = jsonMap["تسابيح"];
      });
    } catch (e) {
      debugPrint("Error loading json: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String currentZekr = tasbeehList.isNotEmpty ? tasbeehList[index]['content'] : "سبحان الله";

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          "سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 26,
            fontFamily: 'Janna',
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: _onSebhaTap,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -size.height * 0.10,
                    child: Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: Image.asset(
                        "assets/PNG Images/Group 37.png",
                        height: size.height * 0.12,
                      ),
                    ),
                  ),

                  Transform.rotate(
                    angle: rotationAngle,
                    child: Image.asset(
                      "assets/PNG Images/SebhaBody 1.png",
                      height: size.height * 0.40,
                    ),
                  ),

                  SizedBox(
                    width: size.width * 0.50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentZekr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna',
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "$counter",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onSebhaTap() {
    setState(() {
      counter++;
      rotationAngle += (2 * pi) / 31;
      if (counter == 31) {
        counter = 0;
        index++;
        rotationAngle = 0;
        if (index == tasbeehList.length) {
          index = 0;
        }
      }
    });
  }
}