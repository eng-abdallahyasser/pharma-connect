import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pharma_connect/app/locales/translations.dart';
import 'package:pharma_connect/app/modules/auth/controllers/auth_controller.dart';
import 'package:pharma_connect/app/modules/auth/widgets/auth_divider.dart';
import 'package:pharma_connect/app/modules/auth/widgets/custom_text_field.dart';
import 'package:pharma_connect/app/modules/auth/widgets/primary_button.dart';
import 'package:pharma_connect/app/modules/auth/widgets/social_login_button.dart';
import 'package:pharma_connect/app/theme/app_colors.dart';
import 'package:pharma_connect/app/theme/app_spacing.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),
              // Header
              Text(
                getTranslation('auth.login.title'),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                getTranslation('auth.login.subtitle'),
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
                key: authController.loginFormKey,
                child: Column(
                  children: [
                    // Email Field
                    CustomTextField(
                      label: getTranslation('auth.email'),
                      hintText: getTranslation('auth.email.hint'),
                      controller: authController.loginEmailController,
                      validator: authController.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Password Field
                    Obx(
                      () => CustomTextField(
                        label: getTranslation('auth.password'),
                        hintText: getTranslation('auth.password.hint'),
                        controller: authController.loginPasswordController,
                        validator: authController.validatePassword,
                        obscureText:
                            !authController.isLoginPasswordVisible.value,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            authController.isLoginPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed:
                              authController.toggleLoginPasswordVisibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Forgot Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/forgot-password');
                        },
                        child: Text(
                          getTranslation('auth.forgot.password'),
                          style: TextStyle(
                            color: Color(AppColors.primary),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Login Button
                    Obx(
                      () => PrimaryButton(
                        text: getTranslation('auth.login.button'),
                        isLoading: authController.isLoading.value,
                        onPressed: () => authController.login(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Divider
              AuthDivider(text: getTranslation('auth.or')),

              const SizedBox(height: AppSpacing.lg),

              // Social Login
              Row(
                children: [
                  SocialLoginButton(
                    icon: FontAwesomeIcons.facebook, // Facebook Icon
                    label: 'Facebook',
                    onPressed: () {},
                  ),
                  const SizedBox(width: AppSpacing.md),
                  SocialLoginButton(
                    icon: FontAwesomeIcons.google, // Google Icon
                    label: 'Google',
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getTranslation('auth.no.account'),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      authController.clearForm('login');
                      Get.toNamed('/register');
                    },
                    child: Text(
                      getTranslation('auth.register.now'),
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
      ),
    );
  }
}
