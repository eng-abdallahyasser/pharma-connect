import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/address_controller.dart';

class AddressesBottomSheet extends GetView<AddressController> {
  const AddressesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'address.saved_addresses'.tr,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.addresses.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_off,
                        size: 48,
                        color: Theme.of(context).disabledColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'address.no_saved'.tr,
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: controller.addresses.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final address = controller.addresses[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: address.isSelected
                          ? Theme.of(context).primaryColor.withAlpha(26)
                          : Theme.of(context).dividerColor.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: address.isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hintColor,
                    ),
                  ),
                  title: Text(
                    address.label,
                    style: TextStyle(
                      fontWeight: address.isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(address.fullAddress),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (address.isSelected)
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).primaryColor,
                        ),
                      IconButton(
                        onPressed: () => controller.deleteAddress(address),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => controller.selectAddress(address),
                );
              },
            );
          }),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => controller.showAddAddressScreen(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                Icons.add_location_alt,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              label: Text(
                'address.add_new'.tr,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
