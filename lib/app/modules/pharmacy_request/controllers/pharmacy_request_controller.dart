import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_connect/app/core/network/api_exceptions.dart';
import '../data/models/pharmacy_request_model.dart';
import '../data/models/item_model.dart';
import '../data/providers/pharmacy_request_repository.dart';
import '../data/providers/item_repository.dart';
import 'package:pharma_connect/app/modules/pharmacy_detail/models/pharmacy_detail_model.dart';
import 'package:pharma_connect/app/routes/app_routes.dart';
import 'dart:async';

class ManualInput {
  final TextEditingController nameController = TextEditingController();
  final RxInt quantity = 1.obs;

  void dispose() {
    nameController.dispose();
  }
}

class PharmacyRequestController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final PharmacyRequestRepository _repository = PharmacyRequestRepository();
  final ItemRepository _itemRepository = ItemRepository();

  // Form State
  final selectedRequestType = ServiceRequestType.PICKUP_ORDER.obs;
  final prescriptionImages = <XFile>[].obs;
  final manualInputs = <ManualInput>[].obs;
  final selectedItems = <SelectedItem>[].obs;
  final searchResults = <Item>[].obs;
  final isSearching = false.obs;
  final notesController = TextEditingController();
  final isLoading = false.obs;
  Timer? _debounce;

  // Arguments
  late final PharmacyDetailModel? pharmacy;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is PharmacyDetailModel) {
      pharmacy = Get.arguments as PharmacyDetailModel;
    } else {
      pharmacy = null;
    }
  }

  @override
  void onClose() {
    notesController.dispose();
    for (var input in manualInputs) {
      input.dispose();
    }
    _debounce?.cancel();
    super.onClose();
  }

  void setRequestType(ServiceRequestType type) {
    selectedRequestType.value = type;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final List<XFile> images;
      if (source == ImageSource.camera) {
        final image = await _picker.pickImage(source: source);
        images = image != null ? [image] : [];
      } else {
        images = await _picker.pickMultiImage();
      }

      if (images.isNotEmpty) {
        prescriptionImages.addAll(images);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void removeImage(int index) {
    prescriptionImages.removeAt(index);
  }

  void addManualItem() {
    manualInputs.add(ManualInput());
  }

  void removeManualItem(int index) {
    final item = manualInputs[index];
    manualInputs.removeAt(index);
    item.dispose();
  }

  void incrementQuantity(int index) {
    manualInputs[index].quantity.value++;
  }

  void decrementQuantity(int index) {
    if (manualInputs[index].quantity.value > 1) {
      manualInputs[index].quantity.value--;
    }
  }

  void searchItems(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        searchResults.clear();
        return;
      }
      isSearching.value = true;
      try {
        final results = await _itemRepository.searchItems(query);
        searchResults.assignAll(results);
      } finally {
        isSearching.value = false;
      }
    });
  }

  void addSelectedItem(Item item) {
    // Check if already exists
    final index = selectedItems.indexWhere(
      (element) => element.item.id == item.id,
    );
    if (index >= 0) {
      selectedItems[index].quantity++;
      selectedItems.refresh();
    } else {
      selectedItems.add(SelectedItem(item: item));
    }
    // Clear search
    searchResults.clear();
  }

  void removeSelectedItem(int index) {
    selectedItems.removeAt(index);
  }

  void incrementSelectedItemQuantity(int index) {
    selectedItems[index].quantity++;
    selectedItems.refresh();
  }

  void decrementSelectedItemQuantity(int index) {
    if (selectedItems[index].quantity > 1) {
      selectedItems[index].quantity--;
      selectedItems.refresh();
    }
  }

  Future<void> submitRequest() async {
    if (isLoading.value) return;

    if (pharmacy == null) {
      Get.snackbar('Error', 'Pharmacy information invalid');
      return;
    }

    // Validation
    if (prescriptionImages.isEmpty &&
        manualInputs.isEmpty &&
        selectedItems.isEmpty) {
      Get.snackbar('Error', 'Please add prescription images or medicines');
      return;
    }

    bool hasEmptyItems = manualInputs.any(
      (item) => item.nameController.text.trim().isEmpty,
    );
    if (hasEmptyItems) {
      Get.snackbar('Error', 'Please fill in medicine names for all items');
      return;
    }

    isLoading.value = true;
    try {
      final items = manualInputs
          .map(
            (input) => ManualItem(
              medicineName: input.nameController.text.trim(),
              quantity: input.quantity.value,
            ),
          )
          .toList();

      final response = await _repository.createRequest(
        pharmacy!.id,
        selectedRequestType.value,
        notesController.text.trim().isNotEmpty
            ? notesController.text.trim()
            : null,
        items,
        selectedItems,
        prescriptionImages,
      );

      // Navigate to status/monitoring page and remove all previous request related pages
      // So back button goes to home or pharmacy list
      Get.offNamed(AppRoutes.pharmacyRequestStatus, arguments: response);

      Get.snackbar('Success', 'Request submitted successfully');
    } catch (e) {
      if(e is ApiException){
        log(name: 'submitRequest', e.response.toString());
      }
      Get.snackbar('Error', 'Failed to submit request: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
