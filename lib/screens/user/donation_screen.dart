import 'package:flutter/material.dart';
import '../../providers/theme_provider.dart';
import '../../l10n/app_localizations.dart';

class DonationCampaign {
  final String id;
  final String title;
  final String description;
  final String location;
  final int beneficiaries;
  final double raised;
  final double goal;
  final List<Color> gradientColors;

  DonationCampaign({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.beneficiaries,
    required this.raised,
    required this.goal,
    required this.gradientColors,
  });
}

class DonationScreen extends StatefulWidget {
  final VoidCallback onBack;

  const DonationScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  int? selectedAmount;
  String customAmount = '';
  String donationType = 'money';
  List<String> uploadedFiles = [];

  final List<int> donationAmounts = [50, 100, 200, 500, 1000];

  List<DonationCampaign> get campaigns => [
    DonationCampaign(
      id: '1',
      title: tr('campaignMedicineForFamilies'),
      description: tr('campaignMedicineDesc'),
      location: tr('qena'),
      beneficiaries: 150,
      raised: 12500,
      goal: 25000,
      gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
    ),
    DonationCampaign(
      id: '2',
      title: tr('campaignFreeVisits'),
      description: tr('campaignFreeVisitsDesc'),
      location: tr('aswan'),
      beneficiaries: 300,
      raised: 35000,
      goal: 50000,
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF0A6DD9)],
    ),
    DonationCampaign(
      id: '3',
      title: tr('campaignMedicalSupplies'),
      description: tr('campaignMedicalSuppliesDesc'),
      location: tr('sohag'),
      beneficiaries: 500,
      raised: 18000,
      goal: 40000,
      gradientColors: [const Color(0xFFE9E9E9), const Color(0xFFE9E9E9)],
    ),
  ];

  void handleDonate() {
    final amount = selectedAmount ?? double.tryParse(customAmount) ?? 0;
    if (amount > 0 || uploadedFiles.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              const Icon(Icons.favorite, color: Color(0xFFFF7D40), size: 32),
              const SizedBox(width: 12),
              Text(tr('thankForDonation')),
            ],
          ),
          content: Text(
            donationType == 'money'
                ? '${tr('amount')}: $amount ${tr('egp')}'
                : tr('itemDonationReceived'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr('done')),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildDonationTypeSelector(),
                      const SizedBox(height: 24),
                      if (donationType == 'money') _buildMoneyDonation(),
                      if (donationType == 'medicine' ||
                          donationType == 'supplies')
                        _buildItemDonation(),
                      const SizedBox(height: 24),
                      _buildCampaignsSection(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_shouldShowDonateButton()) _buildFloatingDonateButton(),
        ],
      ),
    );
  }

  bool _shouldShowDonateButton() {
    if (donationType == 'money') {
      return selectedAmount != null || customAmount.isNotEmpty;
    }
    return uploadedFiles.isNotEmpty;
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7D40), Color(0xFFE9E9E9), Color(0xFFE9E9E9)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Decorative pattern
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(12, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: index % 2 == 0 ? 12 : 8,
                    height: index % 2 == 0 ? 12 : 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: index % 2 == 0
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      borderRadius: index % 2 == 0
                          ? null
                          : BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: widget.onBack,
                  ),
                  Text(
                    tr('donations'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),

              // Hero card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF7D40), Color(0xFFE9E9E9)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF7D40).withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr('donationChangesLives'),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tr('helpImproveHealthcare'),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonationTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          tr('donationType'),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDonationTypeCard(
                'supplies',
                tr('supplies'),
                Icons.receipt_long,
                const Color(0xFFE9E9E9),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDonationTypeCard(
                'medicine',
                tr('medicinesCategory'),
                Icons.medical_services,
                const Color(0xFF2BB9A9),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDonationTypeCard(
                'money',
                tr('moneyDonation'),
                Icons.attach_money,
                const Color(0xFFFF9E57),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDonationTypeCard(
    String type,
    String label,
    IconData icon,
    Color color,
  ) {
    final isSelected = donationType == type;
    return GestureDetector(
      onTap: () => setState(() => donationType = type),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(colors: [color, color.withOpacity(0.7)])
                    : null,
                color: isSelected ? null : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoneyDonation() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            tr('chooseAmount'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.end,
            children: donationAmounts.map((amount) {
              final isSelected = selectedAmount == amount;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAmount = amount;
                    customAmount = '';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFFF9E57)
                          : Colors.grey[200]!,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    '$amount ${tr('egp')}',
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFFFF9E57)
                          : Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            textDirection: TextDirection.rtl,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                customAmount = value;
                selectedAmount = null;
              });
            },
            decoration: InputDecoration(
              hintText: tr('orEnterOtherAmount'),
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixText: '${tr('egp')} ',
              prefixStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFFF9E57),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemDonation() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            donationType == 'medicine'
                ? tr('medicinePictures')
                : tr('suppliesPictures'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            donationType == 'medicine'
                ? tr('pleasePhotographMedicines')
                : tr('pleasePhotographSupplies'),
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              // Simulate file upload
              setState(() {
                uploadedFiles.add('image_${uploadedFiles.length + 1}');
              });
            },
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE9E9E9),
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload,
                    size: 48,
                    color: Color(0xFFE9E9E9),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tr('clickToUpload'),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    tr('orDragFilesHere'),
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          if (uploadedFiles.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: uploadedFiles.asMap().entries.map((entry) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE9E9E9).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[400],
                          size: 32,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCampaignsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          tr('activeCampaigns'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...campaigns.map((campaign) => _buildCampaignCard(campaign)).toList(),
      ],
    );
  }

  Widget _buildCampaignCard(DonationCampaign campaign) {
    final progress = campaign.raised / campaign.goal;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          // Image header
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: campaign.gradientColors),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.favorite,
                    size: 64,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Text(
                        campaign.location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  campaign.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  campaign.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),

                // Stats
                Row(
                  children: [
                    Text(
                      '${campaign.beneficiaries} ${tr('beneficiaryCount')}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.people, size: 16, color: Colors.grey[600]),
                  ],
                ),
                const SizedBox(height: 16),

                // Progress bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${tr('fromGoal')} ${campaign.goal.toInt()} ${tr('egp')}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    Text(
                      '${campaign.raised.toInt()} ${tr('egp')}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      campaign.gradientColors[0],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Donate button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: campaign.gradientColors[0],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(tr('donateNow')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingDonateButton() {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24,
      child: GestureDetector(
        onTap: handleDonate,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF7D40), Color(0xFFE9E9E9)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF7D40).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('completeDonation'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.favorite, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}





