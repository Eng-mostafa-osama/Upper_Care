import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class AdminDoctors extends StatefulWidget {
  final VoidCallback onBack;

  const AdminDoctors({super.key, required this.onBack});

  @override
  State<AdminDoctors> createState() => _AdminDoctorsState();
}

class _AdminDoctorsState extends State<AdminDoctors> {
  String selectedFilter = 'all';

  List<Map<String, dynamic>> get doctors {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'name': isArabic ? 'د. أحمد محمود' : 'Dr. Ahmed Mahmoud',
        'specialty': isArabic ? 'باطنة' : 'Internal Medicine',
        'phone': '01234567890',
        'status': 'verified',
        'appointments': 156,
        'rating': 4.8,
        'earnings': 45000,
      },
      {
        'id': 2,
        'name': isArabic ? 'د. سارة إبراهيم' : 'Dr. Sara Ibrahim',
        'specialty': isArabic ? 'أطفال' : 'Pediatrics',
        'phone': '01234567891',
        'status': 'pending',
        'appointments': 0,
        'rating': 0.0,
        'earnings': 0,
      },
      {
        'id': 3,
        'name': isArabic ? 'د. خالد حسن' : 'Dr. Khaled Hassan',
        'specialty': isArabic ? 'جراحة' : 'Surgery',
        'phone': '01234567892',
        'status': 'verified',
        'appointments': 89,
        'rating': 4.6,
        'earnings': 32000,
      },
      {
        'id': 4,
        'name': isArabic ? 'د. منى علي' : 'Dr. Mona Ali',
        'specialty': isArabic ? 'نساء وتوليد' : 'Obstetrics & Gynecology',
        'phone': '01234567893',
        'status': 'pending',
        'appointments': 0,
        'rating': 0.0,
        'earnings': 0,
      },
      {
        'id': 5,
        'name': isArabic ? 'د. محمد سعيد' : 'Dr. Mohamed Said',
        'specialty': isArabic ? 'عظام' : 'Orthopedics',
        'phone': '01234567894',
        'status': 'verified',
        'appointments': 124,
        'rating': 4.9,
        'earnings': 58000,
      },
      {
        'id': 6,
        'name': isArabic ? 'د. فاطمة أحمد' : 'Dr. Fatma Ahmed',
        'specialty': isArabic ? 'جلدية' : 'Dermatology',
        'phone': '01234567895',
        'status': 'suspended',
        'appointments': 45,
        'rating': 3.2,
        'earnings': 12000,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = selectedFilter == 'all'
        ? doctors
        : doctors.where((d) => d['status'] == selectedFilter).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFECFEFF), Color(0xFFF0F9FF), Color(0xFFE0F2FE)],
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
                      _buildStats(),
                      const SizedBox(height: 20),
                      _buildFilters(),
                      const SizedBox(height: 20),
                      _buildDoctorsList(filteredDoctors),
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
          colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
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
                  AppLocalizations.of(context)?.translate('doctorManagement') ??
                      'Doctor Management',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.translate('manageDoctors') ??
                      'Manage and verify doctors',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final loc = AppLocalizations.of(context);
    final verified = doctors.where((d) => d['status'] == 'verified').length;
    final pending = doctors.where((d) => d['status'] == 'pending').length;
    final suspended = doctors.where((d) => d['status'] == 'suspended').length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            loc?.translate('verifiedDoctors') ?? 'Verified',
            verified.toString(),
            const Color(0xFF10B981),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('pendingDoctors') ?? 'Pending',
            pending.toString(),
            const Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('rejectedDoctors') ?? 'Suspended',
            suspended.toString(),
            const Color(0xFFEF4444),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final loc = AppLocalizations.of(context);
    final filters = [
      {'key': 'all', 'label': loc?.translate('allUsers') ?? 'All'},
      {
        'key': 'verified',
        'label': loc?.translate('verifiedDoctors') ?? 'Verified',
      },
      {
        'key': 'pending',
        'label': loc?.translate('pendingDoctors') ?? 'Pending',
      },
      {
        'key': 'suspended',
        'label': loc?.translate('rejectedDoctors') ?? 'Suspended',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter['key'];
          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filter['key']!),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
                      )
                    : null,
                color: isSelected ? null : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter['label']!,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDoctorsList(List<Map<String, dynamic>> doctorsList) {
    return Column(
      children: doctorsList.map((doctor) => _buildDoctorCard(doctor)).toList(),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    final status = doctor['status'] as String;
    final rating = doctor['rating'] as double;
    final loc = AppLocalizations.of(context);

    Color statusColor;
    String statusText;

    switch (status) {
      case 'verified':
        statusColor = const Color(0xFF10B981);
        statusText = loc?.translate('verifiedDoctors') ?? 'Verified';
        break;
      case 'pending':
        statusColor = const Color(0xFFF97316);
        statusText = loc?.translate('pendingDoctors') ?? 'Pending';
        break;
      case 'suspended':
        statusColor = const Color(0xFFEF4444);
        statusText = loc?.translate('rejectedDoctors') ?? 'Suspended';
        break;
      default:
        statusColor = Colors.grey;
        statusText = loc?.translate('unknownStatus') ?? 'Unknown';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    doctor['name'].toString().substring(2, 3),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
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
                      doctor['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      doctor['specialty'],
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    Text(
                      doctor['phone'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  Icons.calendar_today,
                  '${doctor['appointments']}',
                  loc?.translate('totalAppointments') ?? 'Appointments',
                ),
                Container(width: 1, height: 30, color: Colors.grey[300]),
                _buildInfoItem(
                  Icons.star,
                  rating > 0 ? rating.toString() : '-',
                  loc?.translate('doctorRating') ?? 'Rating',
                ),
                Container(width: 1, height: 30, color: Colors.grey[300]),
                _buildInfoItem(
                  Icons.attach_money,
                  '${doctor['earnings']}',
                  loc?.translate('doctorEarnings') ?? 'Earnings',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (status == 'pending')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _approveDoctor(doctor),
                    icon: const Icon(Icons.check, size: 18),
                    label: Text(loc?.translate('verifyDoctor') ?? 'Verify'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _rejectDoctor(doctor),
                    icon: const Icon(Icons.close, size: 18),
                    label: Text(loc?.translate('rejectDoctor') ?? 'Reject'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else if (status == 'verified')
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility, size: 18),
                    label: Text(
                      loc?.translate('viewDoctorProfile') ?? 'View Profile',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF06B6D4),
                      side: const BorderSide(color: Color(0xFF06B6D4)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _suspendDoctor(doctor),
                    icon: const Icon(Icons.block, size: 18),
                    label: Text(loc?.translate('blockUser') ?? 'Block'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else if (status == 'suspended')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _reactivateDoctor(doctor),
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(loc?.translate('unblockUser') ?? 'Reactivate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
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

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  void _approveDoctor(Map<String, dynamic> doctor) {
    final loc = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${loc?.translate('doctorApproved') ?? 'approved'} ${doctor['name']}',
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _rejectDoctor(Map<String, dynamic> doctor) {
    final loc = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${loc?.translate('doctorRejected') ?? 'rejected'} ${doctor['name']}',
        ),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _suspendDoctor(Map<String, dynamic> doctor) {
    final loc = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${loc?.translate('doctorSuspended') ?? 'suspended'} ${doctor['name']}',
        ),
        backgroundColor: const Color(0xFFF97316),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _reactivateDoctor(Map<String, dynamic> doctor) {
    final loc = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${loc?.translate('doctorReactivated') ?? 'reactivated'} ${doctor['name']}',
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
