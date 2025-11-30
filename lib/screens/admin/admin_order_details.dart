import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AdminOrderDetails extends StatelessWidget {
  final VoidCallback onBack;
  final Map<String, dynamic> orderData;

  const AdminOrderDetails({
    super.key,
    required this.onBack,
    required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (orderData.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              Text(loc?.translate('noData') ?? 'No order data'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onBack,
                child: Text(loc?.translate('back') ?? 'Back'),
              ),
            ],
          ),
        ),
      );
    }

    final status = orderData['status'] as String;
    final items = orderData['items'] as List;

    Color statusColor;
    String statusText;

    switch (status) {
      case 'pending':
        statusColor = const Color(0xFFF97316);
        statusText = loc?.translate('newStatus') ?? 'New';
        break;
      case 'processing':
        statusColor = const Color(0xFF3B82F6);
        statusText = loc?.translate('processingStatus') ?? 'Processing';
        break;
      case 'shipped':
        statusColor = const Color(0xFF8B5CF6);
        statusText = loc?.translate('shippedStatus') ?? 'Shipped';
        break;
      case 'delivered':
        statusColor = const Color(0xFF10B981);
        statusText = loc?.translate('deliveredStatusAdmin') ?? 'Delivered';
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusText = loc?.translate('cancelledStatusAdmin') ?? 'Cancelled';
        break;
      default:
        statusColor = Colors.grey;
        statusText = loc?.translate('unknownStatus') ?? 'Unknown';
    }

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
              _buildHeader(context, statusColor, statusText),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildOrderInfo(context, statusColor),
                      const SizedBox(height: 20),
                      _buildCustomerInfo(context),
                      const SizedBox(height: 20),
                      _buildAddressInfo(context),
                      const SizedBox(height: 20),
                      _buildItemsList(context, items),
                      const SizedBox(height: 20),
                      _buildPaymentInfo(context),
                      const SizedBox(height: 20),
                      if (orderData['notes'] != null &&
                          orderData['notes'].toString().isNotEmpty)
                        _buildNotesSection(context),
                      const SizedBox(height: 20),
                      _buildActionButtons(status, statusColor, context),
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

  Widget _buildHeader(
    BuildContext context,
    Color statusColor,
    String statusText,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor, statusColor.withOpacity(0.8)],
        ),
        borderRadius: const BorderRadius.only(
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
                  '${AppLocalizations.of(context)?.translate('orderDetails') ?? 'Order Details'} ${orderData['id']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  statusText,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
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
            child: const Icon(Icons.print, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              Text(
                AppLocalizations.of(context)?.translate('orderNumberLabel') ??
                    'Order Number',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                orderData['id'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('orderDate') ??
                    'Order Date',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                orderData['date'],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('orderTotal') ??
                    'Order Total',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                '${orderData['total']} ج.م',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, color: Color(0xFF3B82F6)),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)?.translate('customerInfo') ??
                    'Customer Information',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.person_outline,
            AppLocalizations.of(context)?.translate('customerName') ?? 'Name',
            orderData['customer'],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.phone,
            AppLocalizations.of(context)?.translate('customerPhone') ?? 'Phone',
            orderData['phone'],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.location_on, color: Color(0xFF10B981)),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate('deliveryAddressLabel') ??
                    'Delivery Address',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    orderData['address'],
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context, List items) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.shopping_bag, color: Color(0xFFF97316)),
              ),
              const SizedBox(width: 12),
              Text(
                '${AppLocalizations.of(context)?.translate('orderProducts') ?? 'Products'} (${items.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map((item) => _buildItemRow(item)).toList(),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('subtotalLabel') ??
                    'Subtotal',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                '${orderData['total']} ج. م',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('deliveryFeeLabel') ??
                    'Delivery Fee',
                style: const TextStyle(color: Colors.grey),
              ),
              const Text(
                '25 ج.م',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.translate('totalOrderLabel') ??
                    'Total',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${(orderData['total'] as int) + 25} ج.م',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFF97316),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF97316).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.medication, color: Color(0xFFF97316)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'الكمية: ${item['qty']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            '${item['price']} ج.م',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.payment, color: Color(0xFF8B5CF6)),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)?.translate('paymentMethodLabel') ??
                    'Payment Method',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.credit_card, color: Colors.grey, size: 20),
                const SizedBox(width: 12),
                Text(
                  orderData['paymentMethod'],
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF97316).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.note, color: Color(0xFFF97316)),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)?.translate('customerNotes') ??
                    'Customer Notes',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            orderData['notes'],
            style: TextStyle(color: Colors.grey[700], height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    String status,
    Color statusColor,
    BuildContext context,
  ) {
    if (status == 'delivered' || status == 'cancelled') {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (status == 'pending')
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showConfirmDialog(
                    context,
                    AppLocalizations.of(context)?.translate('acceptOrderBtn') ??
                        'Accept Order',
                    AppLocalizations.of(context)?.translate('confirm') ??
                        'Accept this order?',
                    const Color(0xFF10B981),
                  ),
                  icon: const Icon(Icons.check),
                  label: Text(
                    AppLocalizations.of(context)?.translate('acceptOrderBtn') ??
                        'Accept Order',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showConfirmDialog(
                    context,
                    AppLocalizations.of(context)?.translate('cancelOrderBtn') ??
                        'Cancel',
                    AppLocalizations.of(context)?.translate('confirm') ??
                        'Cancel this order?',
                    Colors.red,
                  ),
                  icon: const Icon(Icons.close),
                  label: Text(
                    AppLocalizations.of(context)?.translate('cancelOrderBtn') ??
                        'Cancel',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          )
        else if (status == 'processing')
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showConfirmDialog(
                context,
                AppLocalizations.of(context)?.translate('confirmShipping') ??
                    'Confirm Shipping',
                AppLocalizations.of(context)?.translate('confirm') ??
                    'Confirm shipping?',
                const Color(0xFF8B5CF6),
              ),
              icon: const Icon(Icons.local_shipping),
              label: Text(
                AppLocalizations.of(context)?.translate('confirmShipping') ??
                    'Confirm Shipping',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          )
        else if (status == 'shipped')
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showConfirmDialog(
                context,
                AppLocalizations.of(context)?.translate('confirmDelivery') ??
                    'Confirm Delivery',
                AppLocalizations.of(context)?.translate('confirm') ??
                    'Confirm delivery?',
                const Color(0xFF10B981),
              ),
              icon: const Icon(Icons.check_circle),
              label: Text(
                AppLocalizations.of(context)?.translate('confirmDelivery') ??
                    'Confirm Delivery',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone),
            label: Text(
              AppLocalizations.of(context)?.translate('callCustomer') ??
                  'Call Customer',
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: statusColor,
              side: BorderSide(color: statusColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text('$label: ', style: TextStyle(color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  void _showConfirmDialog(
    BuildContext context,
    String title,
    String message,
    Color color,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, textAlign: TextAlign.center),
        content: Text(message, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)?.translate('cancel') ?? 'Cancel',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$title ${AppLocalizations.of(context)?.translate('success') ?? 'successful'}',
                  ),
                  backgroundColor: color,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
            ),
            child: Text(
              AppLocalizations.of(context)?.translate('confirm') ?? 'Confirm',
            ),
          ),
        ],
      ),
    );
  }
}
