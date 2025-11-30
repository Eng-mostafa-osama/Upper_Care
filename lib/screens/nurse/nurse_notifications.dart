import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class NurseNotificationsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const NurseNotificationsScreen({Key? key, required this.onBack})
    : super(key: key);

  @override
  State<NurseNotificationsScreen> createState() =>
      _NurseNotificationsScreenState();
}

class _NurseNotificationsScreenState extends State<NurseNotificationsScreen> {
  String tr(String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }

  List<Map<String, dynamic>> get _notifications => [
    {
      'id': '1',
      'type': 'appointment',
      'title': tr('newAppointment'),
      'message': '${tr('patientAhmed')} - ${tr('nurseBloodSample')}',
      'time': '2 ${tr('minutesAgo')}',
      'isRead': false,
      'icon': Icons.calendar_today,
      'color': const Color(0xFF3B82F6),
    },
    {
      'id': '2',
      'type': 'reminder',
      'title': tr('upcomingVisit'),
      'message': '${tr('patientFatma')} - ${tr('in30Minutes')}',
      'time': '15 ${tr('minutesAgo')}',
      'isRead': false,
      'icon': Icons.access_time,
      'color': const Color(0xFFF97316),
    },
    {
      'id': '3',
      'type': 'supply',
      'title': tr('lowStockAlert'),
      'message': tr('ivSetsLowStock'),
      'time': '1 ${tr('hourAgo')}',
      'isRead': true,
      'icon': Icons.warning,
      'color': Colors.red,
    },
    {
      'id': '4',
      'type': 'message',
      'title': tr('messageFromAdmin'),
      'message': tr('scheduleUpdated'),
      'time': '3 ${tr('hoursAgo')}',
      'isRead': true,
      'icon': Icons.message,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'id': '5',
      'type': 'completed',
      'title': tr('visitCompleted'),
      'message': '${tr('patientMahmoud')} - ${tr('nurseWoundCare')}',
      'time': '5 ${tr('hoursAgo')}',
      'isRead': true,
      'icon': Icons.check_circle,
      'color': const Color(0xFF10B981),
    },
    {
      'id': '6',
      'type': 'cancellation',
      'title': tr('appointmentCancelled'),
      'message': '${tr('patientSarah')} - ${tr('cancelledByPatient')}',
      'time': tr('yesterday'),
      'isRead': true,
      'icon': Icons.cancel,
      'color': Colors.grey,
    },
  ];

  int get _unreadCount => _notifications.where((n) => !n['isRead']).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECFDF5),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _notifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(_notifications[index]);
                    },
                  ),
          ),
        ],
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
              child: Text(
                tr('notifications'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (_unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_unreadCount ${tr('new')}',
                  style: const TextStyle(
                    color: Color(0xFF2BB9A9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.done_all, color: Colors.white),
              onPressed: _markAllAsRead,
              tooltip: tr('markAllRead'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            tr('noNotifications'),
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isRead = notification['isRead'] as bool;

    return Dismissible(
      key: Key(notification['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        setState(() {
          _notifications.removeWhere((n) => n['id'] == notification['id']);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr('notificationDeleted')),
            action: SnackBarAction(
              label: tr('undo'),
              onPressed: () {
                setState(() {
                  // In real app, would restore from backup
                });
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _markAsRead(notification),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRead
                ? Colors.white
                : const Color(0xFF2BB9A9).withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isRead
                  ? Colors.transparent
                  : const Color(0xFF2BB9A9).withOpacity(0.3),
              width: 1,
            ),
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (notification['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification['icon'] as IconData,
                  color: notification['color'] as Color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontWeight: isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2BB9A9),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['message'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification['time'],
                      style: TextStyle(color: Colors.grey[400], fontSize: 11),
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

  void _markAsRead(Map<String, dynamic> notification) {
    setState(() {
      final index = _notifications.indexWhere(
        (n) => n['id'] == notification['id'],
      );
      if (index != -1) {
        _notifications[index]['isRead'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr('allNotificationsRead')),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
