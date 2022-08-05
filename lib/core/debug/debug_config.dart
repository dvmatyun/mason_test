const debugFakeHttpDelayMs = 300;

Future<void> debugFakeDelayFuture({int milliseconds = debugFakeHttpDelayMs}) =>
    Future.delayed(Duration(milliseconds: milliseconds));
