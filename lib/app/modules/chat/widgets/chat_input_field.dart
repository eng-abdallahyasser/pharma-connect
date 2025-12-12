import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Chat input field widget for composing and sending messages
class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;
  final VoidCallback onAttachmentPressed;
  final bool showAttachmentMenu;

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.onSendPressed,
    required this.onAttachmentPressed,
    this.showAttachmentMenu = false,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late bool _hasText;

  @override
  void initState() {
    super.initState();
    _hasText = false;
    // Listen to text changes
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  // Handle text changes
  void _onTextChanged() {
    setState(() {
      _hasText = widget.controller.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // White background with top border
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          // Attachment button
          GestureDetector(
            onTap: widget.onAttachmentPressed,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.showAttachmentMenu
                    ? const Color(0xFF1A73E8)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.attach_file,
                color: widget.showAttachmentMenu
                    ? Colors.white
                    : Colors.grey[600],
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Message input field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Text input
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'chat.type_message'.tr,
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),

                  // Emoji button
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement emoji picker
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button
          GestureDetector(
            onTap: _hasText ? widget.onSendPressed : null,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _hasText ? const Color(0xFF1A73E8) : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send,
                color: _hasText ? Colors.white : Colors.grey[500],
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
