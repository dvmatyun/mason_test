import 'package:logger/logger.dart';

class ProductionPrinter extends PrettyPrinter {
  ProductionPrinter({
    super.errorMethodCount = 30,
    super.methodCount = 0,
    super.noBoxingByDefault = true,
    super.printTime = false,
  });
}
