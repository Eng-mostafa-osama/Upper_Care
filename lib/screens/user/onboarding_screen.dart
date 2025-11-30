import 'package:flutter/material.dart';
import 'dart:math';
import '../../l10n/app_localizations.dart';

class OnboardingSlide {
  final int id;
  final String titleKey;
  final String descriptionKey;
  final List<Color> gradientColors;
  final IconData icon;
  final List<IconData> floatingIcons;

  OnboardingSlide({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.gradientColors,
    required this.icon,
    required this.floatingIcons,
  });
}

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({Key? key, required this.onComplete})
    : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  int currentSlide = 0;

  // Animation controllers
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _buttonController;
  late AnimationController _particleController;

  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _particleAnimation;

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      id: 1,
      titleKey: 'welcomeToApp',
      descriptionKey: 'onboarding1Desc',
      gradientColors: [
        const Color(0xFFFF9E57),
        const Color(0xFFFF7D40),
        const Color(0xFFE9E9E9),
      ],
      icon: Icons.home_filled,
      floatingIcons: [
        Icons.star,
        Icons.favorite,
        Icons.health_and_safety,
        Icons.local_hospital,
      ],
    ),
    OnboardingSlide(
      id: 2,
      titleKey: 'doctorAtHome',
      descriptionKey: 'onboarding2Desc',
      gradientColors: [
        const Color(0xFF0A6DD9),
        const Color(0xFF2BB9A9),
        const Color(0xFF2BB9A9),
      ],
      icon: Icons.medical_services,
      floatingIcons: [
        Icons.video_call,
        Icons.phone,
        Icons.chat,
        Icons.schedule,
      ],
    ),
    OnboardingSlide(
      id: 3,
      titleKey: 'medicineDelivery',
      descriptionKey: 'onboarding3Desc',
      gradientColors: [
        const Color(0xFF2BB9A9),
        const Color(0xFF0A6DD9),
        const Color(0xFF2BB9A9),
      ],
      icon: Icons.delivery_dining,
      floatingIcons: [
        Icons.medication,
        Icons.local_pharmacy,
        Icons.shopping_cart,
        Icons.speed,
      ],
    ),
    OnboardingSlide(
      id: 4,
      titleKey: 'donationChangesLives',
      descriptionKey: 'onboarding4Desc',
      gradientColors: [
        const Color(0xFFFF7D40),
        const Color(0xFFE9E9E9),
        const Color(0xFF0A6DD9),
      ],
      icon: Icons.favorite,
      floatingIcons: [
        Icons.bloodtype,
        Icons.volunteer_activism,
        Icons.handshake,
        Icons.people,
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    // Main slide transition animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );

    // Pulse animation for icon
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Float animation for decorative icons
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Button bounce animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );

    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _particleAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );

    // Start initial animation
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    _buttonController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _animateToSlide(int newSlide) {
    _slideController.reverse().then((_) {
      setState(() {
        currentSlide = newSlide;
      });
      _slideController.forward();
    });
  }

  void handleNext() {
    if (currentSlide < slides.length - 1) {
      _animateToSlide(currentSlide + 1);
    } else {
      widget.onComplete();
    }
  }

  void handleSkip() {
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: slides[currentSlide].gradientColors,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Animated background particles
              ..._buildParticles(),

              // Floating decorative icons
              ..._buildFloatingIcons(),

              // Main content
              Column(
                children: [
                  _buildAnimatedDecorativeTop(),
                  _buildSkipButton(),
                  Expanded(child: _buildMainContent()),
                  _buildBottomNavigation(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildParticles() {
    return List.generate(12, (index) {
      final random = Random(index);
      final size = 4.0 + random.nextDouble() * 8;
      final startX = random.nextDouble() * 400;
      final startY = random.nextDouble() * 800;

      return AnimatedBuilder(
        animation: _particleAnimation,
        builder: (context, child) {
          final offset = _particleAnimation.value + (index * pi / 6);
          return Positioned(
            left: startX + sin(offset) * 50,
            top: startY + cos(offset * 0.5) * 30,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1 + (sin(offset) * 0.1)),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      );
    });
  }

  List<Widget> _buildFloatingIcons() {
    final icons = slides[currentSlide].floatingIcons;
    final positions = [
      const Offset(30, 120),
      const Offset(320, 180),
      const Offset(50, 400),
      const Offset(300, 500),
    ];

    return List.generate(icons.length, (index) {
      return AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          final yOffset = _floatAnimation.value * (index.isEven ? 1 : -1);
          final xOffset = _floatAnimation.value * 0.5 * (index.isOdd ? 1 : -1);

          return Positioned(
            left: positions[index].dx + xOffset,
            top: positions[index].dy + yOffset,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icons[index],
                  color: Colors.white.withOpacity(0.6),
                  size: 24,
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildAnimatedDecorativeTop() {
    return SizedBox(
      height: 48,
      child: AnimatedBuilder(
        animation: _particleAnimation,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(20, (index) {
              final wave = sin(_particleAnimation.value + index * 0.3);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8 + (wave * 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2 + (wave * 0.1)),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: handleSkip,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('skip'),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.8),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedIllustration(),
              const SizedBox(height: 48),
              ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  tr(slides[currentSlide].titleKey),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                tr(slides[currentSlide].descriptionKey),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIllustration() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ripple effect
              ...List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _particleAnimation,
                  builder: (context, child) {
                    final scale =
                        1.0 +
                        (sin(_particleAnimation.value + index * pi / 3) * 0.1);
                    return Container(
                      width: 200 + (index * 30.0),
                      height: 200 + (index * 30.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1 - (index * 0.03)),
                          width: 2,
                        ),
                      ),
                      transform: Matrix4.identity()..scale(scale),
                    );
                  },
                );
              }),

              // Outer glow circle
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),

              // Inner circle
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),

              // Icon container with rotation
              AnimatedBuilder(
                animation: _floatAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _floatAnimation.value * 0.02,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.9),
                            Colors.white.withOpacity(0.7),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        slides[currentSlide].icon,
                        size: 50,
                        color: slides[currentSlide].gradientColors[0],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          _buildAnimatedDotsIndicator(),
          const SizedBox(height: 24),
          _buildAnimatedNextButton(),
        ],
      ),
    );
  }

  Widget _buildAnimatedDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(slides.length, (index) {
        final isActive = index == currentSlide;
        return GestureDetector(
          onTap: () {
            if (index != currentSlide) {
              _animateToSlide(index);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 32 : 12,
            height: 12,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(6),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAnimatedNextButton() {
    return GestureDetector(
      onTapDown: (_) => _buttonController.forward(),
      onTapUp: (_) {
        _buttonController.reverse();
        handleNext();
      },
      onTapCancel: () => _buttonController.reverse(),
      child: ScaleTransition(
        scale: _buttonScaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: slides[currentSlide].gradientColors[0].withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentSlide == slides.length - 1
                    ? tr('getStarted')
                    : tr('next'),
                style: TextStyle(
                  color: slides[currentSlide].gradientColors[0],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedBuilder(
                animation: _floatAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_floatAnimation.value * 0.2, 0),
                    child: Icon(
                      currentSlide == slides.length - 1
                          ? Icons.check_circle
                          : Icons.arrow_forward_rounded,
                      color: slides[currentSlide].gradientColors[0],
                      size: 24,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}





