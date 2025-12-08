import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';
import '../models/chat_session_model.dart';

// Chat controller manages chat messages and session state
class ChatController extends GetxController {
  // Observable properties for reactive UI updates
  final messages = <MessageModel>[].obs;
  final isTyping = false.obs;
  final showAttachmentMenu = false.obs;
  final messageInputController = TextEditingController();

  // Current chat session
  late ChatSessionModel currentSession;

  @override
  void onInit() {
    super.onInit();
    // Initialize chat session and messages
    _initializeChatSession();
    _initializeMessages();
  }

  @override
  void onClose() {
    // Clean up text controller
    messageInputController.dispose();
    super.onClose();
  }

  // Initialize current chat session with sample data
  void _initializeChatSession() {
    currentSession = ChatSessionModel(
      id: 1,
      doctorName: 'Dr. Sarah Johnson',
      doctorSpecialization: 'General Physician',
      doctorImageUrl:
          'https://images.unsplash.com/photo-1659353888906-adb3e0041693?w=400',
      doctorStatus: 'online',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastMessageAt: DateTime.now(),
      unreadCount: 0,
    );
  }

  // Initialize messages with sample data
  void _initializeMessages() {
    messages.value = [
      MessageModel(
        id: 1,
        text: "Hello! I'm Dr. Sarah Johnson. How can I help you today?",
        sender: 'doctor',
        timestamp: '10:30 AM',
        status: 'read',
        type: 'text',
      ),
      MessageModel(
        id: 2,
        text:
            "Hi Doctor, I've been experiencing headaches for the past few days.",
        sender: 'user',
        timestamp: '10:32 AM',
        status: 'read',
        type: 'text',
      ),
      MessageModel(
        id: 3,
        text:
            "I understand. Can you tell me more about these headaches? When do they usually occur?",
        sender: 'doctor',
        timestamp: '10:33 AM',
        status: 'read',
        type: 'text',
      ),
      MessageModel(
        id: 4,
        text:
            "They usually happen in the afternoon, and the pain is mostly on the right side of my head.",
        sender: 'user',
        timestamp: '10:35 AM',
        status: 'read',
        type: 'text',
      ),
      MessageModel(
        id: 5,
        text:
            "Thank you for sharing that. Are you experiencing any other symptoms like nausea, sensitivity to light, or vision changes?",
        sender: 'doctor',
        timestamp: '10:36 AM',
        status: 'read',
        type: 'text',
      ),
    ];
  }

  // Send a new message
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    try {
      // Create new message
      final newMessage = MessageModel(
        id: messages.length + 1,
        text: text.trim(),
        sender: 'user',
        timestamp: _getCurrentTime(),
        status: 'sent',
        type: 'text',
      );

      // Add message to list
      messages.add(newMessage);

      // Clear input
      messageInputController.clear();

      // Simulate message delivery after 1 second
      await Future.delayed(const Duration(seconds: 1));
      _updateMessageStatus(newMessage.id, 'delivered');

      // Simulate message read after 2 seconds
      await Future.delayed(const Duration(seconds: 1));
      _updateMessageStatus(newMessage.id, 'read');

      // Simulate doctor typing
      _simulateDoctorTyping();
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  // Update message status
  void _updateMessageStatus(int messageId, String newStatus) {
    final index = messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      messages[index] = messages[index].copyWith(status: newStatus);
    }
  }

  // Simulate doctor typing indicator
  void _simulateDoctorTyping() {
    isTyping.value = true;
    currentSession = currentSession.copyWith(doctorStatus: 'typing');

    // Simulate typing for 2-3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      isTyping.value = false;
      currentSession = currentSession.copyWith(doctorStatus: 'online');

      // Add a simulated doctor response
      final doctorResponse = MessageModel(
        id: messages.length + 1,
        text: _getSimulatedDoctorResponse(),
        sender: 'doctor',
        timestamp: _getCurrentTime(),
        status: 'read',
        type: 'text',
      );
      messages.add(doctorResponse);
    });
  }

  // Get simulated doctor response
  String _getSimulatedDoctorResponse() {
    final responses = [
      'I see. Let me check your medical history and get back to you shortly.',
      'That sounds concerning. I recommend scheduling an in-person appointment.',
      'Based on your symptoms, I would suggest taking some rest and staying hydrated.',
      'Have you tried any over-the-counter pain relievers?',
      'I would like to prescribe some medication for you. Let me send the details.',
    ];
    return responses[messages.length % responses.length];
  }

  // Get current time in HH:MM AM/PM format
  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  // Toggle attachment menu visibility
  void toggleAttachmentMenu() {
    showAttachmentMenu.toggle();
  }

  // Close attachment menu
  void closeAttachmentMenu() {
    showAttachmentMenu.value = false;
  }

  // Handle photo attachment
  Future<void> attachPhoto() async {
    try {
      closeAttachmentMenu();
      // TODO: Implement photo picker
      Get.snackbar('Photo', 'Photo attachment feature coming soon');
    } catch (e) {
      Get.snackbar('Error', 'Failed to attach photo: $e');
    }
  }

  // Handle document attachment
  Future<void> attachDocument() async {
    try {
      closeAttachmentMenu();
      // TODO: Implement document picker
      Get.snackbar('Document', 'Document attachment feature coming soon');
    } catch (e) {
      Get.snackbar('Error', 'Failed to attach document: $e');
    }
  }

  // Handle medical report attachment
  Future<void> attachMedicalReport() async {
    try {
      closeAttachmentMenu();
      // TODO: Implement medical report picker
      Get.snackbar(
          'Medical Report', 'Medical report attachment feature coming soon');
    } catch (e) {
      Get.snackbar('Error', 'Failed to attach medical report: $e');
    }
  }

  // Handle video call initiation
  Future<void> initiateVideoCall() async {
    try {
      // TODO: Implement video call
      Get.snackbar('Video Call',
          'Starting video call with ${currentSession.doctorName}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to start video call: $e');
    }
  }

  // Handle voice call initiation
  Future<void> initiateVoiceCall() async {
    try {
      // TODO: Implement voice call
      Get.snackbar('Voice Call',
          'Starting voice call with ${currentSession.doctorName}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to start voice call: $e');
    }
  }

  // Handle more options menu
  Future<void> showMoreOptions() async {
    try {
      // TODO: Implement more options menu
      Get.snackbar('More', 'More options menu coming soon');
    } catch (e) {
      Get.snackbar('Error', 'Failed to show options: $e');
    }
  }

  // Get all messages
  List<MessageModel> getAllMessages() {
    return messages;
  }

  // Get current chat session
  ChatSessionModel getSession() {
    return currentSession;
  }

  // Update doctor status
  void updateDoctorStatus(String status) {
    currentSession = currentSession.copyWith(doctorStatus: status);
  }

  // Mark all messages as read
  void markAllAsRead() {
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].sender == 'doctor' && messages[i].status != 'read') {
        messages[i] = messages[i].copyWith(status: 'read');
      }
    }
    currentSession = currentSession.copyWith(unreadCount: 0);
  }
}
