import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class NurseSuppliesScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String) onNavigate;

  const NurseSuppliesScreen({
    Key? key,
    required this.onBack,
    required this.onNavigate,
  }) : super(key: key);

  @override
  State<NurseSuppliesScreen> createState() => _NurseSuppliesScreenState();
}

class _NurseSuppliesScreenState extends State<NurseSuppliesScreen> {
  String _selectedCategory = 'all';

  String tr(String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }

  List<Map<String, dynamic>> get _supplies => [
    {
      'id': '1',
      'name': tr('syringes'),
      'category': 'injection',
      'quantity': 50,
      'minStock': 20,
      'unit': tr('pieces'),
      'icon': Icons.vaccines,
    },
    {
      'id': '2',
      'name': tr('bloodTubes'),
      'category': 'sample',
      'quantity': 30,
      'minStock': 15,
      'unit': tr('pieces'),
      'icon': Icons.science,
    },
    {
      'id': '3',
      'name': tr('bandages'),
      'category': 'wound',
      'quantity': 10,
      'minStock': 25,
      'unit': tr('rolls'),
      'icon': Icons.healing,
    },
    {
      'id': '4',
      'name': tr('gloves'),
      'category': 'general',
      'quantity': 100,
      'minStock': 50,
      'unit': tr('pairs'),
      'icon': Icons.pan_tool,
    },
    {
      'id': '5',
      'name': tr('ivSets'),
      'category': 'iv',
      'quantity': 5,
      'minStock': 10,
      'unit': tr('pieces'),
      'icon': Icons.water_drop,
    },
    {
      'id': '6',
      'name': tr('alcoholSwabs'),
      'category': 'general',
      'quantity': 200,
      'minStock': 100,
      'unit': tr('pieces'),
      'icon': Icons.cleaning_services,
    },
    {
      'id': '7',
      'name': tr('cottonBalls'),
      'category': 'general',
      'quantity': 150,
      'minStock': 50,
      'unit': tr('pieces'),
      'icon': Icons.circle,
    },
    {
      'id': '8',
      'name': tr('catheters'),
      'category': 'catheter',
      'quantity': 8,
      'minStock': 5,
      'unit': tr('pieces'),
      'icon': Icons.medical_information,
    },
  ];

  List<Map<String, dynamic>> get _filteredSupplies {
    if (_selectedCategory == 'all') return _supplies;
    return _supplies.where((s) => s['category'] == _selectedCategory).toList();
  }

  List<Map<String, dynamic>> get _lowStockItems {
    return _supplies.where((s) => s['quantity'] < s['minStock']).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFDF5),
      body: Column(
        children: [
          _buildHeader(),
          _buildCategoryFilter(),
          Expanded(child: _buildSuppliesList()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showRequestSuppliesDialog,
        backgroundColor: const Color(0xFF2BB9A9),
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
        label: Text(
          tr('requestSupplies'),
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
                    tr('nurseSupplies'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    _supplies.length.toString(),
                    tr('totalItems'),
                    Icons.inventory,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    _lowStockItems.length.toString(),
                    tr('lowStock'),
                    Icons.warning,
                    isWarning: _lowStockItems.isNotEmpty,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon, {
    bool isWarning = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: isWarning ? Colors.yellow : Colors.white, size: 28),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: isWarning ? Colors.yellow : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'id': 'all', 'name': tr('all')},
      {'id': 'injection', 'name': tr('nurseInjection')},
      {'id': 'sample', 'name': tr('samples')},
      {'id': 'wound', 'name': tr('nurseWoundCare')},
      {'id': 'general', 'name': tr('general')},
    ];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category['id'];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = category['id']!),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2BB9A9) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                category['name']!,
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

  Widget _buildSuppliesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _filteredSupplies.length,
      itemBuilder: (context, index) {
        return _buildSupplyCard(_filteredSupplies[index]);
      },
    );
  }

  Widget _buildSupplyCard(Map<String, dynamic> supply) {
    final isLowStock = supply['quantity'] < supply['minStock'];
    final stockPercentage = (supply['quantity'] / supply['minStock'] * 100)
        .clamp(0, 100);

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
        border: isLowStock
            ? Border.all(color: Colors.red.withOpacity(0.3), width: 2)
            : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isLowStock
                      ? Colors.red.withOpacity(0.1)
                      : const Color(0xFF2BB9A9).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  supply['icon'] as IconData,
                  color: isLowStock ? Colors.red : const Color(0xFF2BB9A9),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supply['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${supply['quantity']} ${supply['unit']}',
                          style: TextStyle(
                            color: isLowStock ? Colors.red : Colors.grey[600],
                            fontWeight: isLowStock
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        if (isLowStock) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tr('lowStock'),
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFF2BB9A9)),
                onPressed: () => _updateQuantity(supply, 1),
              ),
              IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.grey[400]),
                onPressed: () => _updateQuantity(supply, -1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: stockPercentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                isLowStock ? Colors.red : const Color(0xFF2BB9A9),
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tr('minStock')}: ${supply['minStock']} ${supply['unit']}',
                style: TextStyle(color: Colors.grey[500], fontSize: 11),
              ),
              Text(
                '${stockPercentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: isLowStock ? Colors.red : const Color(0xFF2BB9A9),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateQuantity(Map<String, dynamic> supply, int delta) {
    setState(() {
      final index = _supplies.indexWhere((s) => s['id'] == supply['id']);
      if (index != -1) {
        final newQuantity = (_supplies[index]['quantity'] as int) + delta;
        if (newQuantity >= 0) {
          _supplies[index]['quantity'] = newQuantity;
        }
      }
    });
  }

  void _showRequestSuppliesDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('requestSupplies'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (_lowStockItems.isNotEmpty) ...[
                Text(
                  tr('lowStockItems'),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                ...(_lowStockItems.map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(item['icon'] as IconData, color: Colors.red),
                    title: Text(item['name']),
                    subtitle: Text(
                      '${tr('current')}: ${item['quantity']} ${item['unit']}',
                    ),
                    trailing: Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF2BB9A9),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tr('requestSent')),
                        backgroundColor: const Color(0xFF10B981),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2BB9A9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(tr('sendRequest')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
