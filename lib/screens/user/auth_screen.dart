import 'package:flutter/material.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  final Function(String role) onComplete;
  final String userRole;

  const AuthScreen({
    super.key,
    required this.onComplete,
    this.userRole = 'patient',
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool showPassword = false;
  bool isLoading = false;
  String? errorMessage;
  String selectedRole = 'patient';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthProvider authProvider = AuthProvider();

  final List<Map<String, dynamic>> roles = [
    {'id': 'patient', 'icon': Icons.person, 'color': const Color(0xFF06B6D4)},
    {
      'id': 'doctor',
      'icon': Icons.medical_services,
      'color': const Color(0xFFF97316),
    },
    {
      'id': 'nurse',
      'icon': Icons.health_and_safety,
      'color': const Color(0xFF10B981),
    },
    {
      'id': 'admin',
      'icon': Icons.admin_panel_settings,
      'color': const Color(0xFF8B5CF6),
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedRole = widget.userRole;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Color get selectedRoleColor {
    final role = roles.firstWhere(
      (r) => r['id'] == selectedRole,
      orElse: () => roles[0],
    );
    return role['color'] as Color;
  }

  Future<void> _handleSubmit() async {
    final loc = AppLocalizations.of(context);
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage =
            loc?.translate('fillAllFields') ??
            'Please fill in all required fields';
        isLoading = false;
      });
      return;
    }

    if (!isLogin && nameController.text.isEmpty) {
      setState(() {
        errorMessage =
            loc?.translate('enterNameRequired') ?? 'Please enter your name';
        isLoading = false;
      });
      return;
    }

    if (!RegExp(r'^01[0-9]{9}$').hasMatch(phoneController.text)) {
      setState(() {
        errorMessage =
            loc?.translate('invalidPhone') ??
            'Please enter a valid phone number';
        isLoading = false;
      });
      return;
    }

    if (passwordController.text.length < 6) {
      setState(() {
        errorMessage =
            loc?.translate('passwordMinLength') ??
            'Password must be at least 6 characters';
        isLoading = false;
      });
      return;
    }

    bool success;

    if (isLogin) {
      success = await authProvider.login(
        name: phoneController.text,
        phone: phoneController.text,
        password: passwordController.text,
        role: selectedRole,
      );
    } else {
      success = await authProvider.register(
        name: nameController.text,
        phone: phoneController.text,
        password: passwordController.text,
        location: locationController.text,
        role: selectedRole,
      );
    }

    setState(() {
      isLoading = false;
    });

    if (success) {
      widget.onComplete(selectedRole);
    } else {
      setState(() {
        errorMessage =
            loc?.translate('errorOccurred') ??
            'An error occurred, please try again';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isArabic = localeProvider.isArabic;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              selectedRoleColor.withOpacity(0.9),
              selectedRoleColor.withOpacity(0.7),
              const Color(0xFF2BB9A9),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Language Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button placeholder for alignment
                      const SizedBox(width: 48),
                      // App name
                      Text(
                        loc?.translate('appName') ?? 'UpperCare',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Language toggle
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => localeProvider.toggleLocale(),
                          icon: const Icon(Icons.language, color: Colors.white),
                          tooltip: isArabic ? 'English' : 'العربية',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Logo with animation
                  _buildAnimatedLogo(),
                  const SizedBox(height: 24),

                  // Role Selection
                  _buildRoleSelector(),
                  const SizedBox(height: 24),

                  // Auth Card
                  _buildAuthCard(),
                  const SizedBox(height: 16),

                  // Bottom text
                  Text(
                    loc?.translate('healthcareFromNubia') ??
                        'Complete healthcare from the heart of Nubia',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      selectedRoleColor,
                      selectedRoleColor.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  roles.firstWhere(
                        (r) => r['id'] == selectedRole,
                        orElse: () => roles[0],
                      )['icon']
                      as IconData,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoleSelector() {
    final loc = AppLocalizations.of(context);

    String getRoleName(String roleId) {
      switch (roleId) {
        case 'patient':
          return loc?.translate('patient') ?? 'Patient';
        case 'doctor':
          return loc?.translate('doctor') ?? 'Doctor';
        case 'nurse':
          return loc?.translate('nurse') ?? 'Nurse';
        case 'admin':
          return loc?.translate('admin') ?? 'Admin';
        default:
          return roleId;
      }
    }

    return Column(
      children: [
        Text(
          loc?.translate('selectRole') ?? 'Select your role',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: roles.map((role) {
              final isSelected = selectedRole == role['id'];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = role['id'] as String;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          role['icon'] as IconData,
                          color: isSelected
                              ? role['color'] as Color
                              : Colors.white.withOpacity(0.8),
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          getRoleName(role['id'] as String),
                          style: TextStyle(
                            color: isSelected
                                ? role['color'] as Color
                                : Colors.white.withOpacity(0.8),
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthCard() {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildToggleButtons(),
          const SizedBox(height: 20),
          if (errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                if (!isLogin) ...[
                  _buildTextField(
                    controller: nameController,
                    label: loc?.translate('fullName') ?? 'Full Name',
                    hint:
                        loc?.translate('enterFullName') ??
                        'Enter your full name',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                ],
                _buildTextField(
                  controller: phoneController,
                  label: loc?.translate('phoneNumber') ?? 'Phone Number',
                  hint: '01XXXXXXXXX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                if (!isLogin) ...[
                  _buildTextField(
                    controller: locationController,
                    label: loc?.translate('location') ?? 'Location',
                    hint:
                        loc?.translate('locationHint') ??
                        'Aswan, Qena, Sohag...',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 16),
                ],
                _buildPasswordField(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSubmitButton(),
          const SizedBox(height: 16),
          // Forgot password (only for login)
          if (isLogin)
            TextButton(
              onPressed: () {
                // TODO: Implement forgot password
              },
              child: Text(
                loc?.translate('forgotPassword') ?? 'Forgot password?',
                style: TextStyle(
                  color: selectedRoleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                isLogin = true;
                errorMessage = null;
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isLogin
                      ? LinearGradient(
                          colors: [
                            selectedRoleColor,
                            selectedRoleColor.withOpacity(0.8),
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isLogin
                      ? [
                          BoxShadow(
                            color: selectedRoleColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    loc?.translate('login') ?? 'Login',
                    style: TextStyle(
                      color: isLogin ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                isLogin = false;
                errorMessage = null;
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: !isLogin
                      ? LinearGradient(
                          colors: [
                            selectedRoleColor,
                            selectedRoleColor.withOpacity(0.8),
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: !isLogin
                      ? [
                          BoxShadow(
                            color: selectedRoleColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    loc?.translate('newAccount') ?? 'New Account',
                    style: TextStyle(
                      color: !isLogin ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[50],
            prefixIcon: Icon(icon, color: selectedRoleColor.withOpacity(0.7)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: selectedRoleColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    final loc = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            loc?.translate('password') ?? 'Password',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          controller: passwordController,
          obscureText: !showPassword,
          decoration: InputDecoration(
            hintText: loc?.translate('enterPassword') ?? 'Enter password',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[50],
            prefixIcon: Icon(
              Icons.lock_outline,
              color: selectedRoleColor.withOpacity(0.7),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[400],
              ),
              onPressed: () => setState(() => showPassword = !showPassword),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: selectedRoleColor, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    final loc = AppLocalizations.of(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedRoleColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: selectedRoleColor.withOpacity(0.4),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin
                        ? (loc?.translate('login') ?? 'Login')
                        : (loc?.translate('register') ?? 'Register'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
      ),
    );
  }
}
