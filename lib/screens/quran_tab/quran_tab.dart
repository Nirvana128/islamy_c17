import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_assets.dart';
import '../../models/sura_model.dart';
import 'sura_details_screen.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<SuraModel> searchResults = [];
  List<int> lastReadIndices = [];

  @override
  void initState() {
    super.initState();
    _loadAllSuras();
    loadLastReads();
  }
  void loadLastReads() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('readHistory') ?? [];

    setState(() {
      lastReadIndices = history.map((e) => int.parse(e)).toList();
    });
  }

  void _loadAllSuras() {
    searchResults = List.generate(
      SuraModel.suraNamesAr.length,
          (index) => SuraModel.getSuraModel(index),
    );
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _loadAllSuras();
      });
    } else {
      setState(() {
        searchResults = List.generate(
          SuraModel.suraNamesAr.length,
              (index) => SuraModel.getSuraModel(index),
        ).where((sura) {
          return sura.suraNameEn.toLowerCase().contains(query.toLowerCase()) ||
              sura.suraNameAr.contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: _onSearch,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Janna',
              fontSize: 16,
            ),
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              hintText: "Sura Name",
              hintStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna',
                fontSize: 16,
              ),
              prefixIcon: const ImageIcon(AssetImage(AppAssets.iconQuran),
                  color: AppColors.primaryColor),
              filled: true,
              fillColor: const Color.fromARGB(150, 32, 32, 32),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
          if (searchResults.length == SuraModel.suraNamesAr.length &&
              lastReadIndices.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              "Most Recently",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Janna'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: lastReadIndices.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return _buildRecentCard(context, lastReadIndices[index]);
                },
              ),
            ),
          ],

          const SizedBox(height: 20),
          const Text(
            "Suras List",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna'),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: searchResults.isEmpty
                ? const Center(
                child: Text("No Results Found",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Janna')))
                : ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: searchResults.length,
              separatorBuilder: (context, index) => const Divider(
                  color: Colors.white30, indent: 40, endIndent: 40),
              itemBuilder: (context, index) {
                return _buildFilteredSuraItem(
                    context, searchResults[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilteredSuraItem(BuildContext context, SuraModel sura) {
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, SuraDetailsScreen.routeName,
            arguments: sura);
        loadLastReads();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppAssets.starIcon, width: 50, height: 50),
                Text(
                  "${sura.index + 1}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Janna',
                      fontSize: 16),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sura.suraNameEn,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Janna',
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("${sura.verses} Verses",
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna')),
              ],
            ),
            const Spacer(),
            Text(sura.suraNameAr,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Janna',
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCard(BuildContext context, int index) {
    var sura = SuraModel.getSuraModel(index);
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, SuraDetailsScreen.routeName,
            arguments: sura);
        loadLastReads();
      },
      child: Container(
        width: 285,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sura.suraNameEn,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna')),
                    Text(sura.suraNameAr,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Janna',
                            fontWeight: FontWeight.bold)),
                    Text("${sura.verses} Verses",
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna')),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(AppAssets.mostRecentImage,
                    fit: BoxFit.contain)),
          ],
        ),
      ),
    );
  }
}