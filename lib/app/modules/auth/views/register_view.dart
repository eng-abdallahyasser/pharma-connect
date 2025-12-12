import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import 'package:pharma_connect/app/modules/auth/controllers/auth_controller.dart';
import 'package:pharma_connect/app/modules/auth/widgets/custom_text_field.dart';
import 'package:pharma_connect/app/modules/auth/widgets/primary_button.dart';
import 'package:pharma_connect/app/theme/app_colors.dart';
import 'package:pharma_connect/app/theme/app_spacing.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslation('auth.register.title')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslation('auth.register.subtitle'),
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Error Message
              Obx(
                () => authController.errorMessage.value.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          border: Border.all(color: Colors.red[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          getTranslation(authController.errorMessage.value),
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 14,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (authController.errorMessage.value.isNotEmpty)
                const SizedBox(height: AppSpacing.md),

              // Form
              Form(
                key: authController.registerFormKey,
                child: Column(
                  children: [
                    // First Name
                    CustomTextField(
                      label: getTranslation('auth.first.name'),
                      hintText: getTranslation('auth.first.name.hint'),
                      controller: authController.registerFirstNameController,
                      validator: authController.validateFirstName,
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Last Name
                    CustomTextField(
                      label: getTranslation('auth.last.name'),
                      hintText: getTranslation('auth.last.name.hint'),
                      controller: authController.registerLastNameController,
                      validator: authController.validateLastName,
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Email
                    CustomTextField(
                      label: getTranslation('auth.email'),
                      hintText: getTranslation('auth.email.hint'),
                      controller: authController.registerEmailController,
                      validator: authController.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Phone Number
                    CustomTextField(
                      label: getTranslation('auth.phone'),
                      hintText: getTranslation('auth.phone.hint'),
                      controller: authController.registerPhoneController,
                      validator: authController.validatePhoneNumber,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Password
                    Obx(
                      () => CustomTextField(
                        label: getTranslation('auth.password'),
                        hintText: getTranslation('auth.password.hint'),
                        controller: authController.registerPasswordController,
                        validator: authController.validatePassword,
                        obscureText:
                            !authController.isRegisterPasswordVisible.value,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            authController.isRegisterPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed:
                              authController.toggleRegisterPasswordVisibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _buildPasswordRequirements(context),
                    const SizedBox(height: AppSpacing.lg),

                    // Confirm Password
                    Obx(
                      () => CustomTextField(
                        label: getTranslation('auth.confirm.password'),
                        hintText: getTranslation('auth.confirm.password.hint'),
                        controller:
                            authController.registerConfirmPasswordController,
                        validator: authController.validateConfirmPassword,
                        obscureText: !authController
                            .isRegisterConfirmPasswordVisible
                            .value,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            authController
                                    .isRegisterConfirmPasswordVisible
                                    .value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: authController
                              .toggleRegisterConfirmPasswordVisibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Terms and Conditions
                    Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: authController.isTermsAccepted.value,
                            onChanged: (value) {
                              authController.toggleTermsAcceptance();
                            },
                            activeColor: Color(AppColors.primary),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: AppSpacing.sm,
                                right: AppSpacing.sm,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: '${getTranslation('auth.i.agree')} ',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: getTranslation(
                                        'auth.terms.conditions',
                                      ),
                                      style: TextStyle(
                                        color: Color(AppColors.primary),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ' +
                                          getTranslation('auth.and') +
                                          ' ',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: getTranslation(
                                        'auth.privacy.policy',
                                      ),
                                      style: TextStyle(
                                        color: Color(AppColors.primary),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Register Button
                    Obx(
                      () => PrimaryButton(
                        text: getTranslation('auth.register.button'),
                        isLoading: authController.isLoading.value,
                        onPressed: () => authController.register(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getTranslation('auth.have.account'),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            authController.clearForm('register');
                            Get.back();
                          },
                          child: Text(
                            getTranslation('auth.login.now'),
                            style: TextStyle(
                              color: Color(AppColors.primary),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements(BuildContext context) {
    final password = authController.registerPasswordController.text;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslation('auth.password.requirements'),
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRequirementRow(
            getTranslation('auth.password.min.length'),
            password.length >= 8,
          ),
          _buildRequirementRow(
            getTranslation('auth.password.uppercase'),
            password.contains(RegExp(r'[A-Z]')),
          ),
          _buildRequirementRow(
            getTranslation('auth.password.digit'),
            password.contains(RegExp(r'[0-9]')),
          ),
          _buildRequirementRow(
            getTranslation('auth.password.special.char'),
            password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isMet ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
