import 'package:flutter/material.dart';
import '../../models/hadeth_model.dart';
import '../../theme/app_colors.dart';

class HadethDetailsScreen extends StatelessWidget {
  static const String routeName = "hadeth_details";

  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var hadeth = ModalRoute.of(context)?.settings.arguments as HadethModel;

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
              iconTheme: const IconThemeData(color: AppColors.primaryColor),
              centerTitle: true,
              title: Text(
                hadeth.title,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'Janna',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/PNG Images/img_left_corner.png", height: 90),
                      Text(
                        hadeth.title,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 24,
                          fontFamily: 'Janna',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset("assets/PNG Images/img_right_corner.png", height: 90),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      hadeth.content.join("\n"),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        height: 2.0,
                        fontFamily: 'Janna',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}