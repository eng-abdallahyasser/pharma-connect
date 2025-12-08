import 'package:flutter/material.dart';
import '../models/chat_session_model.dart';

// Chat header widget displaying doctor info and action buttons
class ChatHeader extends StatelessWidget {
  final ChatSessionModel session;
  final VoidCallback onBackPressed;
  final VoidCallback onVideoCallPressed;
  final VoidCallback onVoiceCallPressed;
  final VoidCallback onMorePressed;

  const ChatHeader({
    Key? key,
    required this.session,
    required this.onBackPressed,
    required this.onVideoCallPressed,
    required this.onVoiceCallPressed,
    required this.onMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // White background with bottom border
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: onBackPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back,
                color: Colors.grey[700],
                size: 24,
              ),
            ),
          ),

          // Doctor avatar with status indicator
          Stack(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    session.doctorImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback avatar with initials
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            session.doctorInitials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Status indicator dot (only for online)
              if (session.isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF00C897),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Doctor information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor name
                Text(
                  session.doctorName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2),

                // Doctor status
                Text(
                  session.isTyping
                      ? 'Typing...'
                      : session.isOnline
                          ? 'Online'
                          : session.doctorSpecialization,
                  style: TextStyle(
                    fontSize: 12,
                    color: session.isTyping
                        ? const Color(0xFF00C897)
                        : Colors.grey[600],
                    fontWeight:
                        session.isTyping ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Row(
            children: [
              // Video call button
              GestureDetector(
                onTap: onVideoCallPressed,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.videocam,
                    color: const Color(0xFF1A73E8),
                    size: 20,
                  ),
                ),
              ),

              // Voice call button
              GestureDetector(
                onTap: onVoiceCallPressed,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.phone,
                    color: const Color(0xFF1A73E8),
                    size: 20,
                  ),
                ),
              ),

              // More options button
              GestureDetector(
                onTap: onMorePressed,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
