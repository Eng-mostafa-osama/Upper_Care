import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';

class DoctorEarnings extends StatelessWidget {
  final VoidCallback onBack;

  const DoctorEarnings({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    final transactions = [
      {
        'id': 1,
        'patient': tr('patientFatmaAli'),
        'type': tr('checkupType'),
        'amount': 250,
        'date': '${tr('todayTime')} - 10:00 AM',
        'status': 'completed',
      },
      {
        'id': 2,
        'patient': tr('patientMohamedAhmed'),
        'type': tr('videoConsultationType'),
        'amount': 200,
        'date': '${tr('todayTime')} - 02:00 PM',
        'status': 'completed',
      },
      {
        'id': 3,
        'patient': tr('patientSaraHasan'),
        'type': tr('followUpType'),
        'amount': 150,
        'date': '${tr('yesterdayTime')} - 11:00 AM',
        'status': 'completed',
      },
      {
        'id': 4,
        'patient': tr('patientAhmedSaid'),
        'type': tr('checkupType'),
        'amount': 250,
        'date': '${tr('yesterdayTime')} - 04:00 PM',
        'status': 'pending',
      },
    ];

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFFFBEB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColorfulHeader(
              title: tr('earningsPayments'),
              subtitle: tr('incomeManagement'),
              onBack: onBack,
              showNotifications: true,
              gradient: 'sunset',
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildTotalEarningsCard(),
                  const SizedBox(height: 20),
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildPayoutMethods(),
                  const SizedBox(height: 20),
                  _buildTransactionsList(transactions),
                  const SizedBox(height: 20),
                  _buildFinancialSummary(),
                  const SizedBox(height: 20),
                  GradientButton(
                    variant: 'turquoise',
                    fullWidth: true,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.download,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(tr('downloadMonthlyReport')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalEarningsCard() {
    return GlassCard(
      gradient: 'sunset',
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.attach_money,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            tr('totalEarningsThisMonth'),
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            '15,250 ${tr('egp')}',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.trending_up,
                  color: Color(0xFF0A6DD9),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '+22% ${tr('comparedToLastMonth')}',
                  style: const TextStyle(
                    color: Color(0xFF0A6DD9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.calendar_today,
            label: tr('todayEarnings'),
            value: '850 ${tr('egp')}',
            gradient: 'orange',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatCard(
            icon: Icons.trending_up,
            label: tr('weekEarnings'),
            value: '4,200 ${tr('egp')}',
            gradient: 'green',
          ),
        ),
      ],
    );
  }

  Widget _buildPayoutMethods() {
    return GlassCard(
      gradient: 'blue',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('payoutMethods'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPayoutMethod(
            icon: Icons.credit_card,
            title: tr('bankAccount'),
            subtitle: '**** **** **** 4532',
            isActive: true,
            gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
          ),
          const SizedBox(height: 12),
          _buildPayoutMethod(
            icon: Icons.account_balance_wallet,
            title: tr('eWallet'),
            subtitle: tr('vodafoneCash'),
            isActive: false,
            gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
          ),
          const SizedBox(height: 16),
          GradientButton(
            variant: 'blue',
            fullWidth: true,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.download, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(tr('requestPayout')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
    required List<Color> gradientColors,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF0A6DD9).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white),
          ),
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
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tr('active'),
                style: const TextStyle(fontSize: 10, color: Color(0xFF0A6DD9)),
              ),
            )
          else
            TextButton(
              onPressed: () {},
              child: Text(
                tr('activate'),
                style: const TextStyle(color: Color(0xFF0A6DD9), fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<Map<String, dynamic>> transactions) {
    return GlassCard(
      gradient: 'turquoise',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('recentTransactions'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  tr('viewAllAppointments'),
                  style: const TextStyle(color: Color(0xFF2BB9A9)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...transactions
              .map(
                (t) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF2BB9A9).withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['patient'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              t['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${t['amount']} ج. م',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: t['status'] == 'completed'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              t['status'] == 'completed'
                                  ? tr('completed')
                                  : tr('underReview'),
                              style: TextStyle(
                                fontSize: 10,
                                color: t['status'] == 'completed'
                                    ? Colors.green[700]
                                    : Colors.orange[700],
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildFinancialSummary() {
    return GlassCard(
      gradient: 'green',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('financialSummary'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            '${tr('todayAppointments')}',
            '68 ${tr('appointmentsCount')}',
          ),
          _buildSummaryRow(tr('averagePrice'), '225 ${tr('egp')}'),
          _buildSummaryRow(
            tr('platformCommission'),
            '- 1,525 ${tr('egp')}',
            isDeduction: true,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('netEarnings'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '13,725 ${tr('egp')}',
                  style: const TextStyle(
                    color: Color(0xFF0A6DD9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isDeduction = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700])),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDeduction ? Colors.red[600] : null,
            ),
          ),
        ],
      ),
    );
  }
}

