class Message {
  final String id;
  final String content;
  final String senderId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    // Handle nested createdAt in metadata
    String? createdStr = json['createdAt'] as String?;
    if (createdStr == null && json['metadata'] != null) {
      createdStr = json['metadata']['createdAt'] as String?;
    }

    // Handle different sender ID fields
    String? sId = json['senderId'] as String?;
    sId ??= json['senderDoctorId'] as String?;
    sId ??= json['senderUserId'] as String?;
    // Fallback if needed, or keep empty

    return Message(
      id: json['id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      senderId: sId ?? '',
      createdAt: DateTime.tryParse(createdStr ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
