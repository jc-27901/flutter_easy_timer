# 🎯 Easy Timer Widget

[![pub package](https://img.shields.io/pub/v/countdown_timer_widget.svg)](https://pub.dev/packages/flutter_easy_timer)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A beautiful, highly customizable countdown timer widget for Flutter with iOS 26 style glass UI support. Perfect for fitness apps, cooking timers, productivity tools, and any application that needs an elegant countdown display.

## ✨ Features

- ⏱️ **Smooth Animations** - Fluid countdown with beautiful progress indicator
- 🎨 **Fully Customizable** - Control every color, size, and style aspect
- ✨ **Glass UI Mode** - Modern iOS 26 style frosted glass effect
- 🔄 **Flexible Control** - Auto-start or manual start with callbacks
- 📱 **Responsive Design** - Works perfectly on all screen sizes
- 🎯 **Event Callbacks** - Get notified when timer starts or finishes
- 🌈 **Gradient Support** - Beautiful gradient backgrounds in glass mode
- 💪 **Performance Optimized** - Efficient rendering with minimal overhead

## 📸 Screenshots

| Default Timer | Custom Colors | Glass UI | Manual Start |
|--------------|---------------|----------|--------------|
| ![Default](screenshots/default.png) | ![Custom](screenshots/custom.png) | ![Glass](screenshots/glass.png) | ![Manual](screenshots/manual.png) |

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_easy_timer: ^1.0.0
```

Then run:

```bash
flutter pub get
```

Or install it from the command line:

```bash
flutter pub add flutter_easy_timer
```

## 🚀 Quick Start

Import the package:

```dart
import 'package:flutter_easy_timer/flutter_easy_timer.dart';
```

Use the widget:

```dart
FlutterEasyTimerWidget(
  durationSeconds: 60,
  title: 'Workout Timer',
)
```

That's it! The timer will start automatically.

## 📖 Usage Examples

### 1️⃣ Basic Usage

The simplest way to use the flutter easy timer:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_easy_timer/flutter_easy_timer.dart';

class MyTimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterEasyTimerWidget(
          durationSeconds: 60, // 1 minute
          title: 'Basic Timer',
        ),
      ),
    );
  }
}
```

### 2️⃣ Custom Colors & Styling

Personalize your timer with custom colors:

```dart
FlutterEasyTimerWidget(
  durationSeconds: 300, // 5 minutes
  title: 'Meditation Timer',
  
  // Customize colors
  timerColor: Colors.teal,
  boundaryColor: Colors.tealAccent,
  textColor: Colors.white,
  titleColor: Colors.teal.shade100,
  durationTextColor: Colors.teal.shade200,
  
  // Customize sizes
  size: 350,
  boundaryWidth: 8.0,
  timerFontSize: 52,
  titleFontSize: 28,
  durationFontSize: 36,
)
```

### 3️⃣ Glass UI Mode (iOS 26 Style) ✨

Create a stunning frosted glass effect:

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.purple.shade300,
        Colors.blue.shade400,
        Colors.teal.shade300,
      ],
    ),
  ),
  child: Center(
    child: FlutterEasyTimerWidget(
      durationSeconds: 180, // 3 minutes
      title: 'Glass Timer',
      
      // Enable glass UI
      enableGlassUI: true,
      
      // Customize glass effect
      glassBlurIntensity: 15.0,
      glassOpacity: 0.2,
      glassGradientColors: [
        Colors.white.withOpacity(0.2),
        Colors.white.withOpacity(0.1),
      ],
      
      // Glass UI styling
      timerColor: Colors.white,
      boundaryColor: Colors.white.withOpacity(0.3),
      boundaryWidth: 2.5,
    ),
  ),
)
```

**Pro Tip:** Glass UI looks best with gradient backgrounds!

### 4️⃣ Manual Start with Callbacks

Control when the timer starts and get notified of events:

```dart
class ManualTimerPage extends StatefulWidget {
  @override
  State<ManualTimerPage> createState() => _ManualTimerPageState();
}

class _ManualTimerPageState extends State<ManualTimerPage> {
  final GlobalKey _timerKey = GlobalKey();
  bool _hasStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterEasyTimerWidget(
              key: _timerKey,
              durationSeconds: 600, // 10 minutes
              title: 'Study Timer',
              autoStart: false, // Don't start automatically
              
              // Callbacks
              onStart: () {
                setState(() => _hasStarted = true);
                print('Timer started!');
                // You can play a sound, show a notification, etc.
              },
              onFinished: () {
                setState(() => _hasStarted = false);
                print('Timer finished!');
                // Show completion dialog, play alarm sound, etc.
              },
            ),
            
            SizedBox(height: 40),
            
            if (!_hasStarted)
              ElevatedButton.icon(
                onPressed: () {
                  _timerKey.currentState?.start();
                },
                icon: Icon(Icons.play_arrow),
                label: Text('Start Timer'),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 5️⃣ Different Time Formats

The timer automatically formats time based on duration:

```dart
// Shows as MM:SS (e.g., 05:30)
FlutterEasyTimerWidget(durationSeconds: 330)

// Shows as HH:MM:SS (e.g., 01:30:00)
FlutterEasyTimerWidget(durationSeconds: 5400)
```

### 6️⃣ Multiple Timers

Use multiple timers on the same screen:

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    FlutterEasyTimerWidget(
      durationSeconds: 60,
      title: 'Exercise',
      size: 200,
      timerColor: Colors.red,
    ),
    FlutterEasyTimerWidget(
      durationSeconds: 30,
      title: 'Rest',
      size: 200,
      timerColor: Colors.green,
    ),
  ],
)
```

### 7️⃣ Dark Mode Support

The timer automatically adapts to your app's theme:

```dart
// Light mode
FlutterEasyTimerWidget(
  durationSeconds: 120,
  timerColor: Colors.blue,
  boundaryColor: Colors.blue.shade700,
)

// Dark mode
FlutterEasyTimerWidget(
  durationSeconds: 120,
  timerColor: Colors.blue.shade300,
  boundaryColor: Colors.blue.shade500,
)
```

### 8️⃣ Fitness App Example

A complete workout timer:

```dart
class WorkoutTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade800, Colors.red.shade900],
          ),
        ),
        child: Center(
          child: FlutterEasyTimerWidget(
            durationSeconds: 1800, // 30 minutes
            title: '💪 HIIT WORKOUT',
            size: 320,
            timerColor: Colors.yellow,
            boundaryColor: Colors.yellowAccent,
            boundaryWidth: 10.0,
            textColor: Colors.white,
            titleColor: Colors.yellow.shade100,
            timerFontSize: 56,
            titleFontSize: 32,
            onFinished: () {
              // Play completion sound
              // Show congratulations dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('🎉 Workout Complete!'),
                  content: Text('Great job! Time to cool down.'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

## 🎛️ API Reference

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `durationSeconds` | `int` | ✅ Yes | - | Duration of the countdown in seconds |
| `autoStart` | `bool` | ❌ No | `true` | Whether to start timer automatically |
| `onStart` | `VoidCallback?` | ❌ No | `null` | Callback invoked when timer starts |
| `onFinished` | `VoidCallback?` | ❌ No | `null` | Callback invoked when timer finishes |
| `title` | `String?` | ❌ No | `null` | Optional title displayed above timer |
| `size` | `double` | ❌ No | `300` | Outer circle diameter in pixels |
| `enableGlassUI` | `bool` | ❌ No | `false` | Enable iOS 26 style glass UI effect |

### Color Customization

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `timerColor` | `Color?` | Theme's `onPrimary` | Color of progress indicator |
| `boundaryColor` | `Color?` | Theme's `onSurface` | Color of outer border |
| `textColor` | `Color?` | Theme's `onPrimary` | Color of timer text |
| `titleColor` | `Color?` | Theme's `onPrimary` | Color of title text |
| `durationTextColor` | `Color?` | `onPrimary` with 60% opacity | Color of total duration text |

### Size Customization

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `boundaryWidth` | `double?` | `6.0` (default) / `2.0` (glass) | Width of outer border |
| `timerFontSize` | `double?` | `48` | Font size of main timer |
| `titleFontSize` | `double?` | `24` | Font size of title |
| `durationFontSize` | `double?` | `32` | Font size of duration text |

### Glass UI Customization

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `glassBlurIntensity` | `double` | `10.0` | Blur intensity for glass effect |
| `glassOpacity` | `double` | `0.15` | Opacity of glass container |
| `glassGradientColors` | `List<Color>?` | White with opacity | Gradient colors for glass background |

### Methods

| Method | Description |
|--------|-------------|
| `start()` | Manually start the countdown timer |

**Note:** To call `start()`, you need to provide a `GlobalKey`:

```dart
final timerKey = GlobalKey();

FlutterEasyTimerWidget(
  key: timerKey,
  autoStart: false,
  ...
)

// Later, to start:
timerKey.currentState?.start();
```

## 💡 Tips & Best Practices

### 1. Choosing the Right Size

- **Small devices (phones):** Use `size: 250-300`
- **Tablets:** Use `size: 350-400`
- **Large screens:** Use `size: 400+`

### 2. Color Combinations

For best readability:
- Use high contrast between `timerColor` and `textColor`
- Make sure `boundaryColor` complements your background
- In glass UI mode, lighter colors (white/pastels) work best

### 3. Glass UI Guidelines

- Always use a gradient or colorful background
- Adjust `glassBlurIntensity` between 10-20 for best effect
- Keep `glassOpacity` between 0.1-0.3 for subtle transparency
- Use light colors for text and progress indicator

### 4. Performance

- Avoid nesting timers in heavy rebuild widgets
- Use `const` constructor where possible
- Consider using `AutomaticKeepAliveClientMixin` for tab views

### 5. Accessibility

- Provide meaningful `title` text for screen readers
- Ensure color contrast meets WCAG guidelines
- Consider adding haptic feedback in callbacks

## 🔧 Troubleshooting

### Timer not starting?

Make sure `autoStart` is `true` (default) or call `start()` manually.

### Colors not showing?

Check that you're not in a context where theme colors override your custom colors.

### Glass effect not visible?

Glass UI requires a colorful background to show the blur effect properly.

### Timer not updating?

Ensure the widget is not being rebuilt excessively. Use `const` constructors for parent widgets.

## 🎨 Design Inspiration

This widget is inspired by:
- iOS 26 design language
- Apple Watch workout timers
- Modern fitness and productivity apps
- Material Design 3 principles

## 📱 Platform Support

| Platform | Supported |
|----------|-----------|
| Android | ✅ Yes |
| iOS | ✅ Yes |
| Web | ✅ Yes |
| macOS | ✅ Yes |
| Linux | ✅ Yes |
| Windows | ✅ Yes |

## 🤝 Contributing

Contributions are welcome! If you find a bug or want to add a feature:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Thanks to the Flutter team for the amazing framework
- Inspired by iOS design principles
- Community feedback and contributions

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/jc-27901/flutter_easy_timer/issues)
- **Email:** jaychhatrola27@gmail.com
- **Documentation:** [Full API Docs](https://pub.dev/documentation/flutter_easy_timer/latest/)

## ⭐ Show Your Support

If you like this package, please give it a ⭐ on [GitHub](https://github.com/jc-27901/flutter_easy_timer) and a 👍 on [pub.dev](https://pub.dev/packages/flutter_easy_timer)!

---

Made with ❤️ by Jayyy