import 'package:flutter/material.dart';

// Action buttons widget for chat, call, and booking
class ActionButtons extends StatelessWidget {
  final bool isOnline;
  final bool isLoading;
  final VoidCallback onChat;
  final VoidCallback onCall;
  final VoidCallback onRate;
  final VoidCallback onBook;

  const ActionButtons({
    super.key,
    required this.isOnline,
    required this.isLoading,
    required this.onChat,
    required this.onCall,
    required this.onRate,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Chat button
          _buildActionButton(
            context,
            icon: Icons.chat_bubble_outline,
            label: 'Chat',
            isEnabled: isOnline,
            onPressed: onChat,
            isPrimary: false,
          ),

          const SizedBox(width: 10),

          // Rate button
          _buildActionButton(
            context,
            icon: Icons.star_outline,
            label: 'Rate',
            isEnabled: true, // Always allow rating
            onPressed: onRate,
            isPrimary: false,
          ),

          const SizedBox(width: 10),

          // Book button
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : onBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  disabledBackgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.6),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'consultation',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isEnabled,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return Expanded(
      child: SizedBox(
        height: 52,
        child: OutlinedButton(
          onPressed: isEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: isEnabled
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[400],
            side: BorderSide(
              color: isEnabled
                  ? Theme.of(context).colorScheme.outline
                  : Colors.grey[300]!,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isEnabled
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[400],
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isEnabled
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
