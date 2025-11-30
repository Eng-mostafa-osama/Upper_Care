import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class AdminSettings extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onLogout;

  const AdminSettings({
    super.key,
    required this.onBack,
    required this.onLogout,
  });

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  bool notificationsEnabled = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool darkMode = false;
  bool autoApproveOrders = false;
  bool maintenanceMode = false;
  bool allowGuestCheckout = true;
  bool enableReviews = true;

  // Platform settings
  double deliveryFee = 25.0;
  double minimumOrder = 50.0;
  double commissionRate = 10.0;
  int maxOrdersPerDay = 100;
  String currency = 'EGP';
  late String defaultLanguage;

  @override
  void initState() {
    super.initState();
    defaultLanguage = localeProvider.locale.languageCode;
  }

  // Working hours
  TimeOfDay openingTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay closingTime = const TimeOfDay(hour: 22, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF3E8FF), Color(0xFFEDE9FE), Color(0xFFDDD6FE)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildProfileSection(),
                      const SizedBox(height: 20),
                      _buildNotificationSettings(),
                      const SizedBox(height: 20),
                      _buildPlatformSettings(),
                      const SizedBox(height: 20),
                      _buildDeliverySettings(),
                      const SizedBox(height: 20),
                      _buildWorkingHours(),
                      const SizedBox(height: 20),
                      _buildAppSettings(),
                      const SizedBox(height: 20),
                      _buildSecuritySettings(),
                      const SizedBox(height: 20),
                      _buildDangerZone(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onBack,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.translate('settingsAdmin') ??
                      'Settings',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate('platformAccountSettings') ??
                      'Platform and Account Settings',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    final isArabic = localeProvider.isArabic;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                isArabic ? 'م' : 'A',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.translate('systemAdmin') ??
                      'System Admin',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'admin@uppercare.com',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.edit, color: Color(0xFF8B5CF6)),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    final loc = AppLocalizations.of(context);
    return _buildSettingsSection(
      loc?.translate('notificationsSettings') ?? 'Notifications',
      Icons.notifications,
      const Color(0xFFF97316),
      [
        _buildSwitchTile(
          loc?.translate('appNotifications') ?? 'App Notifications',
          loc?.translate('receiveInstantNotifications') ??
              'Receive instant notifications',
          notificationsEnabled,
          (value) {
            setState(() => notificationsEnabled = value);
          },
        ),
        _buildSwitchTile(
          loc?.translate('emailNotifications') ?? 'Email Notifications',
          loc?.translate('receiveDailyReports') ?? 'Receive daily reports',
          emailNotifications,
          (value) {
            setState(() => emailNotifications = value);
          },
        ),
        _buildSwitchTile(
          loc?.translate('smsNotifications') ?? 'SMS Notifications',
          loc?.translate('smsForImportantAlerts') ?? 'SMS for important alerts',
          smsNotifications,
          (value) {
            setState(() => smsNotifications = value);
          },
        ),
      ],
    );
  }

  Widget _buildAppSettings() {
    final loc = AppLocalizations.of(context);
    return _buildSettingsSection(
      loc?.translate('appSettings') ?? 'App',
      Icons.phone_android,
      const Color(0xFF3B82F6),
      [
        _buildSwitchTile(
          loc?.translate('darkModeAdmin') ?? 'Dark Mode',
          loc?.translate('enableNightMode') ?? 'Enable night mode',
          darkMode,
          (value) {
            setState(() => darkMode = value);
          },
        ),
        _buildEditableTile(
          loc?.translate('defaultLanguage') ?? 'Default Language',
          defaultLanguage == 'ar' ? 'العربية' : 'English',
          Icons.language,
          () {
            _showLanguageDialog();
          },
        ),
        _buildEditableTile(
          loc?.translate('currencySettings') ?? 'Currency',
          currency,
          Icons.attach_money,
          () {
            _showCurrencyDialog();
          },
        ),
        _buildNavigationTile(
          loc?.translate('aboutAppAdmin') ?? 'About App',
          loc?.translate('versionInfo') ?? 'Version 1.0.0',
          Icons.info,
        ),
      ],
    );
  }

  Widget _buildPlatformSettings() {
    final loc = AppLocalizations.of(context);
    return _buildSettingsSection(
      loc?.translate('platformSettings') ?? 'Platform Settings',
      Icons.settings,
      const Color(0xFF10B981),
      [
        _buildSwitchTile(
          loc?.translate('autoApproval') ?? 'Auto Approval',
          loc?.translate('autoApproveOrders') ?? 'Auto approve orders',
          autoApproveOrders,
          (value) {
            setState(() => autoApproveOrders = value);
          },
        ),
        _buildSwitchTile(
          loc?.translate('allowGuests') ?? 'Allow Guests',
          loc?.translate('allowGuestCheckout') ??
              'Allow purchase without registration',
          allowGuestCheckout,
          (value) {
            setState(() => allowGuestCheckout = value);
          },
        ),
        _buildSwitchTile(
          loc?.translate('reviewsSettings') ?? 'Reviews',
          loc?.translate('allowProductReviews') ??
              'Allow product and service reviews',
          enableReviews,
          (value) {
            setState(() => enableReviews = value);
          },
        ),
        _buildEditableTile(
          loc?.translate('commissionRate') ?? 'Commission Rate',
          '${commissionRate.toInt()}%',
          Icons.percent,
          () {
            _showEditDialog(
              loc?.translate('commissionRate') ?? 'Commission Rate',
              commissionRate.toString(),
              '%',
              (value) {
                setState(
                  () =>
                      commissionRate = double.tryParse(value) ?? commissionRate,
                );
              },
            );
          },
        ),
        _buildEditableTile(
          loc?.translate('maxOrdersPerDay') ?? 'Max Orders/Day',
          '$maxOrdersPerDay ${loc?.translate('ordersPerDay') ?? 'orders/day'}',
          Icons.shopping_cart,
          () {
            _showEditDialog(
              loc?.translate('maxOrdersPerDay') ?? 'Max Orders/Day',
              maxOrdersPerDay.toString(),
              loc?.translate('ordersPerDay') ?? 'orders/day',
              (value) {
                setState(
                  () =>
                      maxOrdersPerDay = int.tryParse(value) ?? maxOrdersPerDay,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildDeliverySettings() {
    final loc = AppLocalizations.of(context);
    final currencySymbol = loc?.translate('egp') ?? 'EGP';
    return _buildSettingsSection(
      loc?.translate('deliverySettings') ?? 'Delivery Settings',
      Icons.local_shipping,
      const Color(0xFF06B6D4),
      [
        _buildEditableTile(
          loc?.translate('deliveryFeeSettings') ?? 'Delivery Fee',
          '${deliveryFee.toInt()} $currencySymbol',
          Icons.local_shipping,
          () {
            _showEditDialog(
              loc?.translate('deliveryFeeSettings') ?? 'Delivery Fee',
              deliveryFee.toString(),
              currencySymbol,
              (value) {
                setState(
                  () => deliveryFee = double.tryParse(value) ?? deliveryFee,
                );
              },
            );
          },
        ),
        _buildEditableTile(
          loc?.translate('minimumOrderAmount') ?? 'Minimum Order',
          '${minimumOrder.toInt()} $currencySymbol',
          Icons.shopping_basket,
          () {
            _showEditDialog(
              loc?.translate('minimumOrderAmount') ?? 'Minimum Order',
              minimumOrder.toString(),
              currencySymbol,
              (value) {
                setState(
                  () => minimumOrder = double.tryParse(value) ?? minimumOrder,
                );
              },
            );
          },
        ),
        _buildNavigationTile(
          loc?.translate('deliveryZones') ?? 'Delivery Zones',
          '12 ${loc?.translate('zonesCount') ?? 'zones'}',
          Icons.location_on,
        ),
        _buildNavigationTile(
          loc?.translate('shippingCompanies') ?? 'Shipping Companies',
          '3 ${loc?.translate('companiesCount') ?? 'companies'}',
          Icons.business,
        ),
      ],
    );
  }

  Widget _buildWorkingHours() {
    final loc = AppLocalizations.of(context);
    return _buildSettingsSection(
      loc?.translate('workingHours') ?? 'Working Hours',
      Icons.access_time,
      const Color(0xFF8B5CF6),
      [
        _buildEditableTile(
          loc?.translate('openingTime') ?? 'Opening Time',
          _formatTime(openingTime),
          Icons.wb_sunny,
          () async {
            final time = await showTimePicker(
              context: context,
              initialTime: openingTime,
            );
            if (time != null) setState(() => openingTime = time);
          },
        ),
        _buildEditableTile(
          loc?.translate('closingTime') ?? 'Closing Time',
          _formatTime(closingTime),
          Icons.nights_stay,
          () async {
            final time = await showTimePicker(
              context: context,
              initialTime: closingTime,
            );
            if (time != null) setState(() => closingTime = time);
          },
        ),
        _buildNavigationTile(
          loc?.translate('workingDays') ?? 'Working Days',
          loc?.translate('saturdayToThursday') ?? 'Saturday - Thursday',
          Icons.calendar_today,
        ),
        _buildNavigationTile(
          loc?.translate('officialHolidays') ?? 'Official Holidays',
          '10 ${loc?.translate('holidayDaysCount') ?? 'days'}',
          Icons.event_busy,
        ),
      ],
    );
  }

  Widget _buildSecuritySettings() {
    final loc = AppLocalizations.of(context);
    return _buildSettingsSection(
      loc?.translate('securityPrivacy') ?? 'Security & Privacy',
      Icons.security,
      const Color(0xFFEF4444),
      [
        _buildSwitchTile(
          loc?.translate('maintenanceMode') ?? 'Maintenance Mode',
          loc?.translate('temporarilyDisablePlatform') ??
              'Temporarily disable platform',
          maintenanceMode,
          (value) {
            _showMaintenanceConfirmDialog(value);
          },
        ),
        _buildNavigationTile(
          loc?.translate('activityLog') ?? 'Activity Log',
          loc?.translate('viewActivityLog') ?? 'View activity log',
          Icons.history,
        ),
        _buildNavigationTile(
          loc?.translate('backupSettings') ?? 'Backup',
          loc?.translate('lastBackup') ?? 'Last backup: Today 10:30',
          Icons.backup,
        ),
        _buildNavigationTile(
          loc?.translate('securitySettings') ?? 'Security Settings',
          loc?.translate('passwordVerification') ?? 'Password and verification',
          Icons.lock,
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay time) {
    final loc = AppLocalizations.of(context);
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am
        ? (loc?.translate('timeAM') ?? 'AM')
        : (loc?.translate('timePM') ?? 'PM');
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }

  void _showEditDialog(
    String title,
    String currentValue,
    String suffix,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentValue);
    final loc = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, textAlign: TextAlign.center),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            suffixText: suffix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc?.translate('cancel') ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
              _showSuccessSnackBar(
                loc?.translate('changesSaved') ?? 'Changes saved',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
            ),
            child: Text(loc?.translate('save') ?? 'Save'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    final loc = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc?.translate('defaultLanguageTitle') ?? 'Default Language',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              loc?.translate('arabicLanguage') ?? 'العربية',
              'ar',
            ),
            const SizedBox(height: 8),
            _buildLanguageOption(
              loc?.translate('englishLanguage') ?? 'English',
              'en',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String label, String code) {
    final isSelected = defaultLanguage == code;
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        setState(() => defaultLanguage = code);
        localeProvider.setLocale(Locale(code));
        Navigator.pop(context);
        _showSuccessSnackBar(
          loc?.translate('settingsLanguageChanged') ?? 'Language changed',
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF8B5CF6).withOpacity(0.1)
              : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF8B5CF6)
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.check_circle,
                color: Color(0xFF8B5CF6),
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    final loc = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc?.translate('currencyTitle') ?? 'Currency',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCurrencyOption(
              loc?.translate('egyptianPoundEGP') ?? 'Egyptian Pound (EGP)',
              'EGP',
            ),
            const SizedBox(height: 8),
            _buildCurrencyOption(
              loc?.translate('usDollarUSD') ?? 'US Dollar (USD)',
              'USD',
            ),
            const SizedBox(height: 8),
            _buildCurrencyOption(
              loc?.translate('saudiRiyalSAR') ?? 'Saudi Riyal (SAR)',
              'SAR',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyOption(String label, String code) {
    final isSelected = currency == code;
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        setState(() => currency = code);
        Navigator.pop(context);
        _showSuccessSnackBar(
          loc?.translate('currencyChanged') ?? 'Currency changed',
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF8B5CF6).withOpacity(0.1)
              : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF8B5CF6)
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.check_circle,
                color: Color(0xFF8B5CF6),
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaintenanceConfirmDialog(bool enable) {
    final loc = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          enable
              ? (loc?.translate('enableMaintenanceMode') ??
                    'Enable Maintenance Mode')
              : (loc?.translate('disableMaintenanceMode') ??
                    'Disable Maintenance Mode'),
          textAlign: TextAlign.center,
        ),
        content: Text(
          enable
              ? (loc?.translate('maintenanceWarning') ??
                    'The platform will be temporarily disabled and users will not be able to access it. Are you sure?')
              : (loc?.translate('maintenanceRestart') ??
                    'The platform will be restarted and users will be able to access it.'),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc?.translate('cancel') ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => maintenanceMode = enable);
              Navigator.pop(context);
              _showSuccessSnackBar(
                enable
                    ? (loc?.translate('maintenanceEnabled') ??
                          'Maintenance mode enabled')
                    : (loc?.translate('maintenanceDisabled') ??
                          'Maintenance mode disabled'),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: enable ? Colors.red : const Color(0xFF10B981),
              foregroundColor: Colors.white,
            ),
            child: Text(loc?.translate('confirm') ?? 'Confirm'),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDangerZone() {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.red),
              const SizedBox(width: 12),
              Text(
                loc?.translate('dangerZone') ?? 'Danger Zone',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(loc?.translate('logoutAdmin') ?? 'Logout'),
                    content: Text(
                      loc?.translate('logoutConfirmation') ??
                          'Are you sure you want to logout?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(loc?.translate('cancel') ?? 'Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onLogout();
                        },
                        child: Text(
                          loc?.translate('logoutAdmin') ?? 'Logout',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              label: Text(loc?.translate('logoutAdmin') ?? 'Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF8B5CF6),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(value, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildEditableTile(
    String title,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF8B5CF6)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF8B5CF6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.edit, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
