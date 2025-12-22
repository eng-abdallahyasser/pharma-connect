import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pharmacies_controller.dart';
import '../widgets/pharmacy_map_view.dart';
import '../../home/widgets/pharmacy_card.dart';

class PharmaciesView extends GetView<PharmaciesController> {
  const PharmaciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Blue Background
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1A73E8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),

                  // Title
                  Text(
                    'pharmacies.title'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: controller.updateSearchQuery,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).colorScheme.surface,
                              hintStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),

                              hintText: 'pharmacies.search_placeholder'.tr,
                              border: InputBorder.none,
                              enabledBorder:
                                  InputBorder.none, // For enabled state
                              focusedBorder:
                                  InputBorder.none, // For focused state
                              disabledBorder:
                                  InputBorder.none, // For disabled state
                              errorBorder: InputBorder.none, // For error state
                              focusedErrorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Filters & View Toggle
                  Row(
                    children: [
                      // Filter Button
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(52),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.tune, color: Colors.white, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'pharmacies.filters'.tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // View Mode Toggle
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(52),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            // List View Button
                            Obx(
                              () => GestureDetector(
                                onTap: () => controller.setViewMode('list'),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: controller.viewMode.value == 'list'
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.list,
                                    color: controller.viewMode.value == 'list'
                                        ? const Color(0xFF1A73E8)
                                        : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            // Map View Button
                            Obx(
                              () => GestureDetector(
                                onTap: () => controller.setViewMode('map'),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: controller.viewMode.value == 'map'
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.map,
                                    color: controller.viewMode.value == 'map'
                                        ? const Color(0xFF1A73E8)
                                        : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content Area
            Obx(
              () => controller.viewMode.value == 'list'
                  ? _buildListView(context)
                  : _buildMapView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Active Filters
          Obx(
            () => controller.filters.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.filters.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => controller.toggleFilter(filter.id),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: filter.isActive
                                    ? const Color(0xFF1A73E8).withAlpha(26)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: filter.isActive
                                      ? const Color(0xFF1A73E8)
                                      : Colors.transparent,
                                ),
                              ),
                              child: Text(
                                filter.label,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: filter.isActive
                                      ? const Color(0xFF1A73E8)
                                      : Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 12),

          // Results Count
          Obx(() {
            final filtered = controller.pharmacies;
            return Text(
              'pharmacies.found_count'.trParams({
                'count': '${filtered.length}',
              }),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            );
          }),
          const SizedBox(height: 16),

          // Pharmacy List
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final filtered = controller.getFilteredPharmacies();
            if (filtered.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'pharmacies.no_pharmacies_found'.tr,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: filtered.map((pharmacy) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PharmacyCard(
                    pharmacy: pharmacy,
                    onSelect: () => controller.onPharmacySelect(pharmacy),
                    onOrder: () {},
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMapView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 280,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: PharmacyMapView(
          pharmacies: controller.pharmacies,
          pharmacyLocations: controller.pharmacyLocations,
          userLocation: controller.userLocation,
          savedAddresses: controller.savedAddressesList,
          onSelectPharmacy: (pharmacy) {
            controller.selectPharmacy(pharmacy.id);
          },
        ),
      ),
    );
  }
}
