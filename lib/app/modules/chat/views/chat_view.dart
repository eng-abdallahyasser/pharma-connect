import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_header.dart';
import '../widgets/message_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/attachment_menu.dart';
import '../widgets/chat_input_field.dart';

// Chat view - main screen for doctor-patient communication
class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          // Chat header with doctor info and action buttons
          ChatHeader(
            session: controller.getSession(),
            onBackPressed: () => Get.back(),
            onVideoCallPressed: controller.initiateVideoCall,
            onVoiceCallPressed: controller.initiateVoiceCall,
            onMorePressed: controller.showMoreOptions,
          ),

          // Security info banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A73E8).withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                'chat.secure_banner'.tr,
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF1A73E8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Messages area
          Expanded(
            child: Obx(() {
              final messages = controller.getAllMessages();
              final session = controller.getSession();

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                itemCount:
                    messages.length +
                    (session.isTyping
                        ? 2
                        : 1), // +2 for date divider and typing
                itemBuilder: (context, index) {
                  // Date divider at the top
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'chat.today'.tr,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  // Typing indicator
                  if (session.isTyping && index == messages.length + 1) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TypingIndicator(
                        doctorImageUrl: session.doctorImageUrl,
                        doctorInitials: session.doctorInitials,
                      ),
                    );
                  }

                  // Message bubble
                  final messageIndex = index - 1;
                  if (messageIndex < messages.length) {
                    final message = messages[messageIndex];

                    // Check if we should show timestamp
                    // Show timestamp if it's the last message from this sender
                    final showTimestamp =
                        messageIndex == messages.length - 1 ||
                        messages[messageIndex + 1].sender != message.sender;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: MessageBubble(
                        message: message,
                        doctorImageUrl: session.doctorImageUrl,
                        doctorInitials: session.doctorInitials,
                        showTimestamp: showTimestamp,
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              );
            }),
          ),

          // Attachment menu (shown when toggled)
          Obx(
            () => controller.showAttachmentMenu.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: AttachmentMenu(
                      onPhotoPressed: controller.attachPhoto,
                      onDocumentPressed: controller.attachDocument,
                      onMedicalReportPressed: controller.attachMedicalReport,
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Chat input field
          ChatInputField(
            controller: controller.messageInputController,
            onSendPressed: () {
              final text = controller.messageInputController.text;
              controller.sendMessage(text);
            },
            onAttachmentPressed: controller.toggleAttachmentMenu,
            showAttachmentMenu: controller.showAttachmentMenu.value,
          ),
        ],
      ),
    );
  }
}
