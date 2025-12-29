import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFAB extends StatelessWidget {
  final VoidCallback? onPressed;

  const UploadFAB({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed ?? (){_showUploadModal(context);},
      backgroundColor: const Color(0xFF00C897),
      elevation: 8,
      child: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
    );
  }

  void _showUploadModal(BuildContext context) {
    Get.bottomSheet(
      _buildUploadModal(context),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withAlpha(128),
    );
  }

  Widget _buildUploadModal(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // Title
          Text(
            'nav.upload_prescription'.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            'nav.upload_description'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 24),

          // Take Photo Option
          _buildUploadOption(
            context: context,
            icon: Icons.camera_alt,
            title: 'nav.take_photo'.tr,
            description: 'nav.use_camera'.tr,
            onTap: () {
              Get.back();
              // TODO: Implement camera functionality
            },
          ),
          const SizedBox(height: 12),

          // Choose from Gallery Option
          _buildUploadOption(
            context: context,
            icon: Icons.image,
            title: 'nav.choose_gallery'.tr,
            description: 'nav.select_photo'.tr,
            onTap: () {
              Get.back();
              // TODO: Implement gallery picker functionality
            },
          ),
          const SizedBox(height: 24),

          // Cancel Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('nav.cancel'.tr),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
