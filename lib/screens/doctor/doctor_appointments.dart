import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';

class DoctorAppointments extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onNavigate;

  const DoctorAppointments({
    Key? key,
    required this.onBack,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<DoctorAppointments> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  String selectedTab = 'today';

  Map<String, List<Map<String, dynamic>>> get appointments {
    final isArabic = localeProvider.isArabic;
    return {
      'today': [
        {
          'id': 1,
          'time': isArabic ? '10:00 ص' : '10:00 AM',
          'patient': isArabic ? 'فاطمة علي' : 'Fatma Ali',
          'age': 28,
          'type': isArabic ? 'كشف عام' : 'General Checkup',
          'location': isArabic ? 'عيادة' : 'Clinic',
          'locationKey': 'clinic',
          'status': 'pending',
          'phone': '01234567890',
        },
        {
          'id': 2,
          'time': isArabic ? '11:30 ص' : '11:30 AM',
          'patient': isArabic ? 'محمد أحمد' : 'Mohamed Ahmed',
          'age': 45,
          'type': isArabic ? 'متابعة' : 'Follow-up',
          'location': isArabic ? 'عيادة' : 'Clinic',
          'locationKey': 'clinic',
          'status': 'confirmed',
          'phone': '01234567891',
        },
        {
          'id': 3,
          'time': isArabic ? '02:00 م' : '02:00 PM',
          'patient': isArabic ? 'سارة حسن' : 'Sara Hassan',
          'age': 32,
          'type': isArabic ? 'استشارة مرئية' : 'Video Consultation',
          'location': isArabic ? 'أونلاين' : 'Online',
          'locationKey': 'online',
          'status': 'confirmed',
          'phone': '01234567892',
        },
      ],
      'upcoming': [
        {
          'id': 5,
          'date': isArabic ? 'غداً' : 'Tomorrow',
          'time': isArabic ? '09:00 ص' : '09:00 AM',
          'patient': isArabic ? 'نورا إبراهيم' : 'Noura Ibrahim',
          'age': 38,
          'type': isArabic ? 'متابعة' : 'Follow-up',
          'location': isArabic ? 'عيادة' : 'Clinic',
          'locationKey': 'clinic',
          'status': 'confirmed',
        },
        {
          'id': 6,
          'date': isArabic ? 'غداً' : 'Tomorrow',
          'time': isArabic ? '11:00 ص' : '11:00 AM',
          'patient': isArabic ? 'خالد محمود' : 'Khaled Mahmoud',
          'age': 50,
          'type': isArabic ? 'كشف عام' : 'General Checkup',
          'location': isArabic ? 'عيادة' : 'Clinic',
          'locationKey': 'clinic',
          'status': 'confirmed',
        },
      ],
      'past': [
        {
          'id': 7,
          'date': isArabic ? 'أمس' : 'Yesterday',
          'time': isArabic ? '10:00 ص' : '10:00 AM',
          'patient': isArabic ? 'هدى علي' : 'Huda Ali',
          'age': 29,
          'type': isArabic ? 'كشف عام' : 'General Checkup',
          'location': isArabic ? 'عيادة' : 'Clinic',
          'locationKey': 'clinic',
          'status': 'completed',
        },
        {
          'id': 8,
          'date': isArabic ? 'أمس' : 'Yesterday',
          'time': isArabic ? '02:00 م' : '02:00 PM',
          'patient': isArabic ? 'عمر حسن' : 'Omar Hassan',
          'age': 42,
          'type': isArabic ? 'استشارة مرئية' : 'Video Consultation',
          'location': isArabic ? 'أونلاين' : 'Online',
          'locationKey': 'online',
          'status': 'completed',
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFFF7ED),
      body: Column(
        children: [
          ColorfulHeader(
            title: tr('patientAppointments'),
            subtitle: tr('manageAppointments'),
            onBack: widget.onBack,
            showNotifications: true,
            gradient: 'orange',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildTabs(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: appointments[selectedTab]!.length,
                      itemBuilder: (context, index) {
                        return _buildAppointmentCard(
                          appointments[selectedTab]![index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildTab(
            'today',
            '${tr('todayTab')} (${appointments['today']!.length})',
          ),
          _buildTab(
            'upcoming',
            '${tr('upcomingTab')} (${appointments['upcoming']!.length})',
          ),
          _buildTab('past', tr('pastTab')),
        ],
      ),
    );
  }

  Widget _buildTab(String tab, String label) {
    final isSelected = selectedTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> apt) {
    return GlassCard(
      gradient: 'sunset',
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF43F5E), Color(0xFFFF9E57)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    apt['patient'][0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apt['patient'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${apt['age']} ${tr('yearsOld')}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: apt['status'] == 'confirmed'
                      ? Colors.green.withOpacity(0.1)
                      : apt['status'] == 'pending'
                      ? Colors.orange.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  apt['status'] == 'confirmed'
                      ? tr('confirmed')
                      : apt['status'] == 'pending'
                      ? tr('pending')
                      : tr('completed'),
                  style: TextStyle(
                    fontSize: 10,
                    color: apt['status'] == 'confirmed'
                        ? Colors.green[700]
                        : apt['status'] == 'pending'
                        ? Colors.orange[700]
                        : Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.orange[600]),
              const SizedBox(width: 4),
              Text(
                '${apt['date'] ?? ''} ${apt['time']}',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              const SizedBox(width: 16),
              Icon(Icons.info_outline, size: 16, color: Colors.cyan[600]),
              const SizedBox(width: 4),
              Text(
                apt['type'],
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                apt['locationKey'] == 'online'
                    ? Icons.videocam
                    : Icons.location_on,
                size: 16,
                color: apt['locationKey'] == 'online'
                    ? Colors.green[600]
                    : Colors.red[600],
              ),
              const SizedBox(width: 4),
              Text(
                apt['location'],
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
          if (apt['status'] == 'pending') ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle, size: 18),
                    label: Text(tr('accept')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A6DD9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cancel, size: 18),
                    label: Text(tr('reject')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF43F5E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (apt['status'] == 'confirmed' &&
              apt['locationKey'] == 'online') ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => widget.onNavigate('doctor-telemedicine'),
                icon: const Icon(Icons.videocam),
                label: Text(tr('startVideoCall')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2BB9A9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
