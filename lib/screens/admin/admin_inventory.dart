import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class AdminInventory extends StatelessWidget {
  final VoidCallback onBack;

  const AdminInventory({super.key, required this.onBack});

  List<Map<String, dynamic>> get products {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'name': isArabic ? 'باراسيتامول 500مج' : 'Paracetamol 500mg',
        'stock': 450,
        'minStock': 200,
        'status': 'good',
        'price': 15,
        'category': isArabic ? 'مسكنات' : 'Painkillers',
      },
      {
        'id': 2,
        'name': isArabic ? 'أموكسيسيلين 500مج' : 'Amoxicillin 500mg',
        'stock': 80,
        'minStock': 100,
        'status': 'low',
        'price': 45,
        'category': isArabic ? 'مضادات حيوية' : 'Antibiotics',
      },
      {
        'id': 3,
        'name': isArabic ? 'أوميبرازول 20مج' : 'Omeprazole 20mg',
        'stock': 25,
        'minStock': 150,
        'status': 'critical',
        'price': 35,
        'category': isArabic ? 'جهاز هضمي' : 'Digestive',
      },
      {
        'id': 4,
        'name': isArabic ? 'ميتفورمين 500مج' : 'Metformin 500mg',
        'stock': 320,
        'minStock': 200,
        'status': 'good',
        'price': 28,
        'category': isArabic ? 'سكري' : 'Diabetes',
      },
      {
        'id': 5,
        'name': isArabic ? 'كونكور 5مج' : 'Concor 5mg',
        'stock': 95,
        'minStock': 100,
        'status': 'low',
        'price': 120,
        'category': isArabic ? 'قلب وضغط' : 'Heart & Blood Pressure',
      },
      {
        'id': 6,
        'name': isArabic ? 'فيتامين سي 1000مج' : 'Vitamin C 1000mg',
        'stock': 500,
        'minStock': 150,
        'status': 'good',
        'price': 25,
        'category': isArabic ? 'فيتامينات' : 'Vitamins',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final lowStockCount = products
        .where((p) => p['status'] == 'low' || p['status'] == 'critical')
        .length;
    final totalProducts = products.length;
    final totalValue = products.fold<int>(
      0,
      (sum, p) => sum + ((p['stock'] as int) * (p['price'] as int)),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFECFDF5), Color(0xFFF0FDFA), Color(0xFFECFEFF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildStats(
                        context,
                        totalProducts,
                        lowStockCount,
                        totalValue,
                      ),
                      const SizedBox(height: 20),
                      if (lowStockCount > 0)
                        _buildLowStockAlert(context, lowStockCount),
                      if (lowStockCount > 0) const SizedBox(height: 20),
                      _buildAddButton(context),
                      const SizedBox(height: 20),
                      _buildProductsList(context, products),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF14B8A6)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
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
                      )?.translate('inventoryManagement') ??
                      'Inventory Management',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)?.translate('manageInventory') ??
                      'Manage products and stock',
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

  Widget _buildStats(BuildContext context, int total, int lowStock, int value) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            Icons.inventory,
            AppLocalizations.of(context)?.translate('allProducts') ??
                'Products',
            total.toString(),
            const Color(0xFF06B6D4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            Icons.warning,
            AppLocalizations.of(context)?.translate('lowStockProducts') ??
                'Low Stock',
            lowStock.toString(),
            const Color(0xFFF97316),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
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
                  fontSize: 20,
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

  Widget _buildLowStockAlert(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF97316).withOpacity(0.1),
            const Color(0xFFFB923C).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF97316).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber, color: Color(0xFFF97316), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.translate('lowStock') ??
                      'Warning: Low Stock',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF97316),
                  ),
                ),
                Text(
                  '$count ${AppLocalizations.of(context)?.translate('productsNeedRestock') ?? 'products need restock'}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: Text(
          AppLocalizations.of(context)?.translate('addProduct') ??
              'Add New Product',
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList(
    BuildContext context,
    List<Map<String, dynamic>> products,
  ) {
    return Column(
      children: products
          .map((product) => _buildProductCard(context, product))
          .toList(),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product) {
    final status = product['status'] as String;
    final stock = product['stock'] as int;
    final minStock = product['minStock'] as int;
    final progress = (stock / minStock).clamp(0.0, 1.0);

    Color statusColor;
    String statusText;
    if (status == 'good') {
      statusColor = Colors.green;
      statusText =
          AppLocalizations.of(context)?.translate('inStockProducts') ??
          'In Stock';
    } else if (status == 'low') {
      statusColor = Colors.amber;
      statusText =
          AppLocalizations.of(context)?.translate('lowStockProducts') ??
          'Low Stock';
    } else {
      statusColor = Colors.red;
      statusText =
          AppLocalizations.of(context)?.translate('outOfStockProducts') ??
          'Critical';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['category'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)?.translate('stockQuantity') ?? 'Stock'}: $stock',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${AppLocalizations.of(context)?.translate('productPrice') ?? 'Price'}: ${product['price']} ج. م',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)?.translate('stockQuantity') ??
                        'Current Stock',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                  Text(
                    '${AppLocalizations.of(context)?.translate('lowStockThreshold') ?? 'Min'}: $minStock',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  minHeight: 6,
                ),
              ),
            ],
          ),
          if (status == 'low' || status == 'critical') ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF97316),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(
                        context,
                      )?.translate('productsNeedRestock') ??
                      'Request Restock',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
