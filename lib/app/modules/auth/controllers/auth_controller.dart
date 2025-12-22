import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/auth/models/login_response.dart';
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
  final registerMiddleNameController = TextEditingController();
  final registerLastNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final registerNationalIdController = TextEditingController();
  final registerBirthDateController = TextEditingController();
  final registerCountryCodeController = TextEditingController();

  // Observable states
  final isLoginPasswordVisible = false.obs;
  final isRegisterPasswordVisible = false.obs;
  final isRegisterConfirmPasswordVisible = false.obs;
  final isTermsAccepted = false.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final successMessage = ''.obs;
  final selectedGender = Rx<String?>(null);
  final registerBirthDate = Rx<DateTime?>(null);

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
    registerNationalIdController.dispose();
    registerBirthDateController.dispose();
    registerCountryCodeController.dispose();
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
      final LoginResponse response = await authService.login(
        loginEmailController.text.trim(),
        loginPasswordController.text,
      );

      if (response.user != null) {
        successMessage.value = 'login.success';

        Get.offAllNamed('/home');
      } else {
        if (response.message != null) {
          log("Login Error Auth Controller: ${response.message}");
          errorMessage.value = response.message!;
        } else {
          errorMessage.value = 'login.error';
        }
      }
    } catch (e) {
      log("Login Error Auth Controller: ${e.toString()}");
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
      final response = await authService.register(
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
        firstName: registerFirstNameController.text.trim(),
        middleName: registerMiddleNameController.text.trim(),
        lastName: registerLastNameController.text.trim(),
        phoneNumber: registerPhoneController.text.trim(),
        nationalId: registerNationalIdController.text.trim(),
        gender: selectedGender.value ?? '',
        birthDate: registerBirthDateController.text.trim(),
        countryCode: registerCountryCodeController.text.trim(),
      );

      if (response != null) {
        if (response.user != null) {
          successMessage.value = 'registration.success';
          // registion is success then login

          final response = await authService.login(
            loginEmailController.text.trim(),
            loginPasswordController.text,
          );

          if (response.user != null) {
            successMessage.value = 'login.success';

            Get.offAllNamed('/home');
          } else {
            errorMessage.value = 'login.error';
          }
        } else {
          String errorMessage = '';
          for (var error in response.errors ?? []) {
            errorMessage += "${error.property} : ${error.message}\n";
          }
          this.errorMessage.value = errorMessage;
        }
      } else {
        errorMessage.value = 'registration.error';
      }
    } catch (e) {
      log("Registration Error: ${e.toString()}");
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
      clearErrors();
      loginFormKey.currentState?.reset();
      loginEmailController.clear();
      loginPasswordController.clear();
      isLoginPasswordVisible.value = false;
    } else if (type == 'register') {
      clearErrors();
      registerFormKey.currentState?.reset();
      registerFirstNameController.clear();
      registerLastNameController.clear();
      registerEmailController.clear();
      registerPhoneController.clear();
      registerPasswordController.clear();
      registerConfirmPasswordController.clear();
      registerNationalIdController.clear();
      registerBirthDateController.clear();
      registerCountryCodeController.clear();
      isRegisterPasswordVisible.value = false;
      isRegisterConfirmPasswordVisible.value = false;
      isTermsAccepted.value = false;
      selectedGender.value = null;
      registerBirthDate.value = null;
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
  String? validateMiddleName(String? value) =>
      AuthValidators.validateMiddleName(value);
  String? validateLastName(String? value) =>
      AuthValidators.validateLastName(value);
  String? validateNationalId(String? value) =>
      AuthValidators.validateNationalId(value);
  String? validateBirthDate(String? value) =>
      AuthValidators.validateBirthDate(value);
  String? validateGender(String? value) => AuthValidators.validateGender(value);
  String? validateCountryCode(String? value) =>
      AuthValidators.validateCountryCode(value);
}
