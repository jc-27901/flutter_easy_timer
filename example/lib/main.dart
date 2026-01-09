import 'package:flutter/material.dart';
import 'package:flutter_easy_timer/flutter_easy_timer.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Easy Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
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
  final PageController _pageController = PageController();

  final List<Widget> _pages = const [
    MinimalTimerDemo(),
    WorkoutTimerDemo(),
    GlassMorphismDemo(),
    InteractiveTimerDemo(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            elevation: 0,
            backgroundColor: Colors.grey.shade900.withValues(alpha:0.9),
            indicatorColor: Colors.deepPurple.withValues(alpha:0.3),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.timer_outlined),
                selectedIcon: Icon(Icons.timer),
                label: 'Minimal',
              ),
              NavigationDestination(
                icon: Icon(Icons.fitness_center_outlined),
                selectedIcon: Icon(Icons.fitness_center),
                label: 'Workout',
              ),
              NavigationDestination(
                icon: Icon(Icons.blur_circular_outlined),
                selectedIcon: Icon(Icons.blur_circular),
                label: 'Glass',
              ),
              NavigationDestination(
                icon: Icon(Icons.touch_app_outlined),
                selectedIcon: Icon(Icons.touch_app),
                label: 'Interactive',
              ),
            ],
          ),
        ),
      )
          .animate()
          .slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOut)
          .fadeIn(duration: 400.ms),
    );
  }
}

// 1. Minimal Modern Timer
class MinimalTimerDemo extends StatelessWidget {
  const MinimalTimerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F0F0F),
            const Color(0xFF1A1A1A),
            Colors.deepPurple.shade900.withValues(alpha:0.3),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text(
              'Focus Time',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 200.ms)
                .slideY(begin: -0.3, end: 0),
            const SizedBox(height: 20),
            Text(
              'Deep work session',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha:0.5),
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 400.ms)
                .slideY(begin: -0.3, end: 0),
            const Spacer(),
            FlutterEasyTimerWidget(
              durationSeconds: 150, // 25 minutes
              size: 280,
              timerColor: Colors.deepPurple.shade300,
              boundaryColor: Colors.white.withValues(alpha:0.1),
              boundaryWidth: 1.5,
              textColor: Colors.white,
              timerFontSize: 64,
              durationTextColor: Colors.white.withValues(alpha: 0.4),
              durationFontSize: 24,
              onFinished: () {
                debugPrint('Focus session complete!');
              },
            )
                .animate()
                .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              duration: 800.ms,
              delay: 300.ms,
              curve: Curves.easeOutBack,
            )
                .fadeIn(duration: 600.ms, delay: 300.ms),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha:0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Sessions', '3', Icons.check_circle_outline),
                  _buildStatItem('Streak', '7 days', Icons.local_fire_department_outlined),
                  _buildStatItem('Total', '4.5h', Icons.timer_outlined),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 600.ms)
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha:0.6), size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha:0.5),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// 2. Workout Timer with Vibrant Colors
class WorkoutTimerDemo extends StatelessWidget {
  const WorkoutTimerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF6B6B),
            const Color(0xFFFF8E53),
            const Color(0xFFFFA07A),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                '💪 HIIT WORKOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
            const Spacer(),
            Column(
              children: [
                const Text(
                  'Round 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 1000.ms)
                    .then()
                    .fadeOut(duration: 1000.ms),
                const SizedBox(height: 16),
                FlutterEasyTimerWidget(
                  durationSeconds: 45,
                  title: 'BURPEES',
                  size: 280,
                  timerColor: Colors.white,
                  boundaryColor: Colors.white,
                  boundaryWidth: 6.0,
                  textColor: Colors.white,
                  titleColor: Colors.white,
                  durationTextColor: Colors.white.withValues(alpha:0.8),
                  timerFontSize: 56,
                  titleFontSize: 26,
                  durationFontSize: 28,
                  onFinished: () {
                    debugPrint('Exercise complete!');
                  },
                )
                    .animate()
                    .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                  duration: 600.ms,
                  curve: Curves.easeOut,
                )
                    .fadeIn(duration: 400.ms),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWorkoutButton(Icons.skip_previous, 'Previous'),
                const SizedBox(width: 20),
                _buildWorkoutButton(Icons.pause, 'Pause', isPrimary: true),
                const SizedBox(width: 20),
                _buildWorkoutButton(Icons.skip_next, 'Next'),
              ],
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 400.ms)
                .slideY(begin: 0.5, end: 0),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutButton(IconData icon, String label, {bool isPrimary = false}) {
    return Column(
      children: [
        Container(
          width: isPrimary ? 70 : 60,
          height: isPrimary ? 70 : 60,
          decoration: BoxDecoration(
            color: isPrimary ? Colors.white : Colors.white.withValues(alpha:0.3),
            shape: BoxShape.circle,
            boxShadow: isPrimary
                ? [
              BoxShadow(
                color: Colors.white.withValues(alpha:0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ]
                : null,
          ),
          child: Icon(
            icon,
            color: isPrimary ? const Color(0xFFFF6B6B) : Colors.white,
            size: isPrimary ? 32 : 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha:0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// 3. GlassMorphism Premium Design
class GlassMorphismDemo extends StatelessWidget {
  const GlassMorphismDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
            Color(0xFFf093fb),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha:0.1),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.2, 1.2),
              duration: 3000.ms,
            )
                .then()
                .scale(
              begin: const Offset(1.2, 1.2),
              end: const Offset(1, 1),
              duration: 3000.ms,
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha:0.1),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.3, 1.3),
              duration: 4000.ms,
            )
                .then()
                .scale(
              begin: const Offset(1.3, 1.3),
              end: const Offset(1, 1),
              duration: 4000.ms,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.self_improvement,
                    color: Colors.white,
                    size: 48,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
                  const SizedBox(height: 20),
                  const Text(
                    'Meditation Session',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 200.ms)
                      .slideY(begin: -0.2, end: 0),
                  const SizedBox(height: 60),
                  FlutterEasyTimerWidget(
                    durationSeconds: 90, // 10 minutes
                    enableGlassUI: true,
                    size: 280,
                    glassBlurIntensity: 20.0,
                    glassOpacity: 0.25,
                    glassGradientColors: [
                      Colors.white.withValues(alpha: 0.25),
                      Colors.white.withValues(alpha: 0.1),
                    ],
                    timerColor: Colors.white,
                    boundaryColor: Colors.white.withValues(alpha:0.4),
                    boundaryWidth: 3.0,
                    textColor: Colors.white,
                    timerFontSize: 68,
                    durationTextColor: Colors.white,
                    durationFontSize: 26,
                  )
                      .animate()
                      .scale(
                    begin: const Offset(0.85, 0.85),
                    end: const Offset(1, 1),
                    duration: 1000.ms,
                    delay: 300.ms,
                    curve: Curves.easeOutBack,
                  )
                      .fadeIn(duration: 800.ms, delay: 300.ms),
                  const SizedBox(height: 60),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha:0.3),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.music_note, color: Colors.white, size: 20),
                        SizedBox(width: 12),
                        Text(
                          'Calm Piano Mix',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms)
                      .slideY(begin: 0.3, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Interactive Timer with Manual Control
class InteractiveTimerDemo extends StatefulWidget {
  const InteractiveTimerDemo({super.key});

  @override
  State<InteractiveTimerDemo> createState() => _InteractiveTimerDemoState();
}

class _InteractiveTimerDemoState extends State<InteractiveTimerDemo> {
  final GlobalKey _timerKey = GlobalKey();
  bool _isStarted = false;
  int _selectedMinutes = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1e3c72),
              const Color(0xFF2a5298),
              Colors.cyan.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.alarm, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Text(
                      'Custom Timer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 100.ms)
                    .slideY(begin: -0.3, end: 0),

                const SizedBox(height: 60),

                /// Duration Selector
                if (!_isStarted)
                  Column(
                    children: [
                      const Text(
                        'Select Duration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [1, 5, 10, 15, 30].map((minutes) {
                          final isSelected = _selectedMinutes == minutes;
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedMinutes = minutes;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withValues(alpha:0.2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha:0.3),
                                    width: 2,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                    BoxShadow(
                                      color: Colors.white.withValues(alpha:0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    '$minutes',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.cyan.shade700
                                          : Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                                  .animate()
                                  .scale(
                                begin: const Offset(0.8, 0.8),
                                end: const Offset(1, 1),
                                duration: 400.ms,
                              )
                                  .fadeIn(duration: 400.ms));
                          }).toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'minutes',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 300.ms)
                      .slideY(begin: -0.2, end: 0),

                const SizedBox(height: 40),

                /// Timer
                FlutterEasyTimerWidget(
                  key: _timerKey,
                  durationSeconds: _selectedMinutes * 60,
                  autoStart: false,
                  size: 320,
                  timerColor: Colors.cyanAccent,
                  boundaryColor: Colors.white.withValues(alpha:0.3),
                  boundaryWidth: 4.0,
                  textColor: Colors.white,
                  timerFontSize: 64,
                  durationTextColor: Colors.white.withValues(alpha:0.7),
                  durationFontSize: 28,
                  onStart: () => setState(() => _isStarted = true),
                  onFinished: () => setState(() => _isStarted = false),
                )
                    .animate()
                    .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                )
                    .fadeIn(duration: 600.ms),

                const SizedBox(height: 40),

                /// Start Button
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _isStarted
                            ? Colors.red.withValues(alpha:0.3)
                            : Colors.green.withValues(alpha:0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: _isStarted
                          ? null
                          : () {
                        (_timerKey.currentState as dynamic)?.start();
                      },
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isStarted
                              ? Colors.white.withValues(alpha:0.2)
                              : Colors.white,
                          boxShadow: _isStarted
                              ? null
                              : [
                            BoxShadow(
                              color: Colors.white.withValues(alpha:0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          _isStarted
                              ? Icons.timer
                              : Icons.play_arrow_rounded,
                          size: 60,
                          color: _isStarted
                              ? Colors.white
                              : Colors.cyan.shade700,
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                  duration: 600.ms,
                ),

                const SizedBox(height: 20),

                /// Status Text
                Text(
                  _isStarted ? 'Timer Running...' : 'Tap to Start',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha:0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
