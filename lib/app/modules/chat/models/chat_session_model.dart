// Chat session model representing an active chat with a doctor
class ChatSessionModel {
  final int id;
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImageUrl;
  final String doctorStatus; // "online", "offline", "typing"
  final DateTime createdAt;
  final DateTime lastMessageAt;
  final int unreadCount;

  ChatSessionModel({
    required this.id,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorImageUrl,
    required this.doctorStatus,
    required this.createdAt,
    required this.lastMessageAt,
    this.unreadCount = 0,
  });

  // Check if doctor is online
  bool get isOnline => doctorStatus == 'online';

  // Check if doctor is offline
  bool get isOffline => doctorStatus == 'offline';

  // Check if doctor is typing
  bool get isTyping => doctorStatus == 'typing';

  // Get doctor initials for avatar fallback
  String get doctorInitials {
    return doctorName
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0] : '')
        .join('')
        .toUpperCase();
  }

  // Create a copy with modified fields
  ChatSessionModel copyWith({
    int? id,
    String? doctorName,
    String? doctorSpecialization,
    String? doctorImageUrl,
    String? doctorStatus,
    DateTime? createdAt,
    DateTime? lastMessageAt,
    int? unreadCount,
  }) {
    return ChatSessionModel(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialization: doctorSpecialization ?? this.doctorSpecialization,
      doctorImageUrl: doctorImageUrl ?? this.doctorImageUrl,
      doctorStatus: doctorStatus ?? this.doctorStatus,
      createdAt: createdAt ?? this.createdAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
