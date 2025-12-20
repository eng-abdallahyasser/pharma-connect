import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/address_model.dart';
import 'package:pharma_connect/app/core/services/storage_service.dart';
import '../widgets/address_map_picker.dart';

class AddressController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadAddresses();
  }

  void _loadAddresses() {
    List<dynamic>? storedData = _storageService.getAddresses();
    if (storedData != null) {
      addresses.value = storedData
          .map((e) => AddressModel.fromJson(e))
          .toList();
      selectedAddress.value = addresses.firstWhereOrNull(
        (element) => element.isSelected,
      );
    }
  }

  Future<void> showAddAddressScreen() async {
    // Check permissions
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        Position position = await Geolocator.getCurrentPosition();
        if (Get.isDialogOpen ?? false) Get.back();

        final labelController = TextEditingController();
        final detailsController = TextEditingController();
        LatLng currentLatLng = LatLng(position.latitude, position.longitude);

        Get.dialog(
          Dialog(
            insetPadding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: Get.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: AddressMapPicker(
                        initialPosition: currentLatLng,
                        onPositionChanged: (pos) {
                          currentLatLng = pos;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: labelController,
                          decoration: InputDecoration(
                            labelText: 'address.label'.tr,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.label),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: detailsController,
                          decoration: InputDecoration(
                            labelText: 'address.details'.tr,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (labelController.text.isEmpty) {
                                Get.snackbar('Error', 'address.enter_label'.tr);
                                return;
                              }
                              if (detailsController.text.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'address.enter_details'.tr,
                                );
                                return;
                              }
                              _addNewAddress(
                                labelController.text,
                                detailsController.text,
                                currentLatLng,
                              );
                              Get.back(); // Close dialog
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A73E8),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'address.save_btn'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } catch (e) {
        if (Get.isDialogOpen ?? false) Get.back();
        Get.snackbar("Error", "Failed to get location: $e");
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      Get.snackbar("Permission Required", 'address.permission_required'.tr);
    }
  }

  Future<void> _addNewAddress(
    String label,
    String details,
    LatLng position,
  ) async {
    final newAddress = AddressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: label,
      fullAddress: details,
      latitude: position.latitude,
      longitude: position.longitude,
      isSelected: addresses.isEmpty,
    );

    if (addresses.isEmpty) {
      selectedAddress.value = newAddress;
    }

    addresses.add(newAddress);
    await _saveAddresses();
    Get.snackbar("Success", 'address.success_add'.tr);
  }

  void selectAddress(AddressModel address) {
    var newAddresses = <AddressModel>[];
    AddressModel? newSelected;

    for (var addr in addresses) {
      if (addr.id == address.id) {
        var updated = addr.copyWith(isSelected: true);
        newAddresses.add(updated);
        newSelected = updated;
      } else {
        newAddresses.add(addr.copyWith(isSelected: false));
      }
    }

    addresses.value = newAddresses;
    selectedAddress.value = newSelected;
    _saveAddresses();
    Get.back(); // Close bottom sheet
  }

  Future<void> _saveAddresses() async {
    await _storageService.saveAddresses(
      addresses.map((e) => e.toJson()).toList(),
    );
  }
}
