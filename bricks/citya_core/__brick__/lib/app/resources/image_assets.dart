enum ImageAsset {
  deletedAccountCover('sorry_to_see_you_go'),
  car('car'),
  onboarding1('onboarding_1'),
  onboarding2('onboarding_2'),
  onboarding3('onboarding_3'),
  onboarding4('onboarding_4'),
  onboarding5('onboarding_5'),
  onboarding6('onboarding_6'),
  onboarding7('onboarding_7');

  static const _imgPath = 'assets/images';
  final String path;

  const ImageAsset(String fileName) : path = '$_imgPath/$fileName.png';
}
