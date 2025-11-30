import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class NurseScheduleScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onNavigate;

  const NurseScheduleScreen({
    Key? key,
    required this.onBack,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<NurseScheduleScreen> createState() => _NurseScheduleScreenState();
}

class _NurseScheduleScreenState extends State<NurseScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedWeekDay = DateTime.now().weekday;

  String tr(String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }

  List<Map<String, dynamic>> get _weekDays {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) {
      final date = startOfWeek.add(Duration(days: index));
      return {
        'date': date,
        'day': index + 1,
        'dayName': _getDayName(index + 1),
        'shortName': _getShortDayName(index + 1),
      };
    });
  }

  String _getDayName(int weekday) {
    final days = {
      1: tr('monday'),
      2: tr('tuesday'),
      3: tr('wednesday'),
      4: tr('thursday'),
      5: tr('friday'),
      6: tr('saturday'),
      7: tr('sunday'),
    };
    return days[weekday] ?? '';
  }

  String _getShortDayName(int weekday) {
    final days = {
      1: tr('mon'),
      2: tr('tue'),
      3: tr('wed'),
      4: tr('thu'),
      5: tr('fri'),
      6: tr('sat'),
      7: tr('sun'),
    };
    return days[weekday] ?? '';
  }

  List<Map<String, dynamic>> _getScheduleForDay(int weekday) {
    final schedules = {
      1: [
        {
          'time': '09:00',
          'patient': tr('patientAhmed'),
          'type': tr('nurseBloodSample'),
          'status': 'confirmed',
        },
        {
          'time': '11:00',
          'patient': tr('patientFatma'),
          'type': tr('nurseInjection'),
          'status': 'pending',
        },
        {
          'time': '14:00',
          'patient': tr('patientMahmoud'),
          'type': tr('nurseWoundCare'),
          'status': 'confirmed',
        },
      ],
      2: [
        {
          'time': '08:00',
          'patient': tr('patientSarah'),
          'type': tr('nurseIVDrip'),
          'status': 'confirmed',
        },
        {
          'time': '10:30',
          'patient': tr('patientKarim'),
          'type': tr('nurseVitalSigns'),
          'status': 'confirmed',
        },
      ],
      3: [
        {
          'time': '09:30',
          'patient': tr('patientNadia'),
          'type': tr('nurseInjection'),
          'status': 'pending',
        },
        {
          'time': '12:00',
          'patient': tr('patientYoussef'),
          'type': tr('nurseBloodSample'),
          'status': 'confirmed',
        },
        {
          'time': '15:00',
          'patient': tr('patientAhmed'),
          'type': tr('nurseCatheter'),
          'status': 'confirmed',
        },
        {
          'time': '17:00',
          'patient': tr('patientFatma'),
          'type': tr('nurseWoundCare'),
          'status': 'pending',
        },
      ],
      4: [
        {
          'time': '10:00',
          'patient': tr('patientMahmoud'),
          'type': tr('nurseInjection'),
          'status': 'confirmed',
        },
      ],
      5: [
        {
          'time': '08:30',
          'patient': tr('patientSarah'),
          'type': tr('nurseVitalSigns'),
          'status': 'confirmed',
        },
        {
          'time': '11:00',
          'patient': tr('patientKarim'),
          'type': tr('nurseBloodSample'),
          'status': 'confirmed',
        },
        {
          'time': '14:30',
          'patient': tr('patientNadia'),
          'type': tr('nurseIVDrip'),
          'status': 'pending',
        },
      ],
      6: [],
      7: [],
    };
    return List<Map<String, dynamic>>.from(schedules[weekday] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFDF5),
      body: Column(
        children: [
          _buildHeader(),
          _buildWeekSelector(),
          Expanded(child: _buildScheduleList()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => widget.onNavigate('nurse-new-visit'),
        backgroundColor: const Color(0xFF2BB9A9),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          tr('nurseNewVisit'),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2BB9A9), Color(0xFF3BAA5C)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
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
                  child: Text(
                    tr('nurseSchedule'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_month, color: Colors.white),
                  onPressed: _selectDate,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeaderStat(
                  _getScheduleForDay(_selectedWeekDay).length.toString(),
                  tr('visits'),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildHeaderStat(
                  _getScheduleForDay(
                    _selectedWeekDay,
                  ).where((s) => s['status'] == 'confirmed').length.toString(),
                  tr('confirmed'),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildHeaderStat(
                  _getScheduleForDay(
                    _selectedWeekDay,
                  ).where((s) => s['status'] == 'pending').length.toString(),
                  tr('pending'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildWeekSelector() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _weekDays.map((day) {
          final isSelected = day['day'] == _selectedWeekDay;
          final isToday =
              (day['date'] as DateTime).day == DateTime.now().day &&
              (day['date'] as DateTime).month == DateTime.now().month;
          return GestureDetector(
            onTap: () => setState(() => _selectedWeekDay = day['day']),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2BB9A9)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    day['shortName'],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (day['date'] as DateTime).day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isToday && !isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2BB9A9),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildScheduleList() {
    final schedule = _getScheduleForDay(_selectedWeekDay);

    if (schedule.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_available, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              tr('nothingScheduled'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(tr('dayOff'), style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        return _buildScheduleCard(schedule[index], index);
      },
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> schedule, int index) {
    final isConfirmed = schedule['status'] == 'confirmed';
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                schedule['time'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2BB9A9),
                ),
              ),
              const SizedBox(height: 8),
              Container(width: 2, height: 60, color: Colors.grey[200]),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: isConfirmed
                      ? const Color(0xFF10B981).withOpacity(0.3)
                      : const Color(0xFFF97316).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2BB9A9).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.person, color: Color(0xFF2BB9A9)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schedule['patient'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          schedule['type'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isConfirmed
                          ? const Color(0xFF10B981).withOpacity(0.1)
                          : const Color(0xFFF97316).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isConfirmed ? tr('confirmed') : tr('pending'),
                      style: TextStyle(
                        color: isConfirmed
                            ? const Color(0xFF10B981)
                            : const Color(0xFFF97316),
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
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

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2BB9A9),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
        _selectedWeekDay = date.weekday;
      });
    }
  }
}
