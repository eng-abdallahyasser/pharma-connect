import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

/// Notification service for handling FCM tokens and push notifications
class NotificationService extends GetxService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;

  /// Get the current FCM token, or null if not available
  String? get fcmToken => _fcmToken;

  /// Initialize the notification service
  Future<NotificationService> init() async {
    try {
      // Request permission for notifications
      await _requestPermission();

      // Get FCM token
      await _getToken();

      // Listen for token refresh
      _listenToTokenRefresh();

      log('NotificationService initialized successfully');
    } catch (e) {
      log('Error initializing NotificationService: $e');
    }
    return this;
  }

  /// Request notification permission from user
  Future<void> _requestPermission() async {
    try {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted notification permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log('User granted provisional notification permission');
      } else {
        log('User declined notification permission');
      }
    } catch (e) {
      log('Error requesting notification permission: $e');
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
      // TODO: Send updated token to backend when implemented
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
