// Notification model representing a single notification
class NotificationModel {
  final int id;
  final String type; // "medicine", "appointment", "order", "message"
  final String title;
  final String message;
  final String time;
  final bool read;
  final bool actionable;
  final int? medicineId;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    required this.read,
    this.actionable = false,
    this.medicineId,
  });

  // Check if notification is unread
  bool get isUnread => !read;

  // Check if notification is medicine type
  bool get isMedicineType => type == 'medicine';

  // Check if notification is appointment type
  bool get isAppointmentType => type == 'appointment';

  // Check if notification is order type
  bool get isOrderType => type == 'order';

  // Check if notification is message type
  bool get isMessageType => type == 'message';

  // Create a copy with modified fields
  NotificationModel copyWith({
    int? id,
    String? type,
    String? title,
    String? message,
    String? time,
    bool? read,
    bool? actionable,
    int? medicineId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      read: read ?? this.read,
      actionable: actionable ?? this.actionable,
      medicineId: medicineId ?? this.medicineId,
    );
  }
}
