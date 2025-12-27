import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import 'package:pharma_connect/app/modules/auth/controllers/auth_controller.dart';
import 'package:pharma_connect/app/modules/auth/widgets/custom_text_field.dart';
import 'package:pharma_connect/app/modules/auth/widgets/language_selector.dart';
import 'package:pharma_connect/app/modules/auth/widgets/primary_button.dart';
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
    authController.registerCountryCodeController.text = 'eg';
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
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: LanguageSelector(),
            ),
          ),
        ],
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

                    // middle Name
                    CustomTextField(
                      label: getTranslation('auth.middle.name'),
                      hintText: getTranslation('auth.middle.name.hint'),
                      controller: authController.registerMiddleNameController,
                      validator: authController.validateMiddleName,
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

                    // National ID
                    CustomTextField(
                      label: getTranslation('auth.national.id'),
                      hintText: getTranslation('auth.national.id.hint'),
                      controller: authController.registerNationalIdController,
                      validator: authController.validateNationalId,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.badge_outlined),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Gender
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslation('auth.gender'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(child: _buildGenderOption('male')),
                              const SizedBox(width: AppSpacing.lg),
                              Expanded(child: _buildGenderOption('female')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Birth Date
                    CustomTextField(
                      label: getTranslation('auth.birth.date'),
                      hintText: getTranslation('auth.birth.date.hint'),
                      controller: authController.registerBirthDateController,
                      validator: authController.validateBirthDate,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Country Code
                    // CustomTextField(
                    //   label: getTranslation('auth.country.code'),
                    //   hintText: getTranslation('auth.country.code.hint'),
                    //   controller: authController.registerCountryCodeController,
                    //   validator: authController.validateCountryCode,
                    //   keyboardType: TextInputType.text,
                    //   prefixIcon: const Icon(Icons.public_outlined),
                    //   readOnly: true,
                    // ),
                    // const SizedBox(height: AppSpacing.lg),

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
                            activeColor: Theme.of(context).primaryColor,
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
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${getTranslation('auth.and')} ',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: getTranslation(
                                        'auth.privacy.policy',
                                      ),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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

  Widget _buildGenderOption(String gender) {
    final isSelected = authController.selectedGender.value == gender;
    final label = gender == 'male'
        ? getTranslation('auth.gender.male')
        : getTranslation('auth.gender.female');

    return GestureDetector(
      onTap: () {
        authController.selectedGender.value = gender;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Theme.of(context).primaryColor.withAlpha(26) : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      authController.registerBirthDate.value = picked;
      authController.registerBirthDateController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
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
