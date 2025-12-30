import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/routes/app_routes.dart';

// IMPORTANT: This must be a top-level function (outside any class)
// Handles notifications when app is TERMINATED
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling background message: ${message.messageId}');
  log('Title: ${message.notification?.title}');
  log('Body: ${message.notification?.body}');
}

/// Notification service for handling FCM tokens and push notifications
class NotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  String? _fcmToken;

  /// Get the current FCM token, or null if not available
  String? get fcmToken => _fcmToken;

  /// Initialize the notification service
  Future<NotificationService> init() async {
    try {
      // Set up background handler
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Request permission
      await _requestPermission();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      await _getToken();

      // Listen for token refresh
      _listenToTokenRefresh();

      // Setup handlers
      _setupForegroundHandler();
      _setupBackgroundHandler();
      _setupTerminatedHandler();

      log('NotificationService initialized successfully');
    } catch (e) {
      log('Error initializing NotificationService: $e');
    }
    return this;
  }

  /// Request notification permission
  Future<void> _requestPermission() async {
    log('-------------------------------------------');
    log('REQUESTING NOTIFICATION PERMISSION...');
    try {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      log('Permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted notification permission');
      } else {
        log('User declined notification permission');
      }
    } catch (e) {
      log('Error requesting notification permission: $e');
    }
    log('-------------------------------------------');
  }

  /// Initialize local notifications for foreground display
  Future<void> _initializeLocalNotifications() async {
    // Android settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );

    // iOS settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  /// Handle foreground messages
  void _setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(name : "NotificationService", '📱 FOREGROUND: Got a message!');
      log(name : "NotificationService", 'Title: ${message.notification?.title}');

      // Show local notification
      _showLocalNotification(message);
    });
  }

  /// Handle background messages (when tapped)
  void _setupBackgroundHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🔔 BACKGROUND: Notification tapped!');
      _handleNotificationNavigation(message);
    });
  }

  /// Handle terminated state
  void _setupTerminatedHandler() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      log('💀 TERMINATED: App opened from notification!');
      // Wait a bit for app to initialize
      await Future.delayed(const Duration(seconds: 1));
      _handleNotificationNavigation(initialMessage);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    // Android notification details
    const androidDetails = AndroidNotificationDetails(
      'pharma_connect_channel',
      'Pharma Connect Notifications',
      channelDescription: 'Main notification channel',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
    );

    // iOS notification details
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data.toString(),
    );
  }

  /// Handle tap on local notification
  void _onNotificationTapped(NotificationResponse response) {
    log('Local Notification tapped! Payload: ${response.payload}');
    Get.toNamed(AppRoutes.notifications);
  }

  /// Navigate based on notification type
  void _handleNotificationNavigation(RemoteMessage message) {
    // Extract type from data payload
    final data = message.data;
    final type = data['type'] as String?;

    log('Navigating based on type: $type');

    if (type == 'medicine') {
      Get.toNamed(AppRoutes.medicines);
    } else if (type == 'order') {
      Get.toNamed(AppRoutes.profile);
    } else if (type == 'appointment') {
      Get.toNamed(AppRoutes.consultations);
    } else if (type == 'message') {
      Get.toNamed(AppRoutes.chat);
    } else {
      Get.toNamed(AppRoutes.notifications);
    }
  }

  /// Get the FCM token from Firebase
  Future<String?> _getToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      if (_fcmToken != null) {
        log('FCM Token: $_fcmToken');
      } else {
        log('Failed to get FCM token');
      }
      return _fcmToken;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  /// Listen for FCM token refresh
  void _listenToTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      log('FCM Token refreshed: $newToken');
    });
  }

  /// Get the current FCM token (public method)
  Future<String?> getToken() async {
    if (_fcmToken != null) {
      return _fcmToken;
    }
    return await _getToken();
  }
}
