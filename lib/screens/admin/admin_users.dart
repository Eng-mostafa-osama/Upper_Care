import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class AdminUsers extends StatefulWidget {
  final VoidCallback onBack;

  const AdminUsers({super.key, required this.onBack});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  String selectedTab = 'patients';

  Map<String, List<Map<String, dynamic>>> get users {
    final isArabic = localeProvider.isArabic;
    return {
      'patients': [
        {
          'id': 1,
          'name': isArabic ? 'أحمد علي' : 'Ahmed Ali',
          'email': 'ahmed@example.com',
          'phone': '01234567890',
          'status': 'active',
          'orders': 12,
          'joined': '2024-01-15',
        },
        {
          'id': 2,
          'name': isArabic ? 'فاطمة حسن' : 'Fatma Hassan',
          'email': 'fatma@example.com',
          'phone': '01234567891',
          'status': 'active',
          'orders': 8,
          'joined': '2024-02-20',
        },
        {
          'id': 3,
          'name': isArabic ? 'محمد سعيد' : 'Mohamed Said',
          'email': 'mohamed@example.com',
          'phone': '01234567892',
          'status': 'inactive',
          'orders': 3,
          'joined': '2024-03-10',
        },
        {
          'id': 4,
          'name': isArabic ? 'سارة أحمد' : 'Sara Ahmed',
          'email': 'sara@example.com',
          'phone': '01234567893',
          'status': 'active',
          'orders': 15,
          'joined': '2024-01-05',
        },
      ],
      'doctors': [
        {
          'id': 1,
          'name': isArabic ? 'د. أحمد محمود' : 'Dr. Ahmed Mahmoud',
          'specialty': isArabic ? 'باطنة' : 'Internal Medicine',
          'email': 'dr.ahmed@example.com',
          'status': 'verified',
          'appointments': 156,
          'rating': 4.8,
        },
        {
          'id': 2,
          'name': isArabic ? 'د. سارة إبراهيم' : 'Dr. Sara Ibrahim',
          'specialty': isArabic ? 'أطفال' : 'Pediatrics',
          'email': 'dr.sara@example.com',
          'status': 'pending',
          'appointments': 0,
          'rating': 0.0,
        },
        {
          'id': 3,
          'name': isArabic ? 'د. خالد حسن' : 'Dr. Khaled Hassan',
          'specialty': isArabic ? 'جراحة' : 'Surgery',
          'email': 'dr.khaled@example.com',
          'status': 'verified',
          'appointments': 89,
          'rating': 4.6,
        },
        {
          'id': 4,
          'name': isArabic ? 'د. منى علي' : 'Dr. Mona Ali',
          'specialty': isArabic ? 'نساء وتوليد' : 'OB/GYN',
          'email': 'dr.mona@example.com',
          'status': 'pending',
          'appointments': 0,
          'rating': 0.0,
        },
      ],
      'nurses': [
        {
          'id': 1,
          'name': isArabic ? 'أ. منى إبراهيم' : 'Mona Ibrahim',
          'email': 'mona@example.com',
          'status': 'verified',
          'visits': 124,
          'rating': 4.9,
        },
        {
          'id': 2,
          'name': isArabic ? 'أ. هدى محمود' : 'Hoda Mahmoud',
          'email': 'hoda@example.com',
          'status': 'verified',
          'visits': 96,
          'rating': 4.7,
        },
        {
          'id': 3,
          'name': isArabic ? 'أ. نورا علي' : 'Nora Ali',
          'email': 'nora@example.com',
          'status': 'pending',
          'visits': 0,
          'rating': 0.0,
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEEF2FF), Color(0xFFF3E8FF), Color(0xFFFCE7F3)],
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
                      _buildTabs(),
                      const SizedBox(height: 20),
                      _buildUsersList(),
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
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
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
                  AppLocalizations.of(context)?.translate('userManagement') ??
                      'User Management',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.translate('manageUsers') ??
                      'Manage platform users',
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
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            loc?.translate('patients') ?? 'Patients',
            '8,240',
            const Color(0xFF06B6D4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('doctorsAdmin') ?? 'Doctors',
            '142',
            const Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('nurses') ?? 'Nurses',
            '86',
            const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(Icons.people, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildTab(
            'patients',
            loc?.translate('patients') ?? 'Patients',
            const Color(0xFF06B6D4),
          ),
          _buildTab(
            'doctors',
            loc?.translate('doctorsAdmin') ?? 'Doctors',
            const Color(0xFFF97316),
          ),
          _buildTab(
            'nurses',
            loc?.translate('nurses') ?? 'Nurses',
            const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String key, String label, Color color) {
    final isSelected = selectedTab == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [color, color.withOpacity(0.8)])
                : null,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8)]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsersList() {
    final currentUsers = users[selectedTab] ?? [];
    return Column(
      children: currentUsers.map((user) => _buildUserCard(user)).toList(),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    final status = user['status'] as String;
    final isPending = status == 'pending';
    final isVerified = status == 'verified' || status == 'active';
    final loc = AppLocalizations.of(context);

    Color statusColor;
    String statusText;
    if (isVerified) {
      statusColor = Colors.green;
      statusText = status == 'verified'
          ? (loc?.translate('verifiedDoctors') ?? 'Verified')
          : (loc?.translate('activeStatus') ?? 'Active');
    } else if (isPending) {
      statusColor = Colors.amber;
      statusText = loc?.translate('pendingDoctors') ?? 'Pending';
    } else {
      statusColor = Colors.grey;
      statusText = loc?.translate('blockedStatus') ?? 'Inactive';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF06B6D4), Color(0xFF14B8A6)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    user['name'].toString().substring(0, 1),
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
                      user['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user['email'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    if (user['specialty'] != null)
                      Text(
                        user['specialty'],
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
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(color: statusColor, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (user['orders'] != null)
                _buildInfoChip(
                  '${loc?.translate('userOrders') ?? 'Orders'}: ${user['orders']}',
                ),
              if (user['appointments'] != null)
                _buildInfoChip(
                  '${loc?.translate('totalAppointments') ?? 'Appointments'}: ${user['appointments']}',
                ),
              if (user['visits'] != null)
                _buildInfoChip(
                  '${loc?.translate('nursing') ?? 'Visits'}: ${user['visits']}',
                ),
              if (user['rating'] != null && user['rating'] > 0)
                _buildInfoChip('⭐ ${user['rating']}'),
            ],
          ),
          const SizedBox(height: 12),
          if (isPending)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check, size: 18),
                    label: Text(loc?.translate('verifyDoctor') ?? 'Verify'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
                    onPressed: () {},
                    icon: const Icon(Icons.close, size: 18),
                    label: Text(loc?.translate('rejectDoctor') ?? 'Reject'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  loc?.translate('viewUserDetails') ?? 'View Details',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
    );
  }
}
