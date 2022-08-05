import 'dart:io';

class IgnoreCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
}
