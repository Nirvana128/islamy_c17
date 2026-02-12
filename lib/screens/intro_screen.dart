import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = "intro_screen";
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  final List<IntroModel> pages = [
    IntroModel(
      imagePath: "assets/PNG Images/Group.png",
      title: "Welcome To Islami App",
      description: "",
    ),
    IntroModel(
      imagePath: "assets/PNG Images/kabba.png",
      title: "Welcome To Islami",
      description: "We Are Very Excited To Have You In Our Community",
    ),
    IntroModel(
      imagePath: "assets/PNG Images/welcome.png",
      title: "Reading the Quran",
      description: "Read, and your Lord is the Most Generous",
    ),
    IntroModel(
      imagePath: "assets/PNG Images/bearish.png",
      title: "Bearish",
      description: "Praise the name of your Lord, the Most High",
    ),
    IntroModel(
      imagePath: "assets/PNG Images/radio.png",
      title: "Holy Quran Radio",
      description: "You can listen to the Holy Quran Radio through the application for free and easily",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Color primaryColor = const Color(0xFFE2BE7F);
    Color backgroundColor = const Color(0xFF202020);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/PNG Images/logo.png",
                width: size.width * 0.75,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              pages[index].imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          pages[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        if (pages[index].description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              pages[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentIndex == 0
                        ? const TextButton(onPressed: null, child: Text(""))
                        : TextButton(
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ),

                    SmoothPageIndicator(
                      controller: _controller,
                      count: pages.length,
                      effect: ScrollingDotsEffect(
                        activeDotColor: primaryColor,
                        dotColor: Colors.grey.shade700,
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        if (currentIndex == pages.length - 1) {
                          _finishOnboarding();
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        currentIndex == pages.length - 1 ? "Finish" : "Next",
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isIntroShown', true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}

class IntroModel {
  final String title;
  final String description;
  final String imagePath;

  IntroModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}