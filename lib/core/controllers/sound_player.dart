import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_mason/app/resources/sound_assets.dart';

class SoundPlayer {
  final AudioPlayer _audioPlayer;

  SoundPlayer({AudioPlayer? audioPlayer}) : _audioPlayer = audioPlayer ?? AudioPlayer();

  void playSound(SoundAsset asset) {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource(asset.path));
  }
}
