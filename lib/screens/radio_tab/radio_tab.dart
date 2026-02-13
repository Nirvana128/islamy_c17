import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../api/api_manager.dart';
import '../../models/radio_model.dart';
import '../../theme/app_colors.dart';
import 'radio_item.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  int selectedTypeIndex = 0;
  late Future<List<RadioModel>> radioFuture;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    radioFuture = ApiManager.getRadios();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildTabButton("Radio", 0),
              _buildTabButton("Reciters", 1),
            ],
          ),
        ),

        Expanded(
          child: FutureBuilder<List<RadioModel>>(
            future: radioFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading data", style: TextStyle(color: Colors.white)));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No stations found", style: TextStyle(color: Colors.white)));
              }

              var dataList = snapshot.data!;

              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return RadioItem(
                    radioModel: dataList[index],
                    onPlayBtnClick: () async {
                      await audioPlayer.stop();

                      if (dataList[index].isPlaying) {
                        setState(() {
                          dataList[index].isPlaying = false;
                        });
                      } else {
                        setState(() {
                          for (var item in dataList) {
                            item.isPlaying = false;
                          }
                          dataList[index].isPlaying = true;
                        });
                        await audioPlayer.play(UrlSource(dataList[index].url));
                      }
                    },

                    onMuteBtnClick: () {
                      setState(() {
                        dataList[index].isMuted = !dataList[index].isMuted;
                      });
                      if (dataList[index].isMuted) {
                        audioPlayer.setVolume(0);
                      } else {
                        audioPlayer.setVolume(1);
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTypeIndex = index;
            audioPlayer.stop();
            radioFuture = (selectedTypeIndex == 0)
                ? ApiManager.getRadios()
                : ApiManager.getReciters();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selectedTypeIndex == index ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selectedTypeIndex == index ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}