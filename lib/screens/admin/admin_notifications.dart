import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AdminNotifications extends StatefulWidget {
  final VoidCallback onBack;

  const AdminNotifications({super.key, required this.onBack});

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  String selectedFilter = 'all';

  List<Map<String, dynamic>> _getNotifications(AppLocalizations? loc) {
    return [
      {
        'id': '1',
        'title': loc?.translate('newOrderNotif') ?? 'New Order',
        'message':
            loc?.translate('newOrderReceivedMessage') ??
            'New order #1234 received from Ahmed Ali',
        'type': 'order',
        'time': loc?.translate('minutesAgo5') ?? '5 minutes ago',
        'read': false,
        'icon': Icons.shopping_cart,
        'color': const Color(0xFFF97316),
      },
      {
        'id': '2',
        'title': loc?.translate('newDoctorNotif') ?? 'New Doctor',
        'message':
            loc?.translate('newDoctorRequestMessage') ??
            'Dr. Mohamed Saeed requests registration as a doctor',
        'type': 'doctor',
        'time': loc?.translate('minutesAgo15') ?? '15 minutes ago',
        'read': false,
        'icon': Icons.medical_services,
        'color': const Color(0xFF06B6D4),
      },
      {
        'id': '3',
        'title': loc?.translate('stockAlertNotif') ?? 'Stock Alert',
        'message':
            loc?.translate('stockAlertMessage') ??
            'Paracetamol 500mg is running low (5 boxes remaining)',
        'type': 'inventory',
        'time': loc?.translate('minutesAgo30') ?? '30 minutes ago',
        'read': false,
        'icon': Icons.inventory,
        'color': const Color(0xFFEF4444),
      },
      {
        'id': '4',
        'title': loc?.translate('newPaymentNotif') ?? 'New Payment',
        'message':
            loc?.translate('paymentReceivedMessage') ??
            'Payment of 1,250 EGP received from Fatima Hassan',
        'type': 'payment',
        'time': loc?.translate('oneHourAgo') ?? '1 hour ago',
        'read': true,
        'icon': Icons.payments,
        'color': const Color(0xFF10B981),
      },
      {
        'id': '5',
        'title':
            loc?.translate('cancellationRequest') ?? 'Cancellation Request',
        'message':
            loc?.translate('cancellationMessage') ??
            'Customer Khaled Mahmoud requested cancellation of order #1238',
        'type': 'order',
        'time': loc?.translate('hoursAgo2') ?? '2 hours ago',
        'read': true,
        'icon': Icons.cancel,
        'color': const Color(0xFFEF4444),
      },
      {
        'id': '6',
        'title': loc?.translate('deliveryComplete') ?? 'Delivery Complete',
        'message':
            loc?.translate('deliveryCompleteMessage') ??
            'Order #1236 delivered successfully to Sara Ahmed',
        'type': 'order',
        'time': loc?.translate('hoursAgo3') ?? '3 hours ago',
        'read': true,
        'icon': Icons.check_circle,
        'color': const Color(0xFF10B981),
      },
      {
        'id': '7',
        'title': loc?.translate('newReviewNotif') ?? 'New Review',
        'message':
            loc?.translate('newReviewMessage') ??
            'Dr. Ahmed Khaled received a 5-star review from a patient',
        'type': 'review',
        'time': loc?.translate('hoursAgo4') ?? '4 hours ago',
        'read': true,
        'icon': Icons.star,
        'color': const Color(0xFFF59E0B),
      },
      {
        'id': '8',
        'title':
            loc?.translate('appointmentCancelled') ?? 'Appointment Cancelled',
        'message':
            loc?.translate('appointmentCancelledMessage') ??
            'Patient Mohamed Ahmed\'s appointment with Dr. Sara was cancelled',
        'type': 'appointment',
        'time': loc?.translate('hoursAgo5') ?? '5 hours ago',
        'read': true,
        'icon': Icons.event_busy,
        'color': const Color(0xFF8B5CF6),
      },
    ];
  }

  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (notifications.isEmpty) {
      final loc = AppLocalizations.of(context);
      notifications = _getNotifications(loc);
    }
  }

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == 'all') return notifications;
    if (selectedFilter == 'unread') {
      return notifications.where((n) => n['read'] == false).toList();
    }
    return notifications.where((n) => n['type'] == selectedFilter).toList();
  }

  int get unreadCount => notifications.where((n) => n['read'] == false).length;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF3E8FF), Color(0xFFEDE9FE), Color(0xFFDDD6FE)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(loc),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildStats(loc),
                      const SizedBox(height: 20),
                      _buildFilters(loc),
                      const SizedBox(height: 20),
                      _buildNotificationsList(loc),
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

  Widget _buildHeader(AppLocalizations? loc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
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
                  loc?.translate('notificationsManagement') ?? 'Notifications',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$unreadCount ${loc?.translate('unreadNotifications') ?? 'unread notifications'}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _markAllAsRead(loc),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.done_all, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(AppLocalizations? loc) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            loc?.translate('allNotifications') ?? 'All',
            '${notifications.length}',
            const Color(0xFF8B5CF6),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('unreadOnly') ?? 'Unread',
            '$unreadCount',
            const Color(0xFFF97316),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            loc?.translate('todayNotif') ?? 'Today',
            '${notifications.length}',
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

  Widget _buildFilters(AppLocalizations? loc) {
    final filters = [
      {
        'key': 'all',
        'label': loc?.translate('allNotifications') ?? 'All',
        'icon': Icons.all_inbox,
      },
      {
        'key': 'unread',
        'label': loc?.translate('unreadOnly') ?? 'Unread',
        'icon': Icons.mark_email_unread,
      },
      {
        'key': 'order',
        'label': loc?.translate('orderNotif') ?? 'Orders',
        'icon': Icons.shopping_cart,
      },
      {
        'key': 'doctor',
        'label': loc?.translate('doctorNotif') ?? 'Doctors',
        'icon': Icons.medical_services,
      },
      {
        'key': 'inventory',
        'label': loc?.translate('inventoryNotif') ?? 'Inventory',
        'icon': Icons.inventory,
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter['key'];
          return GestureDetector(
            onTap: () =>
                setState(() => selectedFilter = filter['key'] as String),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                      )
                    : null,
                color: isSelected ? null : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF8B5CF6).withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    filter['icon'] as IconData,
                    size: 16,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    filter['label'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationsList(AppLocalizations? loc) {
    final notifs = filteredNotifications;

    if (notifs.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.notifications_off, size: 60, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              loc?.translate('noNotifications') ?? 'No notifications',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return Column(
      children: notifs
          .map((notification) => _buildNotificationCard(notification, loc))
          .toList(),
    );
  }

  Widget _buildNotificationCard(
    Map<String, dynamic> notification,
    AppLocalizations? loc,
  ) {
    final bool isRead = notification['read'] as bool;
    final Color color = notification['color'] as Color;

    return Dismissible(
      key: Key(notification['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        setState(() {
          notifications.removeWhere((n) => n['id'] == notification['id']);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loc?.translate('notificationDeleted') ?? 'Notification deleted',
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            action: SnackBarAction(
              label: loc?.translate('undo') ?? 'Undo',
              onPressed: () {
                setState(() {
                  notifications.add(notification);
                });
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _handleNotificationTap(notification, loc),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isRead ? 0.7 : 0.95),
            borderRadius: BorderRadius.circular(20),
            border: isRead
                ? null
                : Border.all(color: color.withOpacity(0.3), width: 2),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  notification['icon'] as IconData,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontWeight: isRead
                                  ? FontWeight.w500
                                  : FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              notification['time'],
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _getTypeLabel(notification['type'], loc),
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

  String _getTypeLabel(String type, AppLocalizations? loc) {
    switch (type) {
      case 'order':
        return loc?.translate('orderType') ?? 'Order';
      case 'doctor':
        return loc?.translate('doctorType') ?? 'Doctor';
      case 'inventory':
        return loc?.translate('inventoryType') ?? 'Inventory';
      case 'payment':
        return loc?.translate('paymentType') ?? 'Payment';
      case 'review':
        return loc?.translate('reviewType') ?? 'Review';
      case 'appointment':
        return loc?.translate('appointmentType') ?? 'Appointment';
      default:
        return loc?.translate('generalType') ?? 'General';
    }
  }

  void _handleNotificationTap(
    Map<String, dynamic> notification,
    AppLocalizations? loc,
  ) {
    // Mark as read
    setState(() {
      final index = notifications.indexWhere(
        (n) => n['id'] == notification['id'],
      );
      if (index != -1) {
        notifications[index]['read'] = true;
      }
    });

    // Show notification details
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNotificationDetails(notification, loc),
    );
  }

  Widget _buildNotificationDetails(
    Map<String, dynamic> notification,
    AppLocalizations? loc,
  ) {
    final Color color = notification['color'] as Color;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              notification['icon'] as IconData,
              color: color,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            notification['title'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            notification['message'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Text(
                  notification['time'],
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[300]!),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(loc?.translate('closeBtn') ?? 'Close'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate to related screen based on type
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    loc?.translate('viewDetailsBtn') ?? 'View Details',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _markAllAsRead(AppLocalizations? loc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          loc?.translate('markAllReadConfirm') ?? 'Mark all as read',
          textAlign: TextAlign.center,
        ),
        content: Text(
          loc?.translate('markAllReadQuestion') ??
              'Do you want to mark all notifications as read?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc?.translate('cancel') ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification['read'] = true;
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    loc?.translate('allMarkedRead') ??
                        'All notifications marked as read',
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
              foregroundColor: Colors.white,
            ),
            child: Text(loc?.translate('confirm') ?? 'Confirm'),
          ),
        ],
      ),
    );
  }
}
