import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class NurseAppointmentsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onNavigate;

  const NurseAppointmentsScreen({
    Key? key,
    required this.onBack,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<NurseAppointmentsScreen> createState() =>
      _NurseAppointmentsScreenState();
}

class _NurseAppointmentsScreenState extends State<NurseAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';

  String tr(String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _upcomingAppointments => [
    {
      'id': '1',
      'patientName': tr('patientAhmed'),
      'time': '10:00',
      'date': '2024-12-01',
      'type': tr('nurseBloodSample'),
      'address': tr('addressAswan1'),
      'status': 'confirmed',
      'phone': '01012345678',
    },
    {
      'id': '2',
      'patientName': tr('patientFatma'),
      'time': '12:00',
      'date': '2024-12-01',
      'type': tr('nurseInjection'),
      'address': tr('addressAswan2'),
      'status': 'pending',
      'phone': '01098765432',
    },
    {
      'id': '3',
      'patientName': tr('patientMahmoud'),
      'time': '15:00',
      'date': '2024-12-01',
      'type': tr('nurseWoundCare'),
      'address': tr('addressKomOmbo'),
      'status': 'confirmed',
      'phone': '01155556666',
    },
    {
      'id': '4',
      'patientName': tr('patientSarah'),
      'time': '09:00',
      'date': '2024-12-02',
      'type': tr('nurseIVDrip'),
      'address': tr('addressEdfu'),
      'status': 'pending',
      'phone': '01234567890',
    },
  ];

  List<Map<String, dynamic>> get _completedAppointments => [
    {
      'id': '5',
      'patientName': tr('patientKarim'),
      'time': '08:00',
      'date': '2024-11-30',
      'type': tr('nurseBloodSample'),
      'address': tr('addressAswan1'),
      'status': 'completed',
      'phone': '01122334455',
    },
    {
      'id': '6',
      'patientName': tr('patientNadia'),
      'time': '14:00',
      'date': '2024-11-30',
      'type': tr('nurseInjection'),
      'address': tr('addressAswan2'),
      'status': 'completed',
      'phone': '01566778899',
    },
  ];

  List<Map<String, dynamic>> get _cancelledAppointments => [
    {
      'id': '7',
      'patientName': tr('patientYoussef'),
      'time': '11:00',
      'date': '2024-11-29',
      'type': tr('nurseWoundCare'),
      'address': tr('addressKomOmbo'),
      'status': 'cancelled',
      'phone': '01012121212',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFDF5),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAppointmentsList(_upcomingAppointments),
                _buildAppointmentsList(_completedAppointments),
                _buildAppointmentsList(_cancelledAppointments),
              ],
            ),
          ),
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
                    tr('nurseAppointments'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  onPressed: _showFilterDialog,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            _upcomingAppointments.length.toString(),
            tr('upcoming'),
            Icons.schedule,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            _completedAppointments.length.toString(),
            tr('nurseCompleted'),
            Icons.check_circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            _cancelledAppointments.length.toString(),
            tr('cancelled'),
            Icons.cancel,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF2BB9A9),
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        padding: const EdgeInsets.all(4),
        tabs: [
          Tab(text: tr('upcoming')),
          Tab(text: tr('nurseCompleted')),
          Tab(text: tr('cancelled')),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(List<Map<String, dynamic>> appointments) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              tr('noAppointments'),
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(appointments[index]);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    final status = appointment['status'] as String;
    final statusColor = status == 'confirmed'
        ? const Color(0xFF10B981)
        : status == 'pending'
        ? const Color(0xFFF97316)
        : status == 'completed'
        ? const Color(0xFF3B82F6)
        : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
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
                      appointment['patientName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment['type'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
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
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getStatusText(status),
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoChip(Icons.access_time, appointment['time']),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.calendar_today, appointment['date']),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  appointment['address'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ),
            ],
          ),
          if (status == 'confirmed' || status == 'pending') ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _callPatient(appointment['phone']),
                    icon: const Icon(Icons.phone, size: 18),
                    label: Text(tr('call')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2BB9A9),
                      side: const BorderSide(color: Color(0xFF2BB9A9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _startVisit(appointment),
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: Text(tr('nurseStartVisit')),
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
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2BB9A9).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF2BB9A9)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2BB9A9),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'confirmed':
        return tr('confirmed');
      case 'pending':
        return tr('pending');
      case 'completed':
        return tr('nurseCompleted');
      case 'cancelled':
        return tr('cancelled');
      default:
        return status;
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('filterBy'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildFilterOption('all', tr('allAppointments')),
            _buildFilterOption('today', tr('today')),
            _buildFilterOption('week', tr('thisWeek')),
            _buildFilterOption('month', tr('thisMonth')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String value, String label) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<String>(
        value: value,
        groupValue: _selectedFilter,
        onChanged: (newValue) {
          setState(() => _selectedFilter = newValue!);
          Navigator.pop(context);
        },
        activeColor: const Color(0xFF2BB9A9),
      ),
      title: Text(label),
      onTap: () {
        setState(() => _selectedFilter = value);
        Navigator.pop(context);
      },
    );
  }

  void _callPatient(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tr('calling')}: $phone'),
        backgroundColor: const Color(0xFF2BB9A9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _startVisit(Map<String, dynamic> appointment) {
    widget.onNavigate('nurse-active-visit');
    // Could pass appointment data via state management
  }
}
