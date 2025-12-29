import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_tabs.dart';

// Notifications view - main screen for managing notifications
class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with title and mark all read button
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  // Header with title and mark all read button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title and unread count
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'notifications.title'.tr,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),

                          // Unread count
                          Obx(() {
                            final unreadCount = controller.getUnreadCount();
                            if (unreadCount == 0) {
                              return const SizedBox.shrink();
                            }

                            return Text(
                              'notifications.unread'.trParams({
                                'count': unreadCount.toString(),
                              }),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimary.withAlpha(234),
                              ),
                            );
                          }),
                        ],
                      ),

                      // Mark all read button
                      Obx(() {
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
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimary.withAlpha(51),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'notifications.mark_all_read'.tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
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
                      medicineCount: controller
                          .getMedicineNotifications()
                          .length,
                      otherCount: controller.getOtherNotifications().length,
                      onTabChanged: controller.selectTab,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Notifications list
                  Obx(() {
                    final filteredNotifications = controller
                        .getFilteredNotifications();

                    if (filteredNotifications.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Column(
                          children: [
                            Icon(
                              Icons.notifications_none,
                              size: 48,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'notifications.no_notifications'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(filteredNotifications.length, (
                        index,
                      ) {
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
                            onTap: () => controller.markAsRead(notification.id),
                            onSkip: () =>
                                controller.deleteNotification(notification.id),
                            onTaken: () =>
                                controller.handleTakeMedicine(notification.id),
                            iconColor: iconColor,
                            icon: icon,
                          ),
                        );
                      }),
                    );
                  }),

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
