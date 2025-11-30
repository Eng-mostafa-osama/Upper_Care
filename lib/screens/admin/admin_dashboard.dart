import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AdminDashboard extends StatelessWidget {
  final Function(String) onNavigate;

  const AdminDashboard({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF3E8FF), Color(0xFFFCE7F3), Color(0xFFFFE4E6)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(loc),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildKeyMetrics(loc),
                      const SizedBox(height: 20),
                      _buildQuickActions(loc),
                      const SizedBox(height: 20),
                      _buildPlatformStats(loc),
                      const SizedBox(height: 20),
                      _buildAlerts(loc),
                      const SizedBox(height: 20),
                      _buildRevenueSection(loc),
                      const SizedBox(height: 20),
                      _buildManagementLinks(loc),
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

  Widget _buildHeader(AppLocalizations? loc) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => onNavigate('admin-settings'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.settings, color: Colors.white),
                ),
              ),
              Column(
                children: [
                  Text(
                    loc?.translate('adminDashboardTitle') ?? 'Dashboard',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    loc?.translate('platformOverview') ?? 'Platform Overview',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () => onNavigate('admin-notifications'),
                  child: Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetrics(AppLocalizations? loc) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _buildStatCard(
          Icons.people,
          loc?.translate('totalUsers') ?? 'Total Users',
          '12,450',
          '+8. 5%',
          const Color(0xFF06B6D4),
        ),
        _buildStatCard(
          Icons.shopping_cart,
          loc?.translate('ordersToday') ?? 'Orders Today',
          '156',
          '+12%',
          const Color(0xFFF97316),
        ),
        _buildStatCard(
          Icons.calendar_today,
          loc?.translate('activeAppointments') ?? 'Active Appointments',
          '89',
          '',
          const Color(0xFF3B82F6),
        ),
        _buildStatCard(
          Icons.attach_money,
          loc?.translate('dailyRevenue') ?? 'Daily Revenue',
          '48,500 EGP',
          '+22%',
          const Color(0xFF10B981),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String label,
    String value,
    String trend,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (trend.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    trend,
                    style: const TextStyle(color: Colors.green, fontSize: 10),
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(AppLocalizations? loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
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
          Text(
            loc?.translate('quickManagement') ?? 'Quick Management',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _buildActionButton(
                Icons.people,
                loc?.translate('usersMenuItem') ?? 'Users',
                const Color(0xFF8B5CF6),
                () => onNavigate('admin-users'),
              ),
              _buildActionButton(
                Icons.shopping_cart,
                loc?.translate('ordersMenuItem') ?? 'Orders',
                const Color(0xFFF97316),
                () => onNavigate('admin-orders'),
              ),
              _buildActionButton(
                Icons.medical_services,
                loc?.translate('doctorsMenuItem') ?? 'Doctors',
                const Color(0xFF06B6D4),
                () => onNavigate('admin-doctors'),
              ),
              _buildActionButton(
                Icons.inventory,
                loc?.translate('inventoryMenuItem') ?? 'Inventory',
                const Color(0xFF10B981),
                () => onNavigate('admin-inventory'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
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
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.2), blurRadius: 8),
                ],
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformStats(AppLocalizations? loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0EA5E9).withOpacity(0.1),
            const Color(0xFF06B6D4).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc?.translate('platformStats') ?? 'Platform Statistics',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            Icons.people,
            loc?.translate('patients') ?? 'Patients',
            '8,240',
            const Color(0xFF3B82F6),
          ),
          _buildStatRow(
            Icons.medical_services,
            loc?.translate('doctors') ?? 'Doctors',
            '142',
            const Color(0xFF10B981),
          ),
          _buildStatRow(
            Icons.local_hospital,
            loc?.translate('nurses') ?? 'Nurses',
            '86',
            const Color(0xFF06B6D4),
          ),
          _buildStatRow(
            Icons.local_shipping,
            loc?.translate('distributors') ?? 'Distributors',
            '24',
            const Color(0xFFF97316),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(label, style: TextStyle(color: Colors.grey[700])),
            ],
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAlerts(AppLocalizations? loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF97316).withOpacity(0.1),
            const Color(0xFFFB923C).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc?.translate('importantAlerts') ?? 'Important Alerts',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildAlertItem(
            loc?.translate('lowStock') ?? 'Low Stock',
            loc?.translate('productsNeedRestock') ??
                '18 products need restocking',
            Colors.red,
            () => onNavigate('admin-inventory'),
            loc,
          ),
          _buildAlertItem(
            loc?.translate('approvalRequests') ?? 'Approval Requests',
            loc?.translate('doctorsAwaitingVerification') ??
                '8 doctors awaiting verification',
            Colors.amber,
            () => onNavigate('admin-doctors'),
            loc,
          ),
          _buildAlertItem(
            loc?.translate('refundRequests') ?? 'Refund Requests',
            loc?.translate('refundsUnderReview') ??
                '12 refund requests under review',
            Colors.blue,
            () => onNavigate('admin-orders'),
            loc,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
    AppLocalizations? loc,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(14),
          border: Border(right: BorderSide(color: color, width: 4)),
        ),
        child: Row(
          children: [
            Icon(Icons.warning_amber, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Text(
              loc?.translate('view') ?? 'View',
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueSection(AppLocalizations? loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF10B981).withOpacity(0.1),
            const Color(0xFF059669).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc?.translate('revenueLast7Days') ?? 'Revenue - Last 7 Days',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildRevenueCard(
                  loc?.translate('medicines') ?? 'Medicines',
                  '1.2M EGP',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildRevenueCard(
                  loc?.translate('appointments') ?? 'Appointments',
                  '340K EGP',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildRevenueCard(
                  loc?.translate('nursing') ?? 'Nursing',
                  '180K EGP',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc?.translate('totalRevenue') ?? 'Total Revenue',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Row(
                  children: [
                    Icon(Icons.trending_up, color: Color(0xFF059669), size: 20),
                    SizedBox(width: 8),
                    Text(
                      '1.72M EGP',
                      style: TextStyle(
                        color: Color(0xFF059669),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildManagementLinks(AppLocalizations? loc) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onNavigate('admin-payments'),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6).withOpacity(0.1),
                    const Color(0xFF2563EB).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.payments,
                      color: Color(0xFF3B82F6),
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    loc?.translate('paymentsMenuItem') ?? 'Payments',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    loc?.translate('financialReports') ?? 'Financial Reports',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onNavigate('admin-reports'),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF06B6D4).withOpacity(0.1),
                    const Color(0xFF0891B2).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.analytics,
                      color: Color(0xFF06B6D4),
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    loc?.translate('reportsMenuItem') ?? 'Reports',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    loc?.translate('comprehensiveAnalytics') ??
                        'Comprehensive Analytics',
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
