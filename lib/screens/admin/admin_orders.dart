import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class AdminOrders extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onViewDetails;

  const AdminOrders({
    super.key,
    required this.onBack,
    required this.onViewDetails,
  });

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  String selectedFilter = 'all';

  List<Map<String, dynamic>> get orders {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': '#1234',
        'customer': isArabic ? 'أحمد علي' : 'Ahmed Ali',
        'phone': '01012345678',
        'total': 450,
        'items': [
          {
            'name': isArabic ? 'باراسيتامول 500mg' : 'Paracetamol 500mg',
            'qty': 2,
            'price': 150,
          },
          {
            'name': isArabic ? 'فيتامين C' : 'Vitamin C',
            'qty': 1,
            'price': 300,
          },
        ],
        'status': 'pending',
        'date': '2024-01-15 10:30',
        'address': isArabic
            ? 'أسوان - شارع النيل - عمارة 5'
            : 'Aswan - Nile St. - Building 5',
        'paymentMethod': isArabic ? 'الدفع عند الاستلام' : 'Cash on Delivery',
        'notes': isArabic
            ? 'يرجى الاتصال قبل الوصول'
            : 'Please call before arrival',
      },
      {
        'id': '#1235',
        'customer': isArabic ? 'فاطمة حسن' : 'Fatma Hassan',
        'phone': '01123456789',
        'total': 280,
        'items': [
          {
            'name': isArabic ? 'أموكسيسيلين' : 'Amoxicillin',
            'qty': 1,
            'price': 180,
          },
          {
            'name': isArabic ? 'شراب كحة' : 'Cough Syrup',
            'qty': 1,
            'price': 100,
          },
        ],
        'status': 'processing',
        'date': '2024-01-15 09:45',
        'address': isArabic
            ? 'قنا - المدينة - شارع الجمهورية'
            : 'Qena - Downtown - Republic St.',
        'paymentMethod': isArabic ? 'فودافون كاش' : 'Vodafone Cash',
        'notes': '',
      },
      {
        'id': '#1236',
        'customer': isArabic ? 'محمد سعيد' : 'Mohamed Said',
        'phone': '01234567890',
        'total': 750,
        'items': [
          {'name': isArabic ? 'انسولين' : 'Insulin', 'qty': 2, 'price': 500},
          {
            'name': isArabic ? 'شرائط قياس السكر' : 'Blood Sugar Test Strips',
            'qty': 1,
            'price': 250,
          },
        ],
        'status': 'shipped',
        'date': '2024-01-14 16:20',
        'address': isArabic
            ? 'سوهاج - شارع الجمهورية - بجوار المستشفى'
            : 'Sohag - Republic St. - Near Hospital',
        'paymentMethod': isArabic ? 'بطاقة ائتمان' : 'Credit Card',
        'notes': isArabic
            ? 'مريض سكري - يرجى التعامل بحذر'
            : 'Diabetic patient - Handle with care',
      },
      {
        'id': '#1237',
        'customer': isArabic ? 'سارة أحمد' : 'Sara Ahmed',
        'phone': '01098765432',
        'total': 120,
        'items': [
          {
            'name': isArabic ? 'كريم مرطب' : 'Moisturizing Cream',
            'qty': 1,
            'price': 120,
          },
        ],
        'status': 'delivered',
        'date': '2024-01-14 11:00',
        'address': isArabic
            ? 'الأقصر - الكرنك - شارع المعبد'
            : 'Luxor - Karnak - Temple St.',
        'paymentMethod': isArabic ? 'الدفع عند الاستلام' : 'Cash on Delivery',
        'notes': '',
      },
      {
        'id': '#1238',
        'customer': isArabic ? 'خالد محمود' : 'Khaled Mahmoud',
        'phone': '01112223344',
        'total': 890,
        'items': [
          {
            'name': isArabic ? 'جهاز قياس ضغط' : 'Blood Pressure Monitor',
            'qty': 1,
            'price': 650,
          },
          {
            'name': isArabic ? 'حبوب ضغط' : 'Blood Pressure Pills',
            'qty': 2,
            'price': 240,
          },
        ],
        'status': 'cancelled',
        'date': '2024-01-13 14:30',
        'address': isArabic
            ? 'أسوان - إدفو - شارع النيل'
            : 'Aswan - Edfu - Nile St.',
        'paymentMethod': isArabic ? 'فودافون كاش' : 'Vodafone Cash',
        'notes': isArabic
            ? 'تم الإلغاء بسبب عدم توفر المنتج'
            : 'Cancelled due to product unavailability',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = selectedFilter == 'all'
        ? orders
        : orders.where((o) => o['status'] == selectedFilter).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF7ED), Color(0xFFFEF3C7), Color(0xFFFEF9C3)],
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
                      _buildFilters(),
                      const SizedBox(height: 20),
                      _buildOrdersList(filteredOrders),
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
          colors: [Color(0xFFF97316), Color(0xFFFB923C)],
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
                  AppLocalizations.of(context)?.translate('orderManagement') ??
                      'Order Management',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate('trackManageOrders') ??
                      'Track and manage customer orders',
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

  Widget _buildStats() {
    final loc = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            loc?.translate('newOrders') ?? 'New',
            '12',
            const Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('inProcessing') ?? 'Processing',
            '8',
            const Color(0xFF3B82F6),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('deliveredOrders') ?? 'Delivered',
            '156',
            const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final loc = AppLocalizations.of(context);
    final filters = [
      {'key': 'all', 'label': loc?.translate('allOrders') ?? 'All'},
      {'key': 'pending', 'label': loc?.translate('newOrders') ?? 'New'},
      {
        'key': 'processing',
        'label': loc?.translate('inProcessing') ?? 'Processing',
      },
      {'key': 'shipped', 'label': loc?.translate('shippedStatus') ?? 'Shipped'},
      {
        'key': 'delivered',
        'label': loc?.translate('deliveredOrders') ?? 'Delivered',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter['key'];
          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filter['key']!),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFFF97316), Color(0xFFFB923C)],
                      )
                    : null,
                color: isSelected ? null : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFF97316).withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: Text(
                filter['label']!,
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

  Widget _buildOrdersList(List<Map<String, dynamic>> ordersList) {
    return Column(
      children: ordersList.map((order) => _buildOrderCard(order)).toList(),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final status = order['status'] as String;
    final items = order['items'] as List;
    final loc = AppLocalizations.of(context);

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'pending':
        statusColor = const Color(0xFFF97316);
        statusText = loc?.translate('newStatus') ?? 'New';
        statusIcon = Icons.schedule;
        break;
      case 'processing':
        statusColor = const Color(0xFF3B82F6);
        statusText = loc?.translate('processingStatus') ?? 'Processing';
        statusIcon = Icons.autorenew;
        break;
      case 'shipped':
        statusColor = const Color(0xFF8B5CF6);
        statusText = loc?.translate('shippedStatus') ?? 'Shipped';
        statusIcon = Icons.local_shipping;
        break;
      case 'delivered':
        statusColor = const Color(0xFF10B981);
        statusText = loc?.translate('deliveredStatusAdmin') ?? 'Delivered';
        statusIcon = Icons.check_circle;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusText = loc?.translate('cancelledStatusAdmin') ?? 'Cancelled';
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusText = loc?.translate('unknownStatus') ?? 'Unknown';
        statusIcon = Icons.help;
    }

    return GestureDetector(
      onTap: () => widget.onViewDetails(order),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(statusIcon, color: statusColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['id'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          order['customer'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 150,
                        child: Text(
                          order['address'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    order['date'],
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${items.length} ${loc?.translate('productsCountAdmin') ?? 'products'}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  '${order['total']} ج.م',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF97316),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => widget.onViewDetails(order),
                    icon: const Icon(Icons.visibility, size: 18),
                    label: Text(
                      loc?.translate('viewDetailsBtn') ?? 'View Details',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: statusColor,
                      side: BorderSide(color: statusColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                if (status == 'pending' || status == 'processing') ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _updateOrderStatus(order, status),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: statusColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        status == 'pending'
                            ? (loc?.translate('acceptOrder') ?? 'Accept')
                            : (loc?.translate('shipOrder') ?? 'Ship'),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateOrderStatus(Map<String, dynamic> order, String currentStatus) {
    final loc = AppLocalizations.of(context);
    String newStatus;
    String message;

    if (currentStatus == 'pending') {
      newStatus = 'processing';
      message = loc?.translate('orderAccepted') ?? 'Order accepted';
    } else {
      newStatus = 'shipped';
      message = loc?.translate('orderShipped') ?? 'Order shipped';
    }

    setState(() {
      final index = orders.indexWhere((o) => o['id'] == order['id']);
      if (index != -1) {
        orders[index]['status'] = newStatus;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
