# AppLoading

[![pub package](https://img.shields.io/pub/v/app_loading.svg)]([https://pub.dev/packages/flutter_app_loading_indicator])
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A customizable, easy-to-use loading overlay for Flutter applications using Lottie animations.

## Features

- 🎭 Lottie animation support for visually appealing loading indicators
- 🎨 Customizable background color for the overlay
- 🔄 Singleton pattern for consistent usage across your app
- 🚀 Simple show/dismiss API with BuildContext extensions for ease of use
- 🛡️ Handles edge cases like multiple show calls or dismissing non-existent overlays
- 📏 Adjustable animation size

## Getting started

To use this package, add `app_loading` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  app_loading: ^1.0.0
```

Then, run:

```
flutter pub get
```

You'll also need to add your Lottie animation file to your `pubspec.yaml`:

```yaml
assets:
  - assets/your_loading_animation.json
```

## Usage

### Initialization

First, initialize AppLoading in your `main.dart` file:

```dart
import 'package:app_loading/app_loading.dart';
import 'package:flutter/material.dart';

void main() {
  AppLoading.initialize(
    lottieAssetName: 'assets/your_loading_animation.json',
    backgroundColor: Colors.black.withOpacity(0.5),
  );
  runApp(MyApp());
}
```

### Showing the loading overlay

You can show the loading overlay from anywhere in your app using the BuildContext extension:

```dart
context.showLoading();
```

If you need to customize the size of the Lottie animation:

```dart
context.showLoading(width: 200, height: 200);
```

### Dismissing the loading overlay

To dismiss the loading overlay:

```dart
context.dismissLoading();
```

## Example

Here's a simple example of how to use AppLoading in a button press:

```dart
import 'package:flutter/material.dart';
import 'package:app_loading/app_loading.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AppLoading Example')),
      body: Center(
        child: ElevatedButton(
          child: Text('Load Data'),
          onPressed: () async {
            context.showLoading();
            try {
              await Future.delayed(Duration(seconds: 3)); // Simulating an async operation
              // Your actual data loading logic here
            } finally {
              context.dismissLoading();
            }
          },
        ),
      ),
    );
  }
}
```

## Advanced Usage

### Custom Initialization

You can customize the AppLoading instance further by passing additional parameters during initialization:

```dart
AppLoading.initialize(
  lottieAssetName: 'assets/your_loading_animation.json',
  backgroundColor: Colors.blue.withOpacity(0.3),
  defaultWidth: 150,
  defaultHeight: 150,
);
```

### Checking Overlay Status

You can check if the overlay is currently visible:

```dart
bool isVisible = AppLoading.instance.isOverlayVisible;
```

## Troubleshooting

If you encounter issues, ensure that:

1. You've properly initialized AppLoading in your `main()` function.
2. Your Lottie asset is correctly referenced in your `pubspec.yaml` file.
3. You're calling `showLoading()` and `dismissLoading()` on a valid `BuildContext`.

## Contributing

Contributions are welcome! If you encounter any bugs or have feature requests, please file an issue on the [GitHub repository](https://github.com/yourusername/app_loading/issues).

For substantial changes, please open an issue first to discuss what you would like to change. Ensure to update tests as appropriate.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Lottie for Flutter](https://pub.dev/packages/lottie) for providing the Lottie animation support.
- [Flutter](https://flutter.dev/) for the amazing cross-platform framework.

---

Made with ❤️ by [Abhishek Kumar](https://github.com/abhiiishek2000)
