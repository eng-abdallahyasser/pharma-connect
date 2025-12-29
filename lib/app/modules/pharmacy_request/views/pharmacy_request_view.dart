import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/models/pharmacy_request_model.dart';

import '../controllers/pharmacy_request_controller.dart';

class PharmacyRequestView extends GetView<PharmacyRequestController> {
  const PharmacyRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('New Request'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Space for bottom button
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypeSelector(theme),
            const SizedBox(height: 24),
            _buildPrescriptionSection(theme),
            const SizedBox(height: 24),
            _buildItemsSelectionSection(theme),
            const SizedBox(height: 24),
            _buildManualItemsSection(theme),
            const SizedBox(height: 24),
            _buildNotesSection(theme),
            const SizedBox(height: 24),
            _buildBottomBar(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Request Type',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: _buildTypeCard(
                    theme,
                    ServiceRequestType.PICKUP_ORDER,
                    Icons.storefront_outlined,
                    'Pickup',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTypeCard(
                    theme,
                    ServiceRequestType.DELEVARY_ORDER,
                    Icons.delivery_dining_outlined,
                    'Delivery',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTypeCard(
                    theme,
                    ServiceRequestType.HOME_VISIT,
                    Icons.medical_services_outlined,
                    'Home Visit',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(
    ThemeData theme,
    ServiceRequestType type,
    IconData icon,
    String label,
  ) {
    final isSelected = controller.selectedRequestType.value == type;
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => controller.setRequestType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : theme.dividerColor,
            width: isSelected ? 0 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withAlpha(84),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prescription / Photos',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Upload clear photos of your prescription or medicine',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildAddPhotoButton(theme),
                Obx(
                  () => Row(
                    children: controller.prescriptionImages
                        .asMap()
                        .entries
                        .map(
                          (entry) => _buildPhotoItem(
                            theme,
                            entry.key,
                            entry.value.path,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton(ThemeData theme) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.dividerColor,
            style: BorderStyle.none,
          ),
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: theme.primaryColor,
            strokeWidth: 1.5,
            gap: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo_outlined,
                color: theme.primaryColor,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                'Add Photo',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoItem(ThemeData theme, int index, String path) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: FileImage(File(path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 16,
          child: GestureDetector(
            onTap: () => controller.removeImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemsSelectionSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Medicines',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildSearchField(theme),
          _buildSearchResults(theme),
          const SizedBox(height: 12),
          _buildSelectedItemsList(theme),
        ],
      ),
    );
  }

  Widget _buildSearchField(ThemeData theme) {
    return TextField(
      onChanged: controller.searchItems,
      decoration: InputDecoration(
        hintText: 'Search for medicines...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: Obx(
          () => controller.isSearching.value
              ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : const SizedBox(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: theme.cardTheme.color,
      ),
    );
  }

  Widget _buildSearchResults(ThemeData theme) {
    return Obx(() {
      if (controller.searchResults.isEmpty) return const SizedBox();
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: controller.searchResults.map((item) {
            return ListTile(
              title: Text(item.name),
              subtitle: item.description != null
                  ? Text(item.description!)
                  : null,
              trailing: const Icon(Icons.add_circle_outline),
              onTap: () => controller.addSelectedItem(item),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildSelectedItemsList(ThemeData theme) {
    return Obx(() {
      if (controller.selectedItems.isEmpty) return const SizedBox();
      return Column(
        children: controller.selectedItems.asMap().entries.map((entry) {
          final index = entry.key;
          final selectedItem = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedItem.item.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      _buildIconBtn(
                        Icons.remove,
                        () => controller.decrementSelectedItemQuantity(index),
                        theme,
                      ),
                      Text(
                        '${selectedItem.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildIconBtn(
                        Icons.add,
                        () => controller.incrementSelectedItemQuantity(index),
                        theme,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => controller.removeSelectedItem(index),
                  icon: const Icon(Icons.close, color: Colors.red),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildManualItemsSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manual Items',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: controller.addManualItem,
                icon: const Icon(Icons.add_circle_outline, size: 18),
                label: const Text('Add Item'),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Add medicines manually if you don\'t have a photo',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (controller.manualInputs.isEmpty) {
              return _buildEmptyState(theme);
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.manualInputs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final input = controller.manualInputs[index];
                return _buildManualItemRow(theme, index, input);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withAlpha(128)),
      ),
      child: Column(
        children: [
          Icon(Icons.medication_outlined, size: 48, color: theme.disabledColor),
          const SizedBox(height: 12),
          Text(
            'No items added yet',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
          TextButton(
            onPressed: controller.addManualItem,
            child: const Text('Add First Item'),
          ),
        ],
      ),
    );
  }

  Widget _buildManualItemRow(ThemeData theme, int index, ManualInput input) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: input.nameController,
              decoration: InputDecoration(
                hintText: 'Medicine Name (e.g. Panadol)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.scaffoldBackgroundColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _buildIconBtn(
                  Icons.remove,
                  () => controller.decrementQuantity(index),
                  theme,
                ),
                Obx(
                  () => SizedBox(
                    width: 30,
                    child: Text(
                      '${input.quantity.value}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                _buildIconBtn(
                  Icons.add,
                  () => controller.incrementQuantity(index),
                  theme,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => controller.removeManualItem(index),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, VoidCallback onPressed, ThemeData theme) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 16, color: theme.primaryColor),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
      splashRadius: 20,
    );
  }

  Widget _buildNotesSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.notesController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Add any special instructions here...',
              fillColor: theme.cardTheme.color,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ThemeData theme) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.submitRequest,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    'Submit Request',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(16),
        ),
      );

    final Path dashedPath = _dashPath(path, dashWidth: 8, dashSpace: gap);
    canvas.drawPath(dashedPath, paint);
  }

  Path _dashPath(
    Path source, {
    required double dashWidth,
    required double dashSpace,
  }) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        dest.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
