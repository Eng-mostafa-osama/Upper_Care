import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';

class DoctorDashboard extends StatefulWidget {
  final Function(String) onNavigate;

  const DoctorDashboard({Key? key, required this.onNavigate}) : super(key: key);

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildNotificationsSheet(),
    );
  }

  Widget _buildNotificationsSheet() {
    final notifications = [
      {
        'icon': Icons.calendar_today,
        'title': tr('newAppointmentBooked'),
        'subtitle': '${tr('patientFatmaAli')} - ${tr('generalCheckup')}',
        'time': '5 ${tr('minutesAgo')}',
        'color': const Color(0xFF0A6DD9),
        'isNew': true,
      },
      {
        'icon': Icons.message,
        'title': tr('newMessage'),
        'subtitle': tr('patientMohamedAhmed'),
        'time': '15 ${tr('minutesAgo')}',
        'color': const Color(0xFF2BB9A9),
        'isNew': true,
      },
      {
        'icon': Icons.videocam,
        'title': tr('videoCallReminder'),
        'subtitle': '${tr('patientSaraHasan')} - 2:00 PM',
        'time': '1 ${tr('hourAgo')}',
        'color': const Color(0xFF0A6DD9),
        'isNew': false,
      },
      {
        'icon': Icons.star,
        'title': tr('newReview'),
        'subtitle': tr('patientAhmedSaid'),
        'time': '2 ${tr('hoursAgo')}',
        'color': const Color(0xFFFF9E57),
        'isNew': false,
      },
      {
        'icon': Icons.attach_money,
        'title': tr('paymentReceived'),
        'subtitle': '250 ${tr('egp')}',
        'time': '3 ${tr('hoursAgo')}',
        'color': const Color(0xFF0A6DD9),
        'isNew': false,
      },
    ];

    final isDark = themeProvider.isDarkMode;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('notifications'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    tr('markAllRead'),
                    style: const TextStyle(color: Color(0xFF0A6DD9)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: (notif['isNew'] as bool)
                        ? const Color(
                            0xFF0A6DD9,
                          ).withOpacity(isDark ? 0.15 : 0.05)
                        : (isDark ? const Color(0xFF2C2C2C) : Colors.grey[50]),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: (notif['isNew'] as bool)
                          ? const Color(0xFF0A6DD9).withOpacity(0.2)
                          : (isDark
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.1)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (notif['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          notif['icon'] as IconData,
                          color: notif['color'] as Color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notif['title'] as String,
                                    style: TextStyle(
                                      fontWeight: (notif['isNew'] as bool)
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                if (notif['isNew'] as bool)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF0A6DD9),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notif['subtitle'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notif['time'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? Colors.grey[500]
                                    : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFFF7ED),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColorfulHeader(
              title: tr('doctorDashboard'),
              subtitle: tr('welcomeDrAhmed'),
              showNotifications: true,
              gradient: 'sunset',
              onNotificationTap: _showNotifications,
              notificationCount: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildQuickActions(),
                  const SizedBox(height: 20),
                  _buildUpcomingAppointments(),
                  const SizedBox(height: 20),
                  _buildBottomCards(),
                  const SizedBox(height: 20),
                  GradientButton(
                    variant: 'sunset',
                    fullWidth: true,
                    onPressed: () => widget.onNavigate('doctor-profile'),
                    child: Text(tr('viewProfile')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        StatCard(
          icon: Icons.calendar_today,
          label: tr('todayAppointments'),
          value: '8',
          gradient: 'orange',
        ),
        StatCard(
          icon: Icons.people,
          label: tr('newPatients'),
          value: '12',
          trend: '+15% ${tr('thisWeek')}',
          gradient: 'turquoise',
        ),
        StatCard(
          icon: Icons.attach_money,
          label: tr('monthlyEarnings'),
          value: '15,000 ${tr('egp')}',
          trend: '+22%',
          gradient: 'green',
        ),
        StatCard(
          icon: Icons.access_time,
          label: tr('workHours'),
          value: '42 ${tr('hours')}',
          gradient: 'blue',
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return GlassCard(
      gradient: 'sunset',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('quickActionsDoctor'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _buildActionCard(
                Icons.calendar_today,
                tr('todaySchedule'),
                const Color(0xFFFF9E57),
                () => widget.onNavigate('doctor-appointments'),
              ),
              _buildActionCard(
                Icons.message,
                tr('patientMessages'),
                const Color(0xFF2BB9A9),
                () => widget.onNavigate('doctor-chat'),
              ),
              _buildActionCard(
                Icons.videocam,
                tr('videoConsultations'),
                const Color(0xFF0A6DD9),
                () => widget.onNavigate('doctor-telemedicine'),
              ),
              _buildActionCard(
                Icons.description,
                tr('publishContent'),
                const Color(0xFFD9AE73),
                () => widget.onNavigate('doctor-content'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    final appointments = [
      {
        'time': '10:00 AM',
        'name': tr('patientFatmaAli'),
        'type': tr('generalCheckup'),
        'status': 'confirmed',
      },
      {
        'time': '11:30 AM',
        'name': tr('patientMohamedAhmed'),
        'type': tr('followUp'),
        'status': 'pending',
      },
      {
        'time': '02:00 PM',
        'name': tr('patientSaraHasan'),
        'type': tr('videoConsultation'),
        'status': 'confirmed',
      },
    ];

    return GlassCard(
      gradient: 'nile',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('upcomingAppointments'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => widget.onNavigate('doctor-appointments'),
                child: Text(
                  tr('viewAllAppointments'),
                  style: const TextStyle(color: Color(0xFF2BB9A9)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...appointments.map((apt) => _buildAppointmentItem(apt)).toList(),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(Map<String, String> apt) {
    final isConfirmed = apt['status'] == 'confirmed';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2BB9A9).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.access_time, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  apt['name']!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  apt['type']!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(apt['time']!, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isConfirmed
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isConfirmed ? tr('confirmed') : tr('pending'),
                  style: TextStyle(
                    fontSize: 10,
                    color: isConfirmed ? Colors.green[700] : Colors.orange[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCards() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => widget.onNavigate('doctor-schedule'),
            child: GlassCard(
              gradient: 'green',
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.calendar_today,
                      color: Color(0xFF0A6DD9),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tr('appointmentSchedule'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    tr('manageAvailableTimes'),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => widget.onNavigate('doctor-earnings'),
            child: GlassCard(
              gradient: 'orange',
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.trending_up,
                      color: Color(0xFFFF7D40),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tr('earnings'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    tr('financialReports'),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


