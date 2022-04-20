import 'package:flutter/foundation.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

// this controller returns a token internally
@immutable
class LoadingScreenController {
  final CloseLoadingScreen closeLoadingScreen;
  final UpdateLoadingScreen updateLoadingScreen;

  const LoadingScreenController({
    required this.closeLoadingScreen,
    required this.updateLoadingScreen,
  });
}
