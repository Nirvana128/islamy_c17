import 'package:flutter/material.dart';
import '../../api/api_manager.dart';
import '../../models/prayer_time_model.dart';
import '../../theme/app_colors.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  late Future<PrayerTimeModel> prayerFuture;

  final List<Map<String, String>> azkarData = [
    {
      "title": "Evening Azkar",
      "image": "assets/PNG Images/bell-icon 1.png"
    },
    {
      "title": "Morning Azkar",
      "image": "assets/PNG Images/comment-bubble-icon 1.png"
    },
    {
      "title": "Waking Azkar",
      "image": "assets/PNG Images/document-icon 1.png"
    },
    {
      "title": "Sleeping Azkar",
      "image": "assets/PNG Images/document-icon 1 (1).png"
    },
  ];

  @override
  void initState() {
    super.initState();
    prayerFuture = ApiManager.getPrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PrayerTimeModel>(
      future: prayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Error loading times", style: TextStyle(color: Colors.white)),
                IconButton(
                    onPressed: () => setState(() { prayerFuture = ApiManager.getPrayerTimes(); }),
                    icon: const Icon(Icons.refresh, color: AppColors.primaryColor)
                )
              ],
            ),
          );
        }

        var data = snapshot.data!;
        String currentPrayer = "Asr";

        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE5C487), Color(0xFFD6B06D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          "assets/PNG Images/Glow.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDateBadge(data.readableDate, "Date"),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text("Pray Time", style: TextStyle(fontSize: 16, color: Color(0xFF856B3F))),
                                  const SizedBox(height: 5),
                                  Text(data.dayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF202020))),
                                ],
                              ),
                            ),
                            _buildDateBadge("${data.hijriDate} ${data.hijriMonth}", "Hijri"),
                          ],
                        ),

                        const SizedBox(height: 25),
                        SizedBox(
                          height: 140,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              _buildPrayerItem("Fajr", data.fajr, currentPrayer == "Fajr"),
                              _buildPrayerItem("Dhuhr", data.dhuhr, currentPrayer == "Dhuhr"),
                              _buildPrayerItem("Asr", data.asr, currentPrayer == "Asr"),
                              _buildPrayerItem("Maghrib", data.maghrib, currentPrayer == "Maghrib"),
                              _buildPrayerItem("Isha", data.isha, currentPrayer == "Isha"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Next Pray - 02:32",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF4F3917)),
                            ),
                            const SizedBox(width: 50),
                            Icon(Icons.volume_off, color: const Color(0xFF4F3917).withOpacity(0.8), size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: const Text(
                "Azkar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: azkarData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    return _buildAzkarCard(
                      azkarData[index]["title"]!,
                      azkarData[index]["image"]!,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _buildDateBadge(String date, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF856B3F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          const SizedBox(height: 4),
          Text(date, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
  Widget _buildPrayerItem(String name, String time, bool isSelected) {
    String cleanTime = time.split(" ")[0];
    String period = (int.tryParse(cleanTime.split(":")[0]) ?? 0) >= 12 ? "PM" : "AM";
    if (name == "Fajr") period = "AM";

    return Container(
      width: 85,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: isSelected
            ? const LinearGradient(
          colors: [Color(0xFF404040), Color(0xFF202020)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
            : const LinearGradient(
          colors: [Color(0xFFBCA073), Color(0xFF8D7344)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: isSelected ? Border.all(color: Colors.white24, width: 1) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          Text(cleanTime, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(period, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
  Widget _buildAzkarCard(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF202020),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              top: 15,
              child: Image.asset(imagePath, height: 180, fit: BoxFit.contain)
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 26),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}