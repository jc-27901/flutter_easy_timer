import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class FlutterEasyTimerWidget extends StatefulWidget {
  /// Duration of the timer in seconds
  final int durationSeconds;

  /// Whether to start the timer automatically
  final bool autoStart;

  /// Callback when timer starts
  final VoidCallback? onStart;

  /// Callback when timer finishes
  final VoidCallback? onFinished;

  /// Optional title displayed above the timer
  final String? title;

  /// Outer circle diameter in pixels
  final double size;

  /// Enable iOS 26 style glass UI effect
  final bool enableGlassUI;

  /// Color of the timer progress indicator
  final Color? timerColor;

  /// Color of the outer boundary/border
  final Color? boundaryColor;

  /// Width of the outer boundary/border
  final double? boundaryWidth;

  /// Color of the timer text
  final Color? textColor;

  /// Font size of the main timer text
  final double? timerFontSize;

  /// Color of the title text
  final Color? titleColor;

  /// Font size of the title
  final double? titleFontSize;

  /// Color of the total duration text at bottom
  final Color? durationTextColor;

  /// Font size of the total duration text
  final double? durationFontSize;

  /// Glass UI blur intensity (only applies when enableGlassUI is true)
  final double glassBlurIntensity;

  /// Glass UI opacity (only applies when enableGlassUI is true)
  final double glassOpacity;

  /// Background gradient colors for glass UI (only applies when enableGlassUI is true)
  final List<Color>? glassGradientColors;

  const FlutterEasyTimerWidget({
    super.key,
    required this.durationSeconds,
    this.autoStart = true,
    this.onStart,
    this.onFinished,
    this.title,
    this.size = 300,
    this.enableGlassUI = false,
    this.timerColor,
    this.boundaryColor,
    this.boundaryWidth,
    this.textColor,
    this.timerFontSize,
    this.titleColor,
    this.titleFontSize,
    this.durationTextColor,
    this.durationFontSize,
    this.glassBlurIntensity = 10.0,
    this.glassOpacity = 0.15,
    this.glassGradientColors,
  });

  @override
  State<FlutterEasyTimerWidget> createState() => _FlutterEasyTimerWidgetState();
}

class _FlutterEasyTimerWidgetState extends State<FlutterEasyTimerWidget> {
  late DateTime _endTime;
  late int _totalSeconds;
  Timer? _ticker;
  Duration _remaining = Duration.zero;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.durationSeconds;
    _remaining = Duration(seconds: _totalSeconds);
    _endTime = DateTime.now().add(_remaining);

    if (widget.autoStart) {
      start();
    }
  }

  /// Public method to start the timer manually
  void start() {
    if (_isRunning) return;

    _endTime = DateTime.now().add(_remaining);
    _startTicker();
    _isRunning = true;

    widget.onStart?.call();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!mounted) return;

      final now = DateTime.now();
      final newRemaining = _endTime.difference(now);

      if (newRemaining.isNegative || newRemaining.inMilliseconds <= 0) {
        setState(() {
          _remaining = Duration.zero;
          _isRunning = false;
        });
        _ticker?.cancel();
        widget.onFinished?.call();
        return;
      }

      setState(() {
        _remaining = newRemaining;
      });
    });
  }

  @override
  void didUpdateWidget(covariant FlutterEasyTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.durationSeconds != widget.durationSeconds ||
        oldWidget.autoStart != widget.autoStart) {
      _totalSeconds = widget.durationSeconds;
      _remaining = Duration(seconds: _totalSeconds);
      _endTime = DateTime.now().add(_remaining);
      _ticker?.cancel();
      _isRunning = false;

      if (widget.autoStart) {
        start();
      }
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds >= 3600) {
      final h = seconds ~/ 3600;
      final m = (seconds % 3600) ~/ 60;
      final s = seconds % 60;
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    } else {
      final m = seconds ~/ 60;
      final s = seconds % 60;
      return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
  }

  double get _progress {
    if (_totalSeconds == 0) return 1.0;
    final remainingMs = _remaining.inMilliseconds;
    final totalMs = _totalSeconds * 1000;
    return (1 - remainingMs / totalMs).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.enableGlassUI) {
      return _buildGlassUI(theme);
    } else {
      return _buildDefaultUI(theme);
    }
  }

  Widget _buildDefaultUI(ThemeData theme) {
    final outerSize = widget.size;
    final innerSize = outerSize * (260 / 300);
    final effectiveBoundaryColor = widget.boundaryColor ?? theme.colorScheme.onSurface;
    final effectiveBoundaryWidth = widget.boundaryWidth ?? 6.0;
    final effectiveTimerColor = widget.timerColor ?? theme.colorScheme.onPrimary;
    final effectiveTextColor = widget.textColor ?? theme.colorScheme.onPrimary;
    final effectiveTitleColor = widget.titleColor ?? theme.colorScheme.onPrimary;
    final effectiveDurationTextColor = widget.durationTextColor ?? theme.colorScheme.onPrimary.withOpacity(0.6);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(
            widget.title!,
            style: TextStyle(
              color: effectiveTitleColor,
              fontSize: widget.titleFontSize ?? 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
        ],

        Container(
          height: outerSize,
          width: outerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: effectiveBoundaryColor,
              width: effectiveBoundaryWidth,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: _progress),
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              builder: (context, animatedProgress, _) {
                final reversedProgress = (1 - animatedProgress).clamp(0.0, 1.0);
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: innerSize,
                      width: innerSize,
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        value: reversedProgress,
                        strokeWidth: 20,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(effectiveTimerColor),
                      ),
                    ),
                    Text(
                      _formatTime(_remaining),
                      style: TextStyle(
                        color: effectiveTextColor,
                        fontSize: widget.timerFontSize ?? 48,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        Text(
          _formatTime(Duration(seconds: _totalSeconds)),
          style: TextStyle(
            color: effectiveDurationTextColor,
            fontSize: widget.durationFontSize ?? 32,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassUI(ThemeData theme) {
    final outerSize = widget.size;
    final innerSize = outerSize * (260 / 300);
    final effectiveTimerColor = widget.timerColor ?? Colors.white;
    final effectiveTextColor = widget.textColor ?? Colors.white;
    final effectiveTitleColor = widget.titleColor ?? Colors.white;
    final effectiveDurationTextColor = widget.durationTextColor ?? Colors.white.withOpacity(0.7);
    final gradientColors = widget.glassGradientColors ?? [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.05),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(
            widget.title!,
            style: TextStyle(
              color: effectiveTitleColor,
              fontSize: widget.titleFontSize ?? 24,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
        ],

        ClipRRect(
          borderRadius: BorderRadius.circular(outerSize / 2),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.glassBlurIntensity,
              sigmaY: widget.glassBlurIntensity,
            ),
            child: Container(
              height: outerSize,
              width: outerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                border: Border.all(
                  color: widget.boundaryColor ?? Colors.white.withOpacity(0.2),
                  width: widget.boundaryWidth ?? 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: _progress),
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                  builder: (context, animatedProgress, _) {
                    final reversedProgress = (1 - animatedProgress).clamp(0.0, 1.0);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: innerSize,
                          width: innerSize,
                          child: CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                            value: reversedProgress,
                            strokeWidth: 20,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation<Color>(effectiveTimerColor),
                          ),
                        ),
                        Text(
                          _formatTime(_remaining),
                          style: TextStyle(
                            color: effectiveTextColor,
                            fontSize: widget.timerFontSize ?? 48,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(widget.glassOpacity),
          ),
          child: Text(
            _formatTime(Duration(seconds: _totalSeconds)),
            style: TextStyle(
              color: effectiveDurationTextColor,
              fontSize: widget.durationFontSize ?? 32,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}