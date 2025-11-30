import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';

class LabTest {
  final String id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final List<Color> gradientColors;
  final IconData icon;

  LabTest({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.gradientColors,
    required this.icon,
  });
}

class Lab {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int reviews;
  final bool isOpen;
  final List<Color> gradientColors;

  Lab({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.isOpen,
    required this.gradientColors,
  });
}

class LabsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const LabsScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  State<LabsScreen> createState() => _LabsScreenState();
}

class _LabsScreenState extends State<LabsScreen> {
  String selectedCategory = 'all';
  List<String> selectedTests = [];

  List<Map<String, dynamic>> get categories => [
    {'id': 'all', 'name': tr('all')},
    {'id': 'blood', 'name': tr('bloodTests')},
    {'id': 'urine', 'name': tr('urineTests')},
    {'id': 'hormones', 'name': tr('hormones')},
    {'id': 'vitamins', 'name': tr('vitamins')},
  ];

  List<LabTest> get tests => [
    LabTest(
      id: '1',
      name: tr('completBloodCount'),
      description: tr('bloodComponentsAnalysis'),
      price: 80,
      duration: tr('hour24'),
      gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
      icon: Icons.bloodtype,
    ),
    LabTest(
      id: '2',
      name: tr('liverFunctions'),
      description: 'ALT, AST, Bilirubin',
      price: 150,
      duration: tr('hour24'),
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF0A6DD9)],
      icon: Icons.medical_services,
    ),
    LabTest(
      id: '3',
      name: tr('kidneyFunctions'),
      description: 'Creatinine, Urea, Uric Acid',
      price: 120,
      duration: tr('hour24'),
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      icon: Icons.science,
    ),
    LabTest(
      id: '4',
      name: tr('cumulativeSugar'),
      description: tr('diabetesMonitoring'),
      price: 100,
      duration: tr('hour48'),
      gradientColors: [const Color(0xFFE9E9E9), const Color(0xFFE9E9E9)],
      icon: Icons.monitor_heart,
    ),
    LabTest(
      id: '5',
      name: tr('thyroidFunction'),
      description: 'TSH, T3, T4',
      price: 200,
      duration: tr('hour48'),
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF2BB9A9)],
      icon: Icons.auto_graph,
    ),
    LabTest(
      id: '6',
      name: tr('vitaminD'),
      description: 'Vitamin D3',
      price: 180,
      duration: tr('hour72'),
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      icon: Icons.wb_sunny,
    ),
  ];

  List<Lab> get labs => [
    Lab(
      id: '1',
      name: tr('healthLab'),
      location: tr('aswanCorniche'),
      rating: 4.8,
      reviews: 156,
      isOpen: true,
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
    ),
    Lab(
      id: '2',
      name: tr('lifeLab'),
      location: tr('qenaRepublic'),
      rating: 4.6,
      reviews: 98,
      isOpen: true,
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF0A6DD9)],
    ),
    Lab(
      id: '3',
      name: tr('noorLab'),
      location: tr('sohagStation'),
      rating: 4.7,
      reviews: 124,
      isOpen: false,
      gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
    ),
  ];

  double get totalPrice {
    double total = 0;
    for (var testId in selectedTests) {
      final test = tests.firstWhere((t) => t.id == testId);
      total += test.price;
    }
    return total;
  }

  void toggleTest(String testId) {
    setState(() {
      if (selectedTests.contains(testId)) {
        selectedTests.remove(testId);
      } else {
        selectedTests.add(testId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCategories(),
                      const SizedBox(height: 24),
                      _buildTestsGrid(),
                      const SizedBox(height: 24),
                      _buildLabsList(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (selectedTests.isNotEmpty) _buildBookingButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE9E9E9), Color(0xFFE9E9E9), Color(0xFF2BB9A9)],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(15, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: widget.onBack,
                  ),
                  Text(
                    tr('labsAndTests'),
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tr('bookTestsEasily'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tr('accurateFastResults'),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE9E9E9), Color(0xFF2BB9A9)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.science,
                        color: Colors.white,
                        size: 32,
                      ),
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

  Widget _buildCategories() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat['id'] as String),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2BB9A9) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                cat['name'] as String,
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

  Widget _buildTestsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          tr('availableTests'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: tests.length,
          itemBuilder: (context, index) {
            return _buildTestCard(tests[index]);
          },
        ),
      ],
    );
  }

  Widget _buildTestCard(LabTest test) {
    final isSelected = selectedTests.contains(test.id);
    return GestureDetector(
      onTap: () => toggleTest(test.id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF2BB9A9) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: test.gradientColors),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(test.icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    test.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    test.description,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            test.duration,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                      Text(
                        '${test.price.toInt()} ج',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: test.gradientColors[0],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2BB9A9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          tr('nearbyLabs'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...labs.map((lab) => _buildLabCard(lab)).toList(),
      ],
    );
  }

  Widget _buildLabCard(Lab lab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: lab.isOpen
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        lab.isOpen ? tr('openStatus') : tr('closedStatus'),
                        style: TextStyle(
                          fontSize: 10,
                          color: lab.isOpen ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      lab.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      lab.location,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '(${lab.reviews})',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${lab.rating}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, size: 14, color: Color(0xFFFF9E57)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: lab.gradientColors),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingButton() {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF2BB9A9),
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(tr('bookingConfirmed')),
                ],
              ),
              content: Text(
                '${selectedTests.length} ${tr('testsBooked')}\n${tr('totalAmount')} ${totalPrice.toInt()} ${tr('egp')}',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedTests.clear();
                    });
                  },
                  child: Text(tr('done')),
                ),
              ],
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2BB9A9).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.science, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '${selectedTests.length} ${tr('testBooked')}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    tr('bookNow'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${totalPrice.toInt()} ج',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
