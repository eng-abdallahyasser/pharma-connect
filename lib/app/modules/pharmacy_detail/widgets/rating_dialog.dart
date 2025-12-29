import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingDialog extends StatefulWidget {
  final Function(double rating, String? notes) onSubmit;
  final String title;

  const RatingDialog({
    super.key,
    required this.onSubmit,
    this.title = 'Rate Pharmacy',
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 0;
  final TextEditingController _notesController = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_rating == 0) {
      Get.snackbar(
        'Error',
        'Please select a rating',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_rating < 5 && _notesController.text.trim().isEmpty) {
      setState(() {
        _showError = true;
      });
      return;
    }

    widget.onSubmit(_rating, _notesController.text.trim());
    Get.back(); // Close dialog
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'How was your experience?',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 20),

            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1.0;
                      // Clear error if rating is 5
                      if (_rating == 5 && _showError) {
                        _showError = false;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFFFFB800),
                      size: 36,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Notes Field
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                hintText: 'Add a note (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1A73E8)),
                ),
                errorText: _showError
                    ? 'Notes are required for ratings under 5'
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              maxLines: 3,
              onChanged: (value) {
                if (_showError && value.isNotEmpty) {
                  setState(() {
                    _showError = false;
                  });
                }
              },
            ),

            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: const Color(0xFF1A73E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
