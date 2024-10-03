import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoading {
  static AppLoading? _instance;
  String lottieAssetName;
  Color backgroundColor;
  double height;
  double width;
  OverlayEntry? _overlay;
  late Future<LottieComposition> _compositionFuture;
  bool _isOverlayVisible = false;

  factory AppLoading(
      {required String lottieAssetName,
      Color backgroundColor = const Color.fromARGB(209, 24, 0, 46),
      double height = 80,
      double width = 80}) {
    _instance ??=
        AppLoading._internal(lottieAssetName, backgroundColor, height, width);
    return _instance!;
  }

  AppLoading._internal(
      this.lottieAssetName, this.backgroundColor, this.height, this.width) {
    _compositionFuture = _loadAnimation();
  }

  Future<LottieComposition> _loadAnimation() async {
    return await AssetLottie(lottieAssetName).load();
  }

  void show(BuildContext context) {
    if (_overlay == null && !_isOverlayVisible) {
      final overlay = Overlay.of(context, rootOverlay: true);
      if (overlay == null) {
        debugPrint('No overlay found. Cannot display loading indicator.');
        return;
      }
      _isOverlayVisible = true;
      _overlay = OverlayEntry(
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: backgroundColor,
          child: Center(
            child: FutureBuilder<LottieComposition>(
              future: _compositionFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Lottie(
                    composition: snapshot.data!,
                    frameRate: FrameRate.max,
                    repeat: true,
                    animate: true,
                    width: width,
                    height: height,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        overlay.insert(_overlay!);
        debugPrint('Overlay is now visible.');
      });
    } else {
      debugPrint('Overlay is already visible.');
    }
  }

  void dismiss() {
    if (_overlay != null && _isOverlayVisible) {
      debugPrint('Dismissing overlay...');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          _overlay?.remove();
          _overlay = null;
          _isOverlayVisible = false;
          debugPrint('Overlay dismissed successfully.');
        } catch (e, stackTrace) {
          debugPrint('Error while removing overlay: $e\n$stackTrace');
        }
      });
    } else {
      debugPrint('Attempted to dismiss overlay, but it is not visible.');
    }
  }

  static void initialize(
      {required String lottieAssetName,
      Color backgroundColor = const Color.fromARGB(209, 24, 0, 46),
      double height = 80,
      double width = 80}) {
    _instance =
        AppLoading._internal(lottieAssetName, backgroundColor, height, width);
  }

  static AppLoading get instance {
    if (_instance == null) {
      throw StateError('AppLoading must be initialized before use.');
    }
    return _instance!;
  }
}

extension LoadingOverlayExtension on BuildContext {
  void showLoading({double? width, double? height}) =>
      AppLoading.instance.show(this);

  void dismissLoading() => AppLoading.instance.dismiss();

  bool get isLoading => AppLoading.instance._isOverlayVisible;
}
