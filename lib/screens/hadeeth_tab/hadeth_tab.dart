import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/hadeth_model.dart';
import '../../theme/app_colors.dart';
import 'hadeth_details_screen.dart';

class HadethTab extends StatefulWidget {
  const HadethTab({super.key});

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  List<HadethModel> allHadeth = [];

  @override
  void initState() {
    super.initState();
    loadHadethFiles();
  }

  void loadHadethFiles() async {
    List<HadethModel> hadethList = [];
    for (int i = 1; i <= 50; i++) {
      try {
        String content = await rootBundle.loadString("assets/Hadeeth/h$i.txt");
        List<String> lines = content.trim().split("\n");
        if (lines.isNotEmpty) {
          String title = lines[0];
          lines.removeAt(0);
          hadethList.add(HadethModel(title: title, content: lines));
        }
      } catch (e) {
        debugPrint("Error loading h$i.txt");
      }
    }
    setState(() {
      allHadeth = hadethList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: allHadeth.isEmpty
              ? const Center(
              child:
              CircularProgressIndicator(color: AppColors.primaryColor))
              : CarouselSlider.builder(
            itemCount: allHadeth.length,
            itemBuilder: (context, index, realIndex) {
              return _buildHadethCard(allHadeth[index]);
            },
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 0.75,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHadethCard(HadethModel hadeth) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          HadethDetailsScreen.routeName,
          arguments: hadeth,
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/PNG Images/HadithCardBackGround.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/PNG Images/Mosque-02.png",
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/PNG Images/left_corner.png",
                height: 130,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/PNG Images/right_corner.png",
                height: 130,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 60, bottom: 90, left: 20, right: 20),
              child: Column(
                children: [
                  Text(
                    hadeth.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Janna',
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Text(
                      hadeth.content.join(" "),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 20,
                      style: const TextStyle(
                        fontFamily: 'Janna',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.3,
                      ),
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