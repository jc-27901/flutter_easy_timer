import 'package:flutter/material.dart';
import 'package:flutter_easy_timer/flutter_easy_timer.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer Widget Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DefaultTimerDemo(),
    CustomColorDemo(),
    GlassUIDemo(),
    ManualStartDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer Widget'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Default',
          ),
          NavigationDestination(
            icon: Icon(Icons.palette_outlined),
            selectedIcon: Icon(Icons.palette),
            label: 'Custom',
          ),
          NavigationDestination(
            icon: Icon(Icons.blur_on_outlined),
            selectedIcon: Icon(Icons.blur_on),
            label: 'Glass UI',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            selectedIcon: Icon(Icons.play_circle),
            label: 'Manual',
          ),
        ],
      ),
    );
  }
}

class DefaultTimerDemo extends StatelessWidget {
  const DefaultTimerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.shade900,
            Colors.deepPurple.shade700,
          ],
        ),
      ),
      child: Center(
        child: FlutterEasyTimerWidget(
          durationSeconds: 60,
          title: 'Default Timer',
          onFinished: () {
            print('Timer finished!');
          },
        ),
      ),
    );
  }
}

class CustomColorDemo extends StatelessWidget {
  const CustomColorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.shade900,
            Colors.red.shade700,
          ],
        ),
      ),
      child: Center(
        child: FlutterEasyTimerWidget(
          durationSeconds: 120,
          title: 'Custom Colors',
          size: 320,
          timerColor: Colors.amber,
          boundaryColor: Colors.amberAccent,
          boundaryWidth: 8.0,
          textColor: Colors.white,
          titleColor: Colors.amber.shade100,
          durationTextColor: Colors.amber.shade200,
          timerFontSize: 52,
        ),
      ),
    );
  }
}

class GlassUIDemo extends StatelessWidget {
  const GlassUIDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade300,
            Colors.blue.shade400,
            Colors.teal.shade300,
          ],
        ),
      ),
      child: Center(
        child: FlutterEasyTimerWidget(
          durationSeconds: 180,
          title: 'Glass UI Timer',
          enableGlassUI: true,
          size: 340,
          glassBlurIntensity: 15.0,
          glassOpacity: 0.2,
          glassGradientColors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
          timerColor: Colors.white,
          boundaryColor: Colors.white.withOpacity(0.3),
          boundaryWidth: 2.5,
        ),
      ),
    );
  }
}

class ManualStartDemo extends StatefulWidget {
  const ManualStartDemo({super.key});

  @override
  State<ManualStartDemo> createState() => _ManualStartDemoState();
}

class _ManualStartDemoState extends State<ManualStartDemo> {
  final GlobalKey _timerKey = GlobalKey();
  bool _isStarted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade900,
            Colors.blue.shade700,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterEasyTimerWidget(
              key: _timerKey,
              durationSeconds: 300,
              title: 'Manual Start Timer',
              autoStart: false,
              size: 300,
              timerColor: Colors.lightBlue,
              boundaryColor: Colors.lightBlueAccent,
              onStart: () {
                setState(() {
                  _isStarted = true;
                });
                print('Timer started!');
              },
              onFinished: () {
                setState(() {
                  _isStarted = false;
                });
                print('Timer finished!');
              },
            ),
            const SizedBox(height: 40),
            if (!_isStarted)
              ElevatedButton.icon(
                onPressed: () {
                  // _timerKey.currentState?.start();
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Timer'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}