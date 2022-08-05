enum SoundAsset {
  newRide('new_ride.aac');

  static const _soundsPath = 'sounds'; // audio player library assumes 'assets/' prefix by default
  final String path;

  const SoundAsset(String fileName) : path = '$_soundsPath/$fileName';
}
