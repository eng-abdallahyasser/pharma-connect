import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/auth/services/auth_service.dart';
import '../utils/validators.dart';

class AuthController extends GetxController {
  late AuthService authService;

  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Controllers for login
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Controllers for registration
  final registerFirstNameController = TextEditingController();
  final registerLastNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  // Observable states
  final isLoginPasswordVisible = false.obs;
  final isRegisterPasswordVisible = false.obs;
  final isRegisterConfirmPasswordVisible = false.obs;
  final isTermsAccepted = false.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final successMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    authService = Get.find<AuthService>();
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerFirstNameController.dispose();
    registerLastNameController.dispose();
    registerEmailController.dispose();
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }

  // ==================== Login Methods ====================

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final success = await authService.login(
        loginEmailController.text.trim(),
        loginPasswordController.text,
      );

      if (success) {
        successMessage.value = 'login.success';
        await Future.delayed(const Duration(milliseconds: 1000));
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = 'login.error';
      }
    } catch (e) {
      errorMessage.value = 'login.error';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleLoginPasswordVisibility() {
    isLoginPasswordVisible.value = !isLoginPasswordVisible.value;
  }

  // ==================== Registration Methods ====================

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    if (!isTermsAccepted.value) {
      errorMessage.value = 'registration.terms_required';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final success = await authService.register(
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
        firstName: registerFirstNameController.text.trim(),
        lastName: registerLastNameController.text.trim(),
        phoneNumber: registerPhoneController.text.trim(),
      );

      if (success) {
        successMessage.value = 'registration.success';
        await Future.delayed(const Duration(milliseconds: 1000));
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = 'registration.error';
      }
    } catch (e) {
      errorMessage.value = 'registration.error';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleRegisterPasswordVisibility() {
    isRegisterPasswordVisible.value = !isRegisterPasswordVisible.value;
  }

  void toggleRegisterConfirmPasswordVisibility() {
    isRegisterConfirmPasswordVisible.value =
        !isRegisterConfirmPasswordVisible.value;
  }

  void toggleTermsAcceptance() {
    isTermsAccepted.value = !isTermsAccepted.value;
  }

  void clearErrors() {
    errorMessage.value = '';
    successMessage.value = '';
  }

  void clearForm(String type) {
    if (type == 'login') {
      loginFormKey.currentState?.reset();
      loginEmailController.clear();
      loginPasswordController.clear();
      isLoginPasswordVisible.value = false;
    } else if (type == 'register') {
      registerFormKey.currentState?.reset();
      registerFirstNameController.clear();
      registerLastNameController.clear();
      registerEmailController.clear();
      registerPhoneController.clear();
      registerPasswordController.clear();
      registerConfirmPasswordController.clear();
      isRegisterPasswordVisible.value = false;
      isRegisterConfirmPasswordVisible.value = false;
      isTermsAccepted.value = false;
    }
  }

  // Validators
  String? validateEmail(String? value) => AuthValidators.validateEmail(value);
  String? validatePassword(String? value) =>
      AuthValidators.validatePassword(value);
  String? validateConfirmPassword(String? value) =>
      AuthValidators.validateConfirmPassword(
        value,
        registerPasswordController.text,
      );
  String? validatePhoneNumber(String? value) =>
      AuthValidators.validatePhoneNumber(value);
  String? validateFirstName(String? value) =>
      AuthValidators.validateFirstName(value);
  String? validateLastName(String? value) =>
      AuthValidators.validateLastName(value);
}
