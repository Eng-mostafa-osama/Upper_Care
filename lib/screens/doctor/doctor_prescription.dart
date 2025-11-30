import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class DoctorPrescription extends StatefulWidget {
  final VoidCallback onBack;

  const DoctorPrescription({Key? key, required this.onBack}) : super(key: key);

  @override
  State<DoctorPrescription> createState() => _DoctorPrescriptionState();
}

class _DoctorPrescriptionState extends State<DoctorPrescription> {
  String selectedTab = 'recent';

  List<Map<String, dynamic>> get recentPrescriptions {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'patient': isArabic ? 'فاطمة علي' : 'Fatma Ali',
        'date': isArabic ? 'اليوم - 10:30 ص' : 'Today - 10:30 AM',
        'medications': 3,
        'status': 'sent',
      },
      {
        'id': 2,
        'patient': isArabic ? 'محمد أحمد' : 'Mohamed Ahmed',
        'date': isArabic ? 'اليوم - 02:00 م' : 'Today - 02:00 PM',
        'medications': 2,
        'status': 'sent',
      },
      {
        'id': 3,
        'patient': isArabic ? 'سارة حسن' : 'Sara Hassan',
        'date': isArabic ? 'أمس - 11:00 ص' : 'Yesterday - 11:00 AM',
        'medications': 4,
        'status': 'sent',
      },
    ];
  }

  List<Map<String, dynamic>> get templates {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'name': isArabic
            ? 'علاج ضغط الدم المرتفع'
            : 'High Blood Pressure Treatment',
        'medications': 2,
        'uses': 45,
      },
      {
        'id': 2,
        'name': isArabic
            ? 'علاج السكري النوع الثاني'
            : 'Type 2 Diabetes Treatment',
        'medications': 3,
        'uses': 38,
      },
      {
        'id': 3,
        'name': isArabic ? 'علاج الكوليسترول' : 'Cholesterol Treatment',
        'medications': 2,
        'uses': 29,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColorfulHeader(
              title: tr('medicalPrescriptions'),
              subtitle: tr('manageSendPrescriptions'),
              onBack: widget.onBack,
              showNotifications: true,
              gradient: 'sunset',
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildCreatePrescriptionCard(),
                  const SizedBox(height: 20),
                  _buildUploadCard(),
                  const SizedBox(height: 20),
                  _buildTabs(),
                  const SizedBox(height: 20),
                  if (selectedTab == 'recent')
                    _buildRecentList()
                  else
                    _buildTemplatesList(),
                  const SizedBox(height: 20),
                  _buildStatistics(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatePrescriptionCard() {
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
            child: const Icon(Icons.description, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            tr('createNewPrescription'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            tr('createSendDigitalPrescription'),
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          GradientButton(
            variant: 'sunset',
            fullWidth: true,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(tr('startNewPrescription')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard() {
    return GlassCard(
      gradient: 'blue',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('uploadWrittenPrescription'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF0A6DD9).withOpacity(0.3),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload,
                  size: 48,
                  color: const Color(0xFF0A6DD9).withOpacity(0.6),
                ),
                const SizedBox(height: 12),
                Text(
                  tr('dragDropImage'),
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Text(
                  tr('orClickToChoose'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A6DD9),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(tr('chooseFile')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            tr('supportedFormats'),
            style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            textAlign: TextAlign.center,
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
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = 'recent'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: selectedTab == 'recent'
                      ? const LinearGradient(
                          colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${tr('recent')} (${recentPrescriptions.length})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTab == 'recent'
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = 'templates'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: selectedTab == 'templates'
                      ? const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${tr('templates')} (${templates.length})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTab == 'templates'
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentList() {
    return Column(
      children: recentPrescriptions
          .map(
            (prescription) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: GlassCard(
                gradient: 'turquoise',
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
                              colors: [Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.description,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prescription['patient'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                prescription['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF2BB9A9,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${prescription['medications']} ${tr('medications')}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF2BB9A9),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 12,
                                          color: Color(0xFF0A6DD9),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          tr('sent'),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF0A6DD9),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSmallActionButton(
                            Icons.visibility,
                            tr('view'),
                            const Color(0xFF2BB9A9),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSmallActionButton(
                            Icons.download,
                            tr('download'),
                            const Color(0xFF0A6DD9),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSmallActionButton(
                            Icons.send,
                            tr('resend'),
                            const Color(0xFF0A6DD9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTemplatesList() {
    return Column(
      children: [
        ...templates
            .map(
              (template) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: GlassCard(
                  gradient: 'green',
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
                                colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.description,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  template['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF0A6DD9,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${template['medications']} أدوية',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF0A6DD9),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'استخدم ${template['uses']} مرة',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add, size: 18),
                              label: Text(tr('useTemplate')),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0A6DD9),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.visibility,
                                color: Color(0xFF0A6DD9),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFF43F5E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
        const SizedBox(height: 8),
        GradientButton(
          variant: 'green',
          fullWidth: true,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(tr('createNewTemplate')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallActionButton(IconData icon, String label, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 14, color: color),
        label: Text(label, style: TextStyle(fontSize: 10, color: color)),
      ),
    );
  }

  Widget _buildStatistics() {
    return GlassCard(
      gradient: 'nile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('prescriptionStats'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildStatItem('247', tr('totalPrescriptions')),
              _buildStatItem('18', tr('thisWeekPrescriptions')),
              _buildStatItem('8', tr('savedTemplates')),
              _buildStatItem('95%', tr('fulfillmentRate')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
