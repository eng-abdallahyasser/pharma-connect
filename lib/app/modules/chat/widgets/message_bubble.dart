import 'package:flutter/material.dart';
import '../models/message_model.dart';

// Message bubble widget displaying individual chat messages
class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final String doctorImageUrl;
  final String doctorInitials;
  final bool showTimestamp;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.doctorImageUrl,
    required this.doctorInitials,
    this.showTimestamp = true,
  }) : super(key: key);

  // Get status icon based on message status
  Widget _getStatusIcon() {
    switch (message.status) {
      case 'read':
        // Double check mark in green
        return Row(
          children: [
            Icon(
              Icons.check,
              size: 12,
              color: const Color(0xFF00C897),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.check,
              size: 12,
              color: const Color(0xFF00C897),
            ),
          ],
        );
      case 'delivered':
        // Double check mark in gray
        return Row(
          children: [
            Icon(
              Icons.check,
              size: 12,
              color: Colors.grey[500],
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.check,
              size: 12,
              color: Colors.grey[500],
            ),
          ],
        );
      case 'sent':
        // Single check mark in gray
        return Icon(
          Icons.check,
          size: 12,
          color: Colors.grey[500],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.isFromUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Doctor avatar (only for doctor messages)
          if (!isUser)
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  doctorImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          doctorInitials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          // Message content
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Message bubble
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF1A73E8) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    // Adjust corners for message direction
                    border: !isUser
                        ? Border.all(
                            color: Colors.grey[200]!,
                            width: 1,
                          )
                        : null,
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: isUser ? Colors.white : Colors.grey[800],
                      height: 1.4,
                    ),
                  ),
                ),

                // Timestamp and status (only show for last message from sender)
                if (showTimestamp)
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: isUser ? 0 : 8,
                      right: isUser ? 8 : 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isUser) const SizedBox.shrink(),
                        Text(
                          message.timestamp,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                        if (isUser) ...[
                          const SizedBox(width: 4),
                          _getStatusIcon(),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // User avatar (only for user messages)
          if (isUser)
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://images.unsplash.com/photo-1659353888906-adb3e0041693?w=200',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text(
                          'ME',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
