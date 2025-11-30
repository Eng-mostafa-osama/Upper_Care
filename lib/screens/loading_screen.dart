import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../l10n/app_localizations.dart';

class LoadingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final Duration duration;

  const LoadingScreen({
    Key? key,
    required this.onComplete,
    this.duration = const Duration(seconds: 6),
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _currentQuoteIndex = 0;
  Timer? _quoteTimer;
  double _loadingProgress = 0.0;
  Timer? _progressTimer;

  List<Map<String, String>> get healthQuotes => [
    {'quote': tr('healthQuote1'), 'author': tr('healthQuoteAuthor1')},
    {'quote': tr('healthQuote2'), 'author': tr('healthQuoteAuthor2')},
    {'quote': tr('healthQuote3'), 'author': tr('healthQuoteAuthor3')},
    {'quote': tr('healthQuote4'), 'author': tr('healthQuoteAuthor4')},
    {'quote': tr('healthQuote5'), 'author': tr('healthQuoteAuthor5')},
    {'quote': tr('healthQuote6'), 'author': tr('healthQuoteAuthor6')},
  ];

  List<Map<String, dynamic>> get healthTips => [
    {'icon': Icons.water_drop, 'tip': tr('healthTip1')},
    {'icon': Icons.directions_walk, 'tip': tr('healthTip2')},
    {'icon': Icons.bedtime, 'tip': tr('healthTip3')},
    {'icon': Icons.apple, 'tip': tr('healthTip4')},
    {'icon': Icons.mood, 'tip': tr('healthTip5')},
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startQuoteTimer();
    _startProgressTimer();

    // Complete loading after duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  void _initAnimations() {
    // Pulse animation for logo
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation for health icons
    _rotateController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));

    // Fade animation for quotes
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();

    // Slide animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _slideController.forward();
  }

  void _startQuoteTimer() {
    _quoteTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        _fadeController.reverse().then((_) {
          setState(() {
            _currentQuoteIndex = (_currentQuoteIndex + 1) % healthQuotes.length;
          });
          _fadeController.forward();
        });
      }
    });
  }

  void _startProgressTimer() {
    const totalSteps = 30;
    final stepDuration = widget.duration.inMilliseconds ~/ totalSteps;

    _progressTimer = Timer.periodic(Duration(milliseconds: stepDuration), (
      timer,
    ) {
      if (mounted) {
        setState(() {
          _loadingProgress += 1 / totalSteps;
          if (_loadingProgress >= 1.0) {
            _loadingProgress = 1.0;
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _quoteTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9), Color(0xFF63C7FF)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Background animated particles
              ..._buildFloatingIcons(),

              // Main content
              SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    _buildAnimatedLogo(),
                    const SizedBox(height: 40),
                    _buildAppName(),
                    const SizedBox(height: 16),
                    _buildTagline(),
                    const Spacer(),
                    _buildHealthQuote(),
                    const Spacer(),
                    _buildLoadingIndicator(),
                    const SizedBox(height: 16),
                    _buildHealthTip(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingIcons() {
    final icons = [
      Icons.favorite,
      Icons.medical_services,
      Icons.local_hospital,
      Icons.health_and_safety,
      Icons.medication,
      Icons.healing,
      Icons.monitor_heart,
      Icons.bloodtype,
    ];

    return List.generate(8, (index) {
      final random = Random(index);
      final startX = random.nextDouble() * MediaQuery.of(context).size.width;
      final startY = random.nextDouble() * MediaQuery.of(context).size.height;
      final size = 20.0 + random.nextDouble() * 20;

      return AnimatedBuilder(
        animation: _rotateAnimation,
        builder: (context, child) {
          final offset = _rotateAnimation.value + (index * pi / 4);
          return Positioned(
            left: startX + sin(offset) * 30,
            top: startY + cos(offset) * 30,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                icons[index % icons.length],
                color: Colors.white,
                size: size,
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: const Color(0xFF2BB9A9).withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating ring
                AnimatedBuilder(
                  animation: _rotateAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotateAnimation.value,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2BB9A9).withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Center icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.health_and_safety,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppName() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Color(0xFFE0F7FA)],
      ).createShader(bounds),
      child: Text(
        tr('appName'),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildTagline() {
    return Text(
      tr('healthcareFromNubia'),
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildHealthQuote() {
    final quote = healthQuotes[_currentQuoteIndex];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Column(
            children: [
              Icon(
                Icons.format_quote,
                color: Colors.white.withOpacity(0.7),
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                quote['quote']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                '— ${quote['author']}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: _loadingProgress,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Percentage
        Text(
          '${(_loadingProgress * 100).toInt()}%',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // Loading dots animation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final delay = index * 0.2;
                final value = sin((_pulseController.value + delay) * pi);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8 + (value.abs() * 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5 + value.abs() * 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildHealthTip() {
    final tipIndex = (_currentQuoteIndex % healthTips.length);
    final tip = healthTips[tipIndex];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(tip['icon'] as IconData, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            tip['tip'] as String,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
