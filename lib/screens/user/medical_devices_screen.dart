import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';
import 'checkout_screen.dart';

class MedicalDevice {
  final String id;
  final String name;
  final String nameEn;
  final String brand;
  final double price;
  final double? oldPrice;
  final String category;
  final double rating;
  final int reviews;
  final bool inStock;
  final String description;
  final List<String> features;
  final List<Color> gradientColors;
  final IconData icon;

  MedicalDevice({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.inStock,
    required this.description,
    required this.features,
    required this.gradientColors,
    required this.icon,
  });
}

class MedicalDevicesScreen extends StatefulWidget {
  final VoidCallback onBack;

  const MedicalDevicesScreen({Key? key, required this.onBack})
    : super(key: key);

  @override
  State<MedicalDevicesScreen> createState() => _MedicalDevicesScreenState();
}

class _MedicalDevicesScreenState extends State<MedicalDevicesScreen> {
  String selectedCategory = 'all';
  Map<String, int> cartItems = {};
  String searchQuery = '';

  List<Map<String, dynamic>> get categories => [
    {
      'id': 'all',
      'name': tr('allCategory'),
      'icon': Icons.apps,
      'color': const Color(0xFF0A6DD9),
    },
    {
      'id': 'pressure',
      'name': tr('bloodPressureCategory'),
      'icon': Icons.favorite,
      'color': const Color(0xFFFF5252),
    },
    {
      'id': 'diabetes',
      'name': tr('diabetesCategory'),
      'icon': Icons.bloodtype,
      'color': const Color(0xFF2BB9A9),
    },
    {
      'id': 'respiratory',
      'name': tr('respiratoryCategory'),
      'icon': Icons.air,
      'color': const Color(0xFF64B5F6),
    },
    {
      'id': 'mobility',
      'name': tr('mobilityCategory'),
      'icon': Icons.accessible,
      'color': const Color(0xFFFF9E57),
    },
    {
      'id': 'monitoring',
      'name': tr('monitoringCategory'),
      'icon': Icons.monitor_heart,
      'color': const Color(0xFF9C27B0),
    },
    {
      'id': 'therapy',
      'name': tr('therapyCategory'),
      'icon': Icons.spa,
      'color': const Color(0xFF4CAF50),
    },
    {
      'id': 'first_aid',
      'name': tr('firstAidCategory'),
      'icon': Icons.medical_services,
      'color': const Color(0xFFE91E63),
    },
  ];

  List<MedicalDevice> get devices => [
    // Blood pressure devices
    MedicalDevice(
      id: '1',
      name: tr('deviceBloodPressureDigital'),
      nameEn: 'Omron M3 Blood Pressure Monitor',
      brand: tr('brandOmron'),
      price: 1250,
      oldPrice: 1500,
      category: 'pressure',
      rating: 4.8,
      reviews: 342,
      inStock: true,
      description: tr('deviceBloodPressureDigitalDesc'),
      features: [
        tr('featureLCDScreen'),
        tr('featureMemory60'),
        tr('featureHeartbeatDetection'),
        tr('featureHighPressureIndicator'),
      ],
      gradientColors: [const Color(0xFFFF5252), const Color(0xFFFF8A80)],
      icon: Icons.favorite,
    ),
    MedicalDevice(
      id: '2',
      name: tr('deviceBloodPressureArm'),
      nameEn: 'Beurer BM 40 Upper Arm Monitor',
      brand: tr('brandBeurer'),
      price: 950,
      category: 'pressure',
      rating: 4.6,
      reviews: 189,
      inStock: true,
      description: tr('deviceBloodPressureArmDesc'),
      features: [
        tr('featureXLScreen'),
        tr('featureMemory2x60'),
        tr('featureRiskIndicator'),
        tr('featureIrregularityDetection'),
      ],
      gradientColors: [const Color(0xFFE91E63), const Color(0xFFF48FB1)],
      icon: Icons.favorite_border,
    ),

    // Diabetes devices
    MedicalDevice(
      id: '3',
      name: tr('deviceGlucometer'),
      nameEn: 'Accu-Chek Active Glucometer',
      brand: tr('brandAccuChek'),
      price: 450,
      oldPrice: 550,
      category: 'diabetes',
      rating: 4.9,
      reviews: 567,
      inStock: true,
      description: tr('deviceGlucometerDesc'),
      features: [
        tr('featureResult5Sec'),
        tr('featureMemory500'),
        tr('featureSmallSample'),
        tr('featureAverage7_14_30'),
      ],
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF80CBC4)],
      icon: Icons.bloodtype,
    ),
    MedicalDevice(
      id: '4',
      name: tr('deviceTestStrips'),
      nameEn: 'Accu-Chek Active Test Strips',
      brand: tr('brandAccuChek'),
      price: 320,
      category: 'diabetes',
      rating: 4.7,
      reviews: 892,
      inStock: true,
      description: tr('deviceTestStripsDesc'),
      features: [
        tr('feature50Strips'),
        tr('featureLongExpiry'),
        tr('featureEasyUse'),
        tr('featureAccurateResults'),
      ],
      gradientColors: [const Color(0xFF26A69A), const Color(0xFF80CBC4)],
      icon: Icons.science,
    ),
    MedicalDevice(
      id: '5',
      name: tr('deviceCGM'),
      nameEn: 'FreeStyle Libre Sensor',
      brand: tr('brandFreeStyle'),
      price: 1800,
      category: 'diabetes',
      rating: 4.8,
      reviews: 234,
      inStock: true,
      description: tr('deviceCGMDesc'),
      features: [
        tr('featureNoPrick'),
        tr('featureContinuousMonitoring'),
        tr('featureLasts14Days'),
        tr('featurePhoneApp'),
      ],
      gradientColors: [const Color(0xFF00897B), const Color(0xFF4DB6AC)],
      icon: Icons.sensors,
    ),

    // Respiratory devices
    MedicalDevice(
      id: '6',
      name: tr('devicePulseOximeter'),
      nameEn: 'Fingertip Pulse Oximeter',
      brand: tr('brandBeurer'),
      price: 350,
      oldPrice: 450,
      category: 'respiratory',
      rating: 4.7,
      reviews: 445,
      inStock: true,
      description: tr('devicePulseOximeterDesc'),
      features: [
        tr('featureSpO2'),
        tr('featurePulseRate'),
        tr('featureOLEDScreen'),
        tr('featureLongBattery'),
      ],
      gradientColors: [const Color(0xFF64B5F6), const Color(0xFF90CAF9)],
      icon: Icons.air,
    ),
    MedicalDevice(
      id: '7',
      name: tr('deviceNebulizer'),
      nameEn: 'Omron CompAir Nebulizer',
      brand: tr('brandOmron'),
      price: 850,
      category: 'respiratory',
      rating: 4.6,
      reviews: 278,
      inStock: true,
      description: tr('deviceNebulizerDesc'),
      features: [
        tr('featureVeryQuiet'),
        tr('featureEasyClean'),
        tr('featureSuitableAllAges'),
        tr('featureIncludesAccessories'),
      ],
      gradientColors: [const Color(0xFF42A5F5), const Color(0xFF64B5F6)],
      icon: Icons.cloud,
    ),
    MedicalDevice(
      id: '8',
      name: tr('deviceOxygenConcentrator'),
      nameEn: 'Oxygen Concentrator 5L',
      brand: tr('brandYuwell'),
      price: 12500,
      oldPrice: 15000,
      category: 'respiratory',
      rating: 4.9,
      reviews: 156,
      inStock: true,
      description: tr('deviceOxygenConcentratorDesc'),
      features: [
        tr('feature5LPerMin'),
        tr('featurePurity93'),
        tr('featureQuiet45db'),
        tr('featureLEDScreen'),
      ],
      gradientColors: [const Color(0xFF1E88E5), const Color(0xFF42A5F5)],
      icon: Icons.local_hospital,
    ),

    // Mobility devices
    MedicalDevice(
      id: '9',
      name: tr('deviceWheelchair'),
      nameEn: 'Foldable Wheelchair',
      brand: tr('brandArmstrong'),
      price: 3500,
      oldPrice: 4200,
      category: 'mobility',
      rating: 4.5,
      reviews: 167,
      inStock: true,
      description: tr('deviceWheelchairDesc'),
      features: [
        tr('featureFoldable'),
        tr('featureLightweight15kg'),
        tr('featureRubberTires'),
        tr('featureComfortableSeat'),
      ],
      gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFFB74D)],
      icon: Icons.accessible,
    ),
    MedicalDevice(
      id: '10',
      name: tr('deviceWalkingCane'),
      nameEn: 'Adjustable Walking Cane',
      brand: tr('brandMedical'),
      price: 180,
      category: 'mobility',
      rating: 4.4,
      reviews: 234,
      inStock: true,
      description: tr('deviceWalkingCaneDesc'),
      features: [
        tr('featureAdjustableHeight'),
        tr('featureLightAluminum'),
        tr('featureComfortableGrip'),
        tr('featureRubberBase'),
      ],
      gradientColors: [const Color(0xFFFFA726), const Color(0xFFFFB74D)],
      icon: Icons.elderly,
    ),
    MedicalDevice(
      id: '11',
      name: tr('deviceRollator'),
      nameEn: 'Rollator Walker',
      brand: tr('brandDrive'),
      price: 2200,
      category: 'mobility',
      rating: 4.6,
      reviews: 89,
      inStock: true,
      description: tr('deviceRollatorDesc'),
      features: [
        tr('feature4Wheels'),
        tr('featureBuiltInSeat'),
        tr('featureHandBrakes'),
        tr('featureStorageBasket'),
      ],
      gradientColors: [const Color(0xFFFF7043), const Color(0xFFFF8A65)],
      icon: Icons.directions_walk,
    ),

    // Monitoring devices
    MedicalDevice(
      id: '12',
      name: tr('deviceThermometer'),
      nameEn: 'Infrared Forehead Thermometer',
      brand: tr('brandBraun'),
      price: 650,
      oldPrice: 800,
      category: 'monitoring',
      rating: 4.8,
      reviews: 678,
      inStock: true,
      description: tr('deviceThermometerDesc'),
      features: [
        tr('featureMeasure1Sec'),
        tr('featureNoTouch'),
        tr('featureMemory32'),
        tr('featureSuitableChildren'),
      ],
      gradientColors: [const Color(0xFF9C27B0), const Color(0xFFBA68C8)],
      icon: Icons.thermostat,
    ),
    MedicalDevice(
      id: '13',
      name: tr('deviceFetalDoppler'),
      nameEn: 'Fetal Doppler Monitor',
      brand: tr('brandAngelSounds'),
      price: 750,
      category: 'monitoring',
      rating: 4.5,
      reviews: 234,
      inStock: true,
      description: tr('deviceFetalDopplerDesc'),
      features: [
        tr('featureEasyUse'),
        tr('featureIncludesHeadphones'),
        tr('featureLCDScreen2'),
        tr('featureSafePregnant'),
      ],
      gradientColors: [const Color(0xFF7B1FA2), const Color(0xFF9C27B0)],
      icon: Icons.pregnant_woman,
    ),
    MedicalDevice(
      id: '14',
      name: tr('deviceSmartWatch'),
      nameEn: 'Health Monitoring Smart Watch',
      brand: tr('brandHuawei'),
      price: 2800,
      oldPrice: 3200,
      category: 'monitoring',
      rating: 4.7,
      reviews: 456,
      inStock: true,
      description: tr('deviceSmartWatchDesc'),
      features: [
        tr('featureHeartMonitor24_7'),
        tr('featureSpO2Measure'),
        tr('featureSleepTracking'),
        tr('featureWaterResistant'),
      ],
      gradientColors: [const Color(0xFF8E24AA), const Color(0xFFAB47BC)],
      icon: Icons.watch,
    ),

    // Therapy devices
    MedicalDevice(
      id: '15',
      name: tr('deviceTENS'),
      nameEn: 'TENS/EMS Unit',
      brand: tr('brandOmron'),
      price: 1100,
      category: 'therapy',
      rating: 4.6,
      reviews: 189,
      inStock: true,
      description: tr('deviceTENSDesc'),
      features: [
        tr('feature15Programs'),
        tr('featureAdjustableIntensity'),
        tr('feature4Pads'),
        tr('featureUSBCharging'),
      ],
      gradientColors: [const Color(0xFF4CAF50), const Color(0xFF81C784)],
      icon: Icons.electric_bolt,
    ),
    MedicalDevice(
      id: '16',
      name: tr('deviceHeatingPad'),
      nameEn: 'Electric Heating Pad',
      brand: tr('brandBeurer'),
      price: 450,
      category: 'therapy',
      rating: 4.5,
      reviews: 267,
      inStock: true,
      description: tr('deviceHeatingPadDesc'),
      features: [
        tr('feature3HeatLevels'),
        tr('featureAutoShutoff'),
        tr('featureWashableCover'),
        tr('featureSoftComfortable'),
      ],
      gradientColors: [const Color(0xFF66BB6A), const Color(0xFF81C784)],
      icon: Icons.whatshot,
    ),
    MedicalDevice(
      id: '17',
      name: tr('deviceFootMassager'),
      nameEn: 'Electric Foot Massager',
      brand: tr('brandRiester'),
      price: 1800,
      oldPrice: 2200,
      category: 'therapy',
      rating: 4.7,
      reviews: 178,
      inStock: true,
      description: tr('deviceFootMassagerDesc'),
      features: [
        tr('featureShiatsuMassage'),
        tr('featureHeating'),
        tr('feature3Levels'),
        tr('featureRemoteControl'),
      ],
      gradientColors: [const Color(0xFF43A047), const Color(0xFF66BB6A)],
      icon: Icons.spa,
    ),

    // First aid devices
    MedicalDevice(
      id: '18',
      name: tr('deviceFirstAidKit'),
      nameEn: 'Complete First Aid Kit',
      brand: tr('brandJohnson'),
      price: 350,
      category: 'first_aid',
      rating: 4.8,
      reviews: 567,
      inStock: true,
      description: tr('deviceFirstAidKitDesc'),
      features: [
        tr('feature100Pieces'),
        tr('featureOrganizedBag'),
        tr('featureUserGuide'),
        tr('featureTravelSuitable'),
      ],
      gradientColors: [const Color(0xFFE91E63), const Color(0xFFF06292)],
      icon: Icons.medical_services,
    ),
    MedicalDevice(
      id: '19',
      name: tr('deviceVenomExtractor'),
      nameEn: 'Venom Extractor Kit',
      brand: tr('brandSawyer'),
      price: 280,
      category: 'first_aid',
      rating: 4.4,
      reviews: 89,
      inStock: true,
      description: tr('deviceVenomExtractorDesc'),
      features: [
        tr('featureEasyUse'),
        tr('feature4CupSizes'),
        tr('featureReusable'),
        tr('featureCarryCase'),
      ],
      gradientColors: [const Color(0xFFD81B60), const Color(0xFFE91E63)],
      icon: Icons.bug_report,
    ),
    MedicalDevice(
      id: '20',
      name: tr('deviceAED'),
      nameEn: 'Automated External Defibrillator',
      brand: tr('brandPhilips'),
      price: 25000,
      category: 'first_aid',
      rating: 4.9,
      reviews: 45,
      inStock: false,
      description: tr('deviceAEDDesc'),
      features: [
        tr('featureVoiceGuidance'),
        tr('featureAutoAnalysis'),
        tr('featureAdultsChildren'),
        tr('featureLongBattery2'),
      ],
      gradientColors: [const Color(0xFFC2185B), const Color(0xFFD81B60)],
      icon: Icons.monitor_heart,
    ),
  ];

  List<MedicalDevice> get filteredDevices {
    List<MedicalDevice> result = devices;

    if (selectedCategory != 'all') {
      result = result.where((d) => d.category == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      result = result
          .where(
            (d) =>
                d.name.contains(searchQuery) ||
                d.nameEn.toLowerCase().contains(searchQuery.toLowerCase()) ||
                d.brand.contains(searchQuery) ||
                d.description.contains(searchQuery),
          )
          .toList();
    }

    return result;
  }

  int get totalItems => cartItems.values.fold(0, (sum, count) => sum + count);

  double get totalPrice {
    double total = 0;
    cartItems.forEach((id, count) {
      final device = devices.firstWhere((d) => d.id == id);
      total += device.price * count;
    });
    return total;
  }

  void addToCart(String deviceId) {
    setState(() {
      cartItems[deviceId] = (cartItems[deviceId] ?? 0) + 1;
    });
    _showSuccessSnackBar(tr('addedToCart'));
  }

  void removeFromCart(String deviceId) {
    setState(() {
      if (cartItems[deviceId] != null && cartItems[deviceId]! > 1) {
        cartItems[deviceId] = cartItems[deviceId]! - 1;
      } else {
        cartItems.remove(deviceId);
      }
    });
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: const Color(0xFF2BB9A9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToCheckout() {
    final List<CartItem> checkoutItems = [];
    cartItems.forEach((id, count) {
      final device = devices.firstWhere((d) => d.id == id);
      checkoutItems.add(
        CartItem(
          id: device.id,
          name: device.name,
          price: device.price,
          quantity: count,
          icon: device.icon,
          gradientColors: device.gradientColors,
        ),
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartItems: checkoutItems,
          onBack: () => Navigator.pop(context),
          onOrderComplete: () {
            setState(() {
              cartItems.clear();
            });
          },
        ),
      ),
    );
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
              Expanded(child: _buildContent()),
            ],
          ),
          if (totalItems > 0) _buildCartButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9), Color(0xFF2BB9A9)],
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
              // Decorative dots
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

              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: widget.onBack,
                  ),
                  Text(
                    tr('medicalDevicesTitle'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () => _showCartSheet(),
                      ),
                      if (totalItems > 0)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF9E57),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$totalItems',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: tr('searchMedicalDevice'),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildCategories(),
          const SizedBox(height: 16),
          _buildDevicesGrid(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat['id']),
            child: Container(
              width: 85,
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? null : Colors.white,
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          cat['color'],
                          (cat['color'] as Color).withOpacity(0.7),
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? (cat['color'] as Color).withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : (cat['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: isSelected ? Colors.white : cat['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDevicesGrid() {
    if (filteredDevices.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                tr('noResults'),
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2BB9A9).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${filteredDevices.length} ${tr('deviceCount')}',
                  style: const TextStyle(
                    color: Color(0xFF2BB9A9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                tr('availableDevices'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.58,
            ),
            itemCount: filteredDevices.length,
            itemBuilder: (context, index) {
              return _buildDeviceCard(filteredDevices[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(MedicalDevice device) {
    final cartCount = cartItems[device.id] ?? 0;

    return GestureDetector(
      onTap: () => _showDeviceDetails(device),
      child: Container(
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
            // Device image/icon
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: device.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      device.icon,
                      size: 48,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  // Stock badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: device.inStock ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        device.inStock ? tr('inStockLabel') : tr('soldOut'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Discount badge
                  if (device.oldPrice != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9E57),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '-${((1 - device.price / device.oldPrice!) * 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Device info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      device.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      device.brand,
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '(${device.reviews})',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${device.rating}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Color(0xFFFF9E57),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Add to cart button
                        if (device.inStock)
                          cartCount > 0
                              ? Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: device.gradientColors,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => removeFromCart(device.id),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            size: 16,
                                            color: device.gradientColors[0],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          '$cartCount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => addToCart(device.id),
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 16,
                                            color: device.gradientColors[0],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => addToCart(device.id),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: device.gradientColors,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: device.gradientColors[0]
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tr('notAvailable'),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        // Price column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (device.oldPrice != null)
                              Text(
                                '${device.oldPrice!.toInt()} ج.م',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[400],
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Text(
                              '${device.price.toInt()} ج.م',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: device.gradientColors[0],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeviceDetails(MedicalDevice device) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Device image header
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: device.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              device.icon,
                              size: 100,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          if (device.oldPrice != null)
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF9E57),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${tr('discountLabel')} ${((1 - device.price / device.oldPrice!) * 100).round()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Brand & Stock
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: device.inStock
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      device.inStock
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      size: 16,
                                      color: device.inStock
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      device.inStock
                                          ? tr('inStockStatus')
                                          : tr('notAvailableNow'),
                                      style: TextStyle(
                                        color: device.inStock
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 12,
                                      ),
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
                                  color: device.gradientColors[0].withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  device.brand,
                                  style: TextStyle(
                                    color: device.gradientColors[0],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Name
                          Text(
                            device.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            device.nameEn,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 12),

                          // Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '(${device.reviews} ${tr('reviewCount')})',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${device.rating}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              ...List.generate(
                                5,
                                (index) => Icon(
                                  index < device.rating.floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 20,
                                  color: const Color(0xFFFF9E57),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Price
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: device.gradientColors[0].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (device.oldPrice != null)
                                  Text(
                                    '${device.oldPrice!.toInt()} ج.م',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[400],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                const Spacer(),
                                Text(
                                  '${device.price.toInt()} ج.م',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: device.gradientColors[0],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Description
                          Text(
                            tr('productDescription'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            device.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 20),

                          // Features
                          Text(
                            tr('featuresLabel'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...device.features
                              .map(
                                (feature) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        feature,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: device.gradientColors[0]
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          size: 16,
                                          color: device.gradientColors[0],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom action bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: device.inStock
                          ? () {
                              addToCart(device.id);
                              Navigator.pop(context);
                            }
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: device.inStock
                              ? LinearGradient(colors: device.gradientColors)
                              : null,
                          color: device.inStock ? null : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              device.inStock
                                  ? tr('addToCartBtn')
                                  : tr('notAvailable'),
                              style: TextStyle(
                                color: device.inStock
                                    ? Colors.white
                                    : Colors.grey[600],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.shopping_cart,
                              color: device.inStock
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () =>
                          _showSuccessSnackBar(tr('addedToFavorites')),
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

  void _showCartSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      '${tr('shoppingCartTitle')} ($totalItems)',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              tr('cartEmpty'),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final deviceId = cartItems.keys.elementAt(index);
                          final device = devices.firstWhere(
                            (d) => d.id == deviceId,
                          );
                          final count = cartItems[deviceId]!;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                // Quantity controls
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() => addToCart(device.id));
                                        setSheetState(() {});
                                      },
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: device.gradientColors[0],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        '$count',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(
                                          () => removeFromCart(device.id),
                                        );
                                        setSheetState(() {});
                                      },
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Icon(
                                          count > 1
                                              ? Icons.remove
                                              : Icons.delete,
                                          color: count > 1
                                              ? Colors.grey[700]
                                              : Colors.red,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        device.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        device.brand,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${(device.price * count).toInt()} ج.م',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: device.gradientColors[0],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: device.gradientColors,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    device.icon,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              if (cartItems.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${totalPrice.toInt()} ${tr('egpCurrency')}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2BB9A9),
                            ),
                          ),
                          Text(
                            tr('totalLabel'),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _navigateToCheckout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2BB9A9),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            tr('checkoutBtn'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
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

  Widget _buildCartButton() {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24,
      child: GestureDetector(
        onTap: () => _showCartSheet(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0A6DD9).withOpacity(0.4),
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
                  const Icon(Icons.shopping_cart, color: Colors.white),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$totalItems',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    tr('viewCartBtn'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${totalPrice.toInt()} ${tr('egpCurrency')}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
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





