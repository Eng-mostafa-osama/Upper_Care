import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart';

class DoctorProfile extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onNavigate;

  const DoctorProfile({
    Key? key,
    required this.onBack,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool _isAvailable = true;
  bool _notificationsEnabled = true;
  bool _acceptNewAppointments = true;

  void _toggleAvailability() {
    setState(() {
      _isAvailable = !_isAvailable;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isAvailable ? tr('availableNow') : tr('unavailableNow')),
        backgroundColor: _isAvailable ? const Color(0xFF0A6DD9) : Colors.grey,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _toggleLanguage() {
    localeProvider.toggleLocale();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          localeProvider.isArabic
              ? tr('languageChangedArabic')
              : tr('languageChangedEnglish'),
        ),
        backgroundColor: const Color(0xFF0A6DD9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showEditProfileDialog() {
    final isDark = themeProvider.isDarkMode;
    final isArabic = localeProvider.isArabic;
    final nameController = TextEditingController(text: tr('drAhmedMahmoud'));
    final emailController = TextEditingController(
      text: 'dr.ahmed@uppercare.com',
    );
    final phoneController = TextEditingController(text: '01234567890');
    final addressController = TextEditingController(text: tr('aswanMarket'));
    final priceController = TextEditingController(text: '250');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      tr('cancelBtn'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    tr('editProfileTitle'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(tr('dataUpdatedSuccess')),
                          backgroundColor: const Color(0xFF0A6DD9),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      tr('saveBtn'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                isArabic ? 'د' : 'D',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0A6DD9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      tr('fullNameLabel'),
                      nameController,
                      Icons.person,
                    ),
                    _buildTextField(
                      tr('emailAddressLabel'),
                      emailController,
                      Icons.email,
                    ),
                    _buildTextField(
                      tr('phoneNumberLabel'),
                      phoneController,
                      Icons.phone,
                    ),
                    _buildTextField(
                      tr('userAddressLabel'),
                      addressController,
                      Icons.location_on,
                    ),
                    _buildTextField(
                      tr('checkupPriceLabel'),
                      priceController,
                      Icons.attach_money,
                      suffix: tr('egyptianPound'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr('specializationLabel'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(tr('internalAndCardiology')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    String? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF0A6DD9)),
              suffixText: suffix,
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0A6DD9),
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    final isDark = themeProvider.isDarkMode;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('settingsBtn'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Language Setting
                    _buildSettingTile(
                      icon: Icons.language,
                      iconColor: const Color(0xFF0A6DD9),
                      title: tr('languageLabel'),
                      subtitle: localeProvider.isArabic ? 'العربية' : 'English',
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A6DD9).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          localeProvider.isArabic ? 'عربي' : 'EN',
                          style: const TextStyle(
                            color: Color(0xFF0A6DD9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        _toggleLanguage();
                        setModalState(() {});
                        Navigator.pop(context);
                      },
                    ),

                    const Divider(),

                    // Night Mode
                    _buildSettingTile(
                      icon: Icons.dark_mode,
                      iconColor: const Color(0xFF6366F1),
                      title: tr('nightMode'),
                      subtitle: tr('activateDarkTheme'),
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.setDarkMode(value);
                          setModalState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value
                                    ? tr('nightModeActivated')
                                    : tr('dayModeActivated'),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        activeColor: const Color(0xFF6366F1),
                      ),
                    ),

                    const Divider(),

                    // Notifications
                    _buildSettingTile(
                      icon: Icons.notifications,
                      iconColor: const Color(0xFFFF9E57),
                      title: tr('notifications'),
                      subtitle: tr('receiveUpdates'),
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setModalState(() => _notificationsEnabled = value);
                          setState(() => _notificationsEnabled = value);
                        },
                        activeColor: const Color(0xFFFF9E57),
                      ),
                    ),

                    const Divider(),

                    // Accept New Appointments
                    _buildSettingTile(
                      icon: Icons.event_available,
                      iconColor: const Color(0xFF0A6DD9),
                      title: tr('acceptNewAppointments'),
                      subtitle: tr('allowPatientBooking'),
                      trailing: Switch(
                        value: _acceptNewAppointments,
                        onChanged: (value) {
                          setModalState(() => _acceptNewAppointments = value);
                          setState(() => _acceptNewAppointments = value);
                        },
                        activeColor: const Color(0xFF0A6DD9),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFCE7F3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColorfulHeader(
              title: tr('profileTitle'),
              subtitle: tr('doctorInfo'),
              onBack: widget.onBack,
              showNotifications: true,
              gradient: 'sunset',
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildAvailabilityToggle(),
                  const SizedBox(height: 20),
                  _buildProfileHeader(),
                  const SizedBox(height: 20),
                  _buildPersonalInfo(),
                  const SizedBox(height: 20),
                  _buildProfessionalInfo(),
                  const SizedBox(height: 20),
                  _buildStatistics(),
                  const SizedBox(height: 20),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityToggle() {
    return GlassCard(
      gradient: _isAvailable ? 'green' : 'sunset',
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (_isAvailable ? const Color(0xFF0A6DD9) : Colors.grey)
                  .withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _isAvailable ? Icons.check_circle : Icons.cancel,
              color: _isAvailable ? const Color(0xFF0A6DD9) : Colors.grey,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('availabilityStatus'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isAvailable
                      ? tr('availableForPatients')
                      : tr('notAvailableNow'),
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 1.2,
            child: Switch(
              value: _isAvailable,
              onChanged: (value) => _toggleAvailability(),
              activeColor: const Color(0xFF0A6DD9),
              activeTrackColor: const Color(0xFF0A6DD9).withOpacity(0.3),
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return GlassCard(
      gradient: 'sunset',
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF9E57).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    localeProvider.isArabic ? 'د' : 'D',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Availability indicator
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _isAvailable ? const Color(0xFF0A6DD9) : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Color(0xFFFF7D40),
                      size: 18,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            tr('drAhmedMahmoud'),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            tr('internalAndCardiology'),
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (_isAvailable ? const Color(0xFF0A6DD9) : Colors.grey)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isAvailable ? Icons.circle : Icons.circle_outlined,
                  size: 10,
                  color: _isAvailable ? const Color(0xFF0A6DD9) : Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  _isAvailable ? tr('availableNow') : tr('unavailable'),
                  style: TextStyle(
                    color: _isAvailable ? const Color(0xFF0A6DD9) : Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                (index) =>
                    const Icon(Icons.star, color: Color(0xFFFFD700), size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                '(4.8 ${tr('fromRatings')} 156)',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    color: Color(0xFF0A6DD9),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '15 ${tr('yearsExperience')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  const Icon(Icons.work, color: Color(0xFF0A6DD9), size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '1,250+ ${tr('patientsPlus')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return GlassCard(
      gradient: 'blue',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('personalInfo'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF0A6DD9)),
                onPressed: _showEditProfileDialog,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.email,
            tr('emailLabel'),
            'dr.ahmed@uppercare.com',
            const Color(0xFF0A6DD9),
          ),
          _buildInfoItem(
            Icons.phone,
            tr('phoneLabel'),
            '01234567890',
            const Color(0xFF0A6DD9),
          ),
          _buildInfoItem(
            Icons.location_on,
            tr('addressLabel'),
            tr('aswanMarket'),
            const Color(0xFFF43F5E),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(value, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInfo() {
    return GlassCard(
      gradient: 'turquoise',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('professionalInfo'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildProfessionalItem(
            tr('specializationLabel'),
            tr('internalAndCardiology'),
          ),
          _buildProfessionalItem(tr('licenseNumber'), 'MED-2024-12345'),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('qualifications'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text('• ${tr('medicineBachelor')}'),
                Text('• ${tr('internalMedicineMaster')}'),
                Text('• ${tr('cardiologyDiploma')}'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildProfessionalItem(
            tr('checkupPriceLabel'),
            '250 ${tr('egyptianPound')}',
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return GlassCard(
      gradient: 'green',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('performanceStats'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildStatItem('1,250', tr('patientLabel')),
              _buildStatItem('156', tr('reviewLabel')),
              _buildStatItem('98%', tr('patientSatisfaction')),
              _buildStatItem('42', tr('healthArticle')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        GradientButton(
          variant: 'blue',
          fullWidth: true,
          onPressed: _showEditProfileDialog,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.edit, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(tr('editProfileBtn')),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: TextButton.icon(
            onPressed: _showSettingsDialog,
            icon: Icon(Icons.settings, color: Colors.grey[700]),
            label: Text(
              tr('settingsBtn'),
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.withOpacity(0.2)),
          ),
          child: TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(tr('logoutConfirm')),
                  content: Text(tr('areYouSureLogout')),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(tr('cancelBtn')),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onNavigate('role-selector');
                      },
                      child: Text(
                        tr('logoutBtn'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: Text(
              tr('logoutBtn'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
