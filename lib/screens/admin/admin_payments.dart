import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class AdminPayments extends StatefulWidget {
  final VoidCallback onBack;

  const AdminPayments({super.key, required this.onBack});

  @override
  State<AdminPayments> createState() => _AdminPaymentsState();
}

class _AdminPaymentsState extends State<AdminPayments> {
  String selectedTab = 'all';

  List<Map<String, dynamic>> get transactions {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': '#TRX001',
        'type': 'order',
        'customer': isArabic ? 'أحمد علي' : 'Ahmed Ali',
        'amount': 450,
        'status': 'completed',
        'date': '2024-01-15 10:30',
        'method': isArabic ? 'فودافون كاش' : 'Vodafone Cash',
      },
      {
        'id': '#TRX002',
        'type': 'appointment',
        'customer': isArabic ? 'فاطمة حسن' : 'Fatma Hassan',
        'amount': 200,
        'status': 'completed',
        'date': '2024-01-15 09:45',
        'method': isArabic ? 'بطاقة ائتمان' : 'Credit Card',
      },
      {
        'id': '#TRX003',
        'type': 'order',
        'customer': isArabic ? 'محمد سعيد' : 'Mohamed Said',
        'amount': 750,
        'status': 'pending',
        'date': '2024-01-14 16:20',
        'method': isArabic ? 'الدفع عند الاستلام' : 'Cash on Delivery',
      },
      {
        'id': '#TRX004',
        'type': 'refund',
        'customer': isArabic ? 'سارة أحمد' : 'Sara Ahmed',
        'amount': -120,
        'status': 'completed',
        'date': '2024-01-14 11:00',
        'method': isArabic ? 'استرداد' : 'Refund',
      },
      {
        'id': '#TRX005',
        'type': 'appointment',
        'customer': isArabic ? 'خالد محمود' : 'Khaled Mahmoud',
        'amount': 300,
        'status': 'failed',
        'date': '2024-01-13 14:30',
        'method': isArabic ? 'فوري' : 'Fawry',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE), Color(0xFFBFDBFE)],
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
                      _buildBalanceCard(),
                      const SizedBox(height: 20),
                      _buildQuickStats(),
                      const SizedBox(height: 20),
                      _buildTabs(),
                      const SizedBox(height: 20),
                      _buildTransactionsList(),
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
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
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
                  AppLocalizations.of(
                        context,
                      )?.translate('paymentsManagement') ??
                      'Payments',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.translate('managePayments') ??
                      'Manage financial transactions',
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
            child: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    final loc = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            loc?.translate('paymentAmount') ?? 'Current Balance',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            '248,500 ج.م',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '+12. 5% هذا الأسبوع',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF3B82F6),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(loc?.translate('processRefund') ?? 'Withdraw'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    loc?.translate('viewPaymentDetails') ?? 'Details',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final loc = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            loc?.translate('dailyRevenue') ?? 'Today Revenue',
            '12,450 ج.م',
            Icons.arrow_upward,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            loc?.translate('refundedPayments') ?? 'Refunded',
            '1,200 ج.م',
            Icons.arrow_downward,
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
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

  Widget _buildTabs() {
    final loc = AppLocalizations.of(context);
    final tabs = [
      {'key': 'all', 'label': loc?.translate('allPayments') ?? 'All'},
      {
        'key': 'completed',
        'label': loc?.translate('completedPayments') ?? 'Completed',
      },
      {
        'key': 'pending',
        'label': loc?.translate('pendingPayments') ?? 'Pending',
      },
      {
        'key': 'refund',
        'label': loc?.translate('refundedPayments') ?? 'Refunded',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab['key'];
          return GestureDetector(
            onTap: () => setState(() => selectedTab = tab['key']!),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                      )
                    : null,
                color: isSelected ? null : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tab['label']!,
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

  Widget _buildTransactionsList() {
    final filtered = selectedTab == 'all'
        ? transactions
        : selectedTab == 'refund'
        ? transactions.where((t) => t['type'] == 'refund').toList()
        : transactions.where((t) => t['status'] == selectedTab).toList();

    return Column(
      children: filtered
          .map((transaction) => _buildTransactionCard(transaction))
          .toList(),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final type = transaction['type'] as String;
    final status = transaction['status'] as String;
    final amount = transaction['amount'] as int;
    final loc = AppLocalizations.of(context);

    IconData typeIcon;
    Color typeColor;
    String typeText;

    switch (type) {
      case 'order':
        typeIcon = Icons.shopping_bag;
        typeColor = const Color(0xFFF97316);
        typeText = loc?.translate('orderType') ?? 'Order';
        break;
      case 'appointment':
        typeIcon = Icons.calendar_today;
        typeColor = const Color(0xFF3B82F6);
        typeText = loc?.translate('appointmentType') ?? 'Appointment';
        break;
      case 'refund':
        typeIcon = Icons.replay;
        typeColor = Colors.red;
        typeText = loc?.translate('refundedPayments') ?? 'Refund';
        break;
      default:
        typeIcon = Icons.payment;
        typeColor = Colors.grey;
        typeText = loc?.translate('paymentType') ?? 'Payment';
    }

    Color statusColor;
    String statusText;

    switch (status) {
      case 'completed':
        statusColor = Colors.green;
        statusText = loc?.translate('completedPayments') ?? 'Completed';
        break;
      case 'pending':
        statusColor = Colors.amber;
        statusText = loc?.translate('pendingPayments') ?? 'Pending';
        break;
      case 'failed':
        statusColor = Colors.red;
        statusText = loc?.translate('cancelledStatusAdmin') ?? 'Failed';
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(typeIcon, color: typeColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['customer'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          transaction['id'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: typeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            typeText,
                            style: TextStyle(fontSize: 10, color: typeColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${amount > 0 ? '+' : ''}$amount ج.م',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: amount > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(fontSize: 10, color: statusColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.payment, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      transaction['method'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                Text(
                  transaction['date'],
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
