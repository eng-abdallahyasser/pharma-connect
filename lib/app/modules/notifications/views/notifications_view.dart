import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_tabs.dart';

// Notifications view - main screen for managing notifications
class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with title and mark all read button
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1A73E8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title and mark all read button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title and unread count
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          // Unread count
                          Obx(
                            () {
                              final unreadCount = controller.getUnreadCount();
                              if (unreadCount == 0) {
                                return const SizedBox.shrink();
                              }

                              return Text(
                                '$unreadCount unread',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Mark all read button
                      Obx(
                        () {
                          final unreadCount = controller.getUnreadCount();
                          if (unreadCount == 0) {
                            return const SizedBox.shrink();
                          }

                          return GestureDetector(
                            onTap: controller.markAllAsRead,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Mark all read',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notification tabs
                  Obx(
                    () => NotificationTabs(
                      selectedTab: controller.selectedTab.value,
                      allCount: controller.getAllNotifications().length,
                      medicineCount:
                          controller.getMedicineNotifications().length,
                      otherCount: controller.getOtherNotifications().length,
                      onTabChanged: controller.selectTab,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Notifications list
                  Obx(
                    () {
                      final filteredNotifications =
                          controller.getFilteredNotifications();

                      if (filteredNotifications.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          child: Column(
                            children: [
                              Icon(
                                Icons.notifications_none,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No notifications yet',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: List.generate(
                          filteredNotifications.length,
                          (index) {
                            final notification = filteredNotifications[index];
                            final iconColor = controller.getNotificationColor(
                              notification.type,
                            );
                            final icon = controller.getNotificationIcon(
                              notification.type,
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: NotificationCard(
                                notification: notification,
                                onTap: () =>
                                    controller.markAsRead(notification.id),
                                onSkip: () => controller
                                    .deleteNotification(notification.id),
                                onTaken: () => controller
                                    .handleTakeMedicine(notification.id),
                                iconColor: iconColor,
                                icon: icon,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
