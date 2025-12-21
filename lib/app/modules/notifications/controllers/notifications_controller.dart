import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/notification_model.dart';

// Notifications controller manages notifications and their state
class NotificationsController extends GetxController {
  // Observable properties for reactive UI updates
  final notifications = <NotificationModel>[].obs;
  final selectedTab = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize notifications with sample data
    _initializeNotifications();
  }

  // Initialize notifications with sample data
  void _initializeNotifications() {
    notifications.value = [
      NotificationModel(
        id: 1,
        type: 'medicine',
        title: 'Time to take Aspirin',
        message: 'It\'s 8:00 PM. Take 100mg Aspirin after meals',
        time: '5 min ago',
        read: false,
        actionable: true,
        medicineId: 1,
      ),
      NotificationModel(
        id: 2,
        type: 'medicine',
        title: 'Upcoming: Ibuprofen',
        message: 'Reminder: Take 400mg Ibuprofen at 10:00 PM',
        time: '1 hour ago',
        read: false,
        actionable: false,
      ),
      NotificationModel(
        id: 3,
        type: 'appointment',
        title: 'Consultation Tomorrow',
        message:
            'Your video consultation with Dr. Sarah Johnson is scheduled for Dec 6 at 10:00 AM',
        time: '2 hours ago',
        read: false,
        actionable: false,
      ),
      NotificationModel(
        id: 4,
        type: 'medicine',
        title: 'Medicine taken ✓',
        message: 'You\'ve successfully logged taking Vitamin D3 at 9:00 AM',
        time: '9 hours ago',
        read: true,
        actionable: false,
      ),
      NotificationModel(
        id: 5,
        type: 'order',
        title: 'Order Delivered',
        message: 'Your order #12345 has been delivered successfully',
        time: 'Yesterday',
        read: true,
        actionable: false,
      ),
      NotificationModel(
        id: 6,
        type: 'message',
        title: 'New message from Dr. Chen',
        message:
            'Dr. Michael Chen has sent you a message about your recent consultation',
        time: 'Yesterday',
        read: true,
        actionable: false,
      ),
      NotificationModel(
        id: 7,
        type: 'medicine',
        title: 'Missed: Metformin',
        message: 'You missed taking Metformin at 7:30 AM today',
        time: '2 days ago',
        read: true,
        actionable: false,
      ),
    ];
  }

  // Mark notification as read
  void markAsRead(int notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(read: true);
    }
  }

  // Mark all notifications as read
  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      notifications[i] = notifications[i].copyWith(read: true);
    }
  }

  // Delete notification
  void deleteNotification(int notificationId) {
    notifications.removeWhere((n) => n.id == notificationId);
  }

  // Handle take medicine action
  Future<void> handleTakeMedicine(int notificationId) async {
    try {
      markAsRead(notificationId);
      Get.snackbar('Success', 'Medicine marked as taken');
    } catch (e) {
      Get.snackbar('Error', 'Failed to mark medicine as taken: $e');
    }
  }

  // Get unread count
  int getUnreadCount() {
    return notifications.where((n) => n.isUnread).length;
  }

  // Get medicine notifications
  List<NotificationModel> getMedicineNotifications() {
    return notifications.where((n) => n.isMedicineType).toList();
  }

  // Get other notifications (non-medicine)
  List<NotificationModel> getOtherNotifications() {
    return notifications.where((n) => !n.isMedicineType).toList();
  }

  // Get all notifications
  List<NotificationModel> getAllNotifications() {
    return notifications;
  }

  // Get filtered notifications based on selected tab
  List<NotificationModel> getFilteredNotifications() {
    if (selectedTab.value == 'medicine') {
      return getMedicineNotifications();
    } else if (selectedTab.value == 'other') {
      return getOtherNotifications();
    }
    return getAllNotifications();
  }

  // Change selected tab
  void selectTab(String tab) {
    selectedTab.value = tab;
  }

  // Get icon color based on notification type
  Color getNotificationColor(String type) {
    final colorScheme = Get.theme.colorScheme;
    switch (type) {
      case 'medicine':
        return colorScheme.primary; // Blue
      case 'appointment':
        return colorScheme.secondary; // Green
      case 'order':
        return colorScheme.tertiary; // Purple
      case 'message':
        return Colors.orange; // Orange
      default:
        return colorScheme.outline; // Gray
    }
  }

  // Get icon based on notification type
  IconData getNotificationIcon(String type) {
    switch (type) {
      case 'medicine':
        return Icons.medication;
      case 'appointment':
        return Icons.calendar_today;
      case 'order':
        return Icons.shopping_bag;
      case 'message':
        return Icons.message;
      default:
        return Icons.notifications;
    }
  }
}
