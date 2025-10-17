import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notification model
class NotificationItem {
  final String id;
  final String title;
  final String titleHindi;
  final String message;
  final String messageHindi;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.titleHindi,
    required this.message,
    required this.messageHindi,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? titleHindi,
    String? message,
    String? messageHindi,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      titleHindi: titleHindi ?? this.titleHindi,
      message: message ?? this.message,
      messageHindi: messageHindi ?? this.messageHindi,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}

enum NotificationType { orderUpdate, promotion, reminder, general, payment }

// Sample notifications provider
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<NotificationItem>>((ref) {
      return NotificationsNotifier();
    });

class NotificationsNotifier extends StateNotifier<List<NotificationItem>> {
  NotificationsNotifier() : super(_sampleNotifications);

  static final List<NotificationItem> _sampleNotifications = [
    NotificationItem(
      id: '1',
      title: 'Order Confirmed',
      titleHindi: 'ऑर्डर पुष्टि',
      message:
          'Your laundry order #12345 has been confirmed and will be picked up tomorrow.',
      messageHindi:
          'आपका लॉन्ड्री ऑर्डर #12345 की पुष्टि हो गई है और कल पिकअप किया जाएगा।',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      type: NotificationType.orderUpdate,
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'Special Offer',
      titleHindi: 'विशेष छूट',
      message: 'Get 20% off on your next dry cleaning service. Use code SAVE20',
      messageHindi:
          'अपनी अगली ड्राई क्लीनिंग सेवा पर 20% छूट पाएं। कोड SAVE20 का उपयोग करें',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.promotion,
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      title: 'Pickup Reminder',
      titleHindi: 'पिकअप अनुस्मारक',
      message:
          'Don\'t forget! Your laundry pickup is scheduled for today at 3:00 PM.',
      messageHindi:
          'मत भूलिए! आपका लॉन्ड्री पिकअप आज दोपहर 3:00 बजे निर्धारित है।',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      type: NotificationType.reminder,
      isRead: true,
    ),
    NotificationItem(
      id: '4',
      title: 'Payment Successful',
      titleHindi: 'भुगतान सफल',
      message: 'Payment of ₹450 received successfully for order #12344.',
      messageHindi:
          'ऑर्डर #12344 के लिए ₹450 का भुगतान सफलतापूर्वक प्राप्त हुआ।',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.payment,
      isRead: true,
    ),
    NotificationItem(
      id: '5',
      title: 'Order Completed',
      titleHindi: 'ऑर्डर पूर्ण',
      message:
          'Your laundry order #12343 has been completed and is ready for delivery.',
      messageHindi:
          'आपका लॉन्ड्री ऑर्डर #12343 पूरा हो गया है और डिलीवरी के लिए तैयार है।',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.orderUpdate,
      isRead: true,
    ),
    NotificationItem(
      id: '6',
      title: 'Welcome to SewaxPress',
      titleHindi: 'SewaxPress में आपका स्वागत है',
      message:
          'Thank you for choosing SewaxPress! Enjoy convenient laundry services.',
      messageHindi:
          'SewaxPress चुनने के लिए धन्यवाद! सुविधाजनक लॉन्ड्री सेवाओं का आनंद लें।',
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      type: NotificationType.general,
      isRead: true,
    ),
  ];

  void markAsRead(String id) {
    state = state.map((notification) {
      if (notification.id == id) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
  }

  void markAllAsRead() {
    state = state.map((notification) {
      return notification.copyWith(isRead: true);
    }).toList();
  }

  void deleteNotification(String id) {
    state = state.where((notification) => notification.id != id).toList();
  }

  void clearAll() {
    state = [];
  }
}

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  String selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    // Filter notifications based on selected filter
    final filteredNotifications = _filterNotifications(
      notifications,
      selectedFilter,
    );
    final unreadCount = notifications.where((n) => !n.isRead).length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF1976D2), Colors.grey[50]!],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(isTablet ? 30 : 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      'सूचनाएं / Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 32 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (unreadCount > 0) ...[
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$unreadCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTablet ? 14 : 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: isTablet ? 28 : 24,
                      ),
                      onSelected: _handleMenuSelection,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'mark_all_read',
                          child: Row(
                            children: [
                              Icon(Icons.mark_email_read, size: 20),
                              SizedBox(width: 8),
                              Text('Mark all as read'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'clear_all',
                          child: Row(
                            children: [
                              Icon(Icons.clear_all, size: 20),
                              SizedBox(width: 8),
                              Text('Clear all'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 800 : double.infinity,
                  ),
                  margin: isDesktop
                      ? const EdgeInsets.symmetric(horizontal: 24)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isTablet ? 40 : 30),
                      topRight: Radius.circular(isTablet ? 40 : 30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Filter Tabs
                      _buildFilterTabs(isTablet),

                      // Notifications List
                      Expanded(
                        child: filteredNotifications.isEmpty
                            ? _buildEmptyState(isTablet)
                            : ListView.builder(
                                padding: EdgeInsets.all(isTablet ? 20 : 15),
                                itemCount: filteredNotifications.length,
                                itemBuilder: (context, index) {
                                  final notification =
                                      filteredNotifications[index];
                                  return _buildNotificationCard(
                                    notification,
                                    isTablet,
                                    index == filteredNotifications.length - 1,
                                  );
                                },
                              ),
                      ),
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

  Widget _buildFilterTabs(bool isTablet) {
    final filters = [
      {'key': 'all', 'label': 'सभी / All'},
      {'key': 'unread', 'label': 'अपठित / Unread'},
      {'key': 'orders', 'label': 'ऑर्डर / Orders'},
      {'key': 'promotions', 'label': 'ऑफर / Offers'},
    ];

    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter['key'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter['key']!;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: isTablet ? 15 : 12),
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16,
                  vertical: isTablet ? 12 : 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1976D2) : Colors.white,
                  borderRadius: BorderRadius.circular(isTablet ? 25 : 20),
                  border: isSelected
                      ? null
                      : Border.all(color: Colors.grey[300]!),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF1976D2).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  filter['label']!,
                  style: TextStyle(
                    fontSize: isTablet ? 14 : 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    NotificationItem notification,
    bool isTablet,
    bool isLast,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : (isTablet ? 15 : 12)),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : Colors.blue[50],
        borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
        border: notification.isRead
            ? Border.all(color: Colors.grey[200]!)
            : Border.all(color: const Color(0xFF1976D2).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isTablet ? 15 : 10,
            offset: Offset(0, isTablet ? 5 : 3),
          ),
        ],
      ),
      child: Dismissible(
        key: Key(notification.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          ref
              .read(notificationsProvider.notifier)
              .deleteNotification(notification.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('सूचना हटाई गई / Notification deleted'),
              backgroundColor: Colors.red,
            ),
          );
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: isTablet ? 30 : 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(isTablet ? 20 : 15),
          ),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: isTablet ? 28 : 24,
          ),
        ),
        child: ListTile(
          onTap: () {
            if (!notification.isRead) {
              ref
                  .read(notificationsProvider.notifier)
                  .markAsRead(notification.id);
            }
            _showNotificationDetails(notification, isTablet);
          },
          leading: Container(
            width: isTablet ? 50 : 45,
            height: isTablet ? 50 : 45,
            decoration: BoxDecoration(
              color: _getNotificationColor(notification.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
            ),
            child: Icon(
              _getNotificationIcon(notification.type),
              color: _getNotificationColor(notification.type),
              size: isTablet ? 24 : 20,
            ),
          ),
          title: Text(
            '${notification.titleHindi} / ${notification.title}',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              fontWeight: notification.isRead
                  ? FontWeight.w500
                  : FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                notification.messageHindi,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                _formatTime(notification.timestamp),
                style: TextStyle(
                  fontSize: isTablet ? 12 : 10,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2),
                    shape: BoxShape.circle,
                  ),
                ),
              Icon(
                Icons.arrow_forward_ios,
                size: isTablet ? 16 : 14,
                color: Colors.grey[400],
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 16,
            vertical: isTablet ? 16 : 12,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isTablet) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: isTablet ? 80 : 60,
            color: Colors.grey[400],
          ),
          SizedBox(height: isTablet ? 20 : 15),
          Text(
            'कोई सूचना नहीं',
            style: TextStyle(
              fontSize: isTablet ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'No notifications found',
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  List<NotificationItem> _filterNotifications(
    List<NotificationItem> notifications,
    String filter,
  ) {
    switch (filter) {
      case 'unread':
        return notifications.where((n) => !n.isRead).toList();
      case 'orders':
        return notifications
            .where((n) => n.type == NotificationType.orderUpdate)
            .toList();
      case 'promotions':
        return notifications
            .where((n) => n.type == NotificationType.promotion)
            .toList();
      default:
        return notifications;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.orderUpdate:
        return Colors.blue;
      case NotificationType.promotion:
        return Colors.green;
      case NotificationType.reminder:
        return Colors.orange;
      case NotificationType.payment:
        return Colors.purple;
      case NotificationType.general:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.orderUpdate:
        return Icons.shopping_bag;
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.reminder:
        return Icons.schedule;
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.general:
        return Icons.info;
    }
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} दिन पहले / ${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} घंटे पहले / ${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} मिनट पहले / ${difference.inMinutes} minutes ago';
    } else {
      return 'अभी / Just now';
    }
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'mark_all_read':
        ref.read(notificationsProvider.notifier).markAllAsRead();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'सभी सूचनाएं पढ़ी गई / All notifications marked as read',
            ),
            backgroundColor: Colors.green,
          ),
        );
        break;
      case 'clear_all':
        _showClearAllConfirmation();
        break;
    }
  }

  void _showClearAllConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('सभी सूचनाएं हटाएं / Clear All Notifications'),
          content: Text(
            'क्या आप सभी सूचनाएं हटाना चाहते हैं? / Are you sure you want to delete all notifications?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('रद्द करें / Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(notificationsProvider.notifier).clearAll();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'सभी सूचनाएं हटाई गई / All notifications cleared',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: Text(
                'हटाएं / Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationDetails(NotificationItem notification, bool isTablet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${notification.titleHindi} / ${notification.title}',
            style: TextStyle(fontSize: isTablet ? 18 : 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.messageHindi,
                style: TextStyle(fontSize: isTablet ? 16 : 14),
              ),
              SizedBox(height: 10),
              Text(
                notification.message,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    _getNotificationIcon(notification.type),
                    size: isTablet ? 20 : 18,
                    color: _getNotificationColor(notification.type),
                  ),
                  SizedBox(width: 8),
                  Text(
                    _formatTime(notification.timestamp),
                    style: TextStyle(
                      fontSize: isTablet ? 12 : 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('बंद करें / Close'),
            ),
          ],
        );
      },
    );
  }
}
