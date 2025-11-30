import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class DoctorSchedule extends StatefulWidget {
  final VoidCallback onBack;

  const DoctorSchedule({Key? key, required this.onBack}) : super(key: key);

  @override
  State<DoctorSchedule> createState() => _DoctorScheduleState();
}

class _DoctorScheduleState extends State<DoctorSchedule> {
  String? _selectedDayKey;

  String get selectedDay {
    _selectedDayKey ??= 'sunday';
    return _selectedDayKey!;
  }

  set selectedDay(String value) {
    _selectedDayKey = value;
  }

  List<String> get days {
    final isArabic = localeProvider.isArabic;
    return isArabic
        ? [
            'الأحد',
            'الاثنين',
            'الثلاثاء',
            'الأربعاء',
            'الخميس',
            'الجمعة',
            'السبت',
          ]
        : [
            'Sunday',
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
          ];
  }

  List<String> get dayKeys => [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
  ];

  Map<String, List<Map<String, String>>> get schedule {
    final isArabic = localeProvider.isArabic;
    return {
      'sunday': [
        {
          'time': isArabic ? '09:00 ص - 12:00 م' : '09:00 AM - 12:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
        {
          'time': isArabic ? '04:00 م - 08:00 م' : '04:00 PM - 08:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
      ],
      'monday': [
        {
          'time': isArabic ? '10:00 ص - 01:00 م' : '10:00 AM - 01:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
        {
          'time': isArabic ? '05:00 م - 09:00 م' : '05:00 PM - 09:00 PM',
          'location': isArabic ? 'أونلاين' : 'Online',
        },
      ],
      'tuesday': [
        {
          'time': isArabic ? '09:00 ص - 12:00 م' : '09:00 AM - 12:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
      ],
      'wednesday': [
        {
          'time': isArabic ? '10:00 ص - 01:00 م' : '10:00 AM - 01:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
        {
          'time': isArabic ? '03:00 م - 06:00 م' : '03:00 PM - 06:00 PM',
          'location': isArabic ? 'أونلاين' : 'Online',
        },
      ],
      'thursday': [
        {
          'time': isArabic ? '09:00 ص - 12:00 م' : '09:00 AM - 12:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
        {
          'time': isArabic ? '04:00 م - 08:00 م' : '04:00 PM - 08:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
      ],
      'friday': [],
      'saturday': [
        {
          'time': isArabic ? '10:00 ص - 02:00 م' : '10:00 AM - 02:00 PM',
          'location': isArabic ? 'عيادة' : 'Clinic',
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFDF5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColorfulHeader(
              title: tr('scheduleTitle'),
              subtitle: tr('manageAvailability'),
              onBack: widget.onBack,
              showNotifications: true,
              gradient: 'green',
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildDaysSelector(),
                  const SizedBox(height: 20),
                  _buildScheduleCard(),
                  const SizedBox(height: 20),
                  _buildQuickStats(),
                  const SizedBox(height: 20),
                  _buildSettings(),
                  const SizedBox(height: 20),
                  GradientButton(
                    variant: 'green',
                    fullWidth: true,
                    onPressed: () {},
                    child: Text(tr('saveChanges')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final dayKey = dayKeys[index];
          final isSelected = selectedDay == dayKey;
          return GestureDetector(
            onTap: () => setState(() => selectedDay = dayKey),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                      )
                    : null,
                color: isSelected ? null : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? null
                    : Border.all(
                        color: const Color(0xFF0A6DD9).withOpacity(0.2),
                      ),
              ),
              child: Text(
                day,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleCard() {
    final slots = schedule[selectedDay] ?? [];
    final dayIndex = dayKeys.indexOf(selectedDay);
    final displayDay = dayIndex >= 0 ? days[dayIndex] : selectedDay;
    return GlassCard(
      gradient: 'green',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tr('timesFor')} $displayDay',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (slots.isEmpty)
            Column(
              children: [
                Icon(Icons.calendar_today, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 12),
                Text(
                  tr('noTimesAvailable'),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                GradientButton(
                  variant: 'green',
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(tr('addNewTime')),
                    ],
                  ),
                ),
              ],
            )
          else
            ...slots
                .map(
                  (slot) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF0A6DD9).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.access_time,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                slot['time']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                slot['location']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green[600]),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[600]),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            gradient: 'turquoise',
            child: Column(
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
                  child: const Icon(Icons.calendar_today, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  '24',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  tr('weeklyHours'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GlassCard(
            gradient: 'blue',
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.access_time, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  '6',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  tr('workDays'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettings() {
    return GlassCard(
      gradient: 'nile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('availabilitySettings'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            tr('acceptNewAppointments'),
            tr('allowPatientBooking'),
            true,
          ),
          _buildSettingItem(
            tr('advanceBooking'),
            '${tr('daysCount')} 14',
            null,
          ),
          _buildSettingItem(
            tr('appointmentDuration'),
            '30 ${tr('minutesPerAppointment')}',
            null,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, bool? hasSwitch) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
          if (hasSwitch != null)
            Switch(
              value: hasSwitch,
              onChanged: (value) {},
              activeColor: const Color(0xFF0A6DD9),
            )
          else
            TextButton(
              onPressed: () {},
              child: Text(
                tr('edit'),
                style: const TextStyle(color: Color(0xFF2BB9A9)),
              ),
            ),
        ],
      ),
    );
  }
}
