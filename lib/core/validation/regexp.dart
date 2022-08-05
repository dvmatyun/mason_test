class RegExpPatterns {
  RegExpPatterns._();

  static final RegExp nonDigitsRegExp = RegExp('[^0-9]');

  static final RegExp phoneNumberRegExp = RegExp(r'^[\+]*[0-9]{8,15}$');

  static final RegExp nonDoubleRegExp = RegExp('[^0-9.]');

  static final RegExp punctuationRegExp = RegExp(r'[\s!"#$%&()*+,\-.\/\\:;<=>?@[\]^_`{|}~]');

  static final RegExp licensePlateRegExp = RegExp(r'[A-Z0-9\-]');

  static final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
