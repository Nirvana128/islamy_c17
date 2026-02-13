import 'package:flutter/material.dart';
import '../../models/radio_model.dart';
import '../../theme/app_colors.dart';

class RadioItem extends StatelessWidget {
  final RadioModel radioModel;
  final VoidCallback onPlayBtnClick;
  final VoidCallback onMuteBtnClick;

  const RadioItem({
    super.key,
    required this.radioModel,
    required this.onPlayBtnClick,
    required this.onMuteBtnClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: radioModel.isPlaying
                ? _buildSoundWaveImage()
                : _buildMosqueImage(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Text(
                radioModel.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Janna',
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onPlayBtnClick,
                  icon: Icon(
                    radioModel.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    size: 50,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(width: 16),
                IconButton(
                  onPressed: onMuteBtnClick,
                  icon: Icon(
                    radioModel.isMuted ? Icons.volume_off : Icons.volume_up_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMosqueImage() {
    return Opacity(
      opacity: 0.3,
      child: Image.asset(
        "assets/PNG Images/Mosque-02.png",
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
  Widget _buildSoundWaveImage() {
    return Opacity(
      opacity: 0.6,
      child: Image.asset(
        "assets/PNG Images/soundWave 1.png",
        height: 70,
        fit: BoxFit.contain,
        // color: Colors.black,
      ),
    );
  }
}