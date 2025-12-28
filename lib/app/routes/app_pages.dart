import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/auth/bindings/auth_binding.dart';
import 'package:pharma_connect/app/modules/auth/views/login_view.dart';
import 'package:pharma_connect/app/modules/auth/views/register_view.dart';
import 'package:pharma_connect/app/modules/chat/bindings/chat_binding.dart';
import 'package:pharma_connect/app/modules/chat/views/chat_view.dart';
import 'package:pharma_connect/app/modules/consultations/bindings/consultations_binding.dart';
import 'package:pharma_connect/app/modules/consultations/views/consultations_view.dart';
import 'package:pharma_connect/app/modules/doctor_detail/bindings/doctor_detail_binding.dart';
import 'package:pharma_connect/app/modules/doctor_detail/views/doctor_detail_view.dart';
import 'package:pharma_connect/app/modules/home/bindings/home_binding.dart';
import 'package:pharma_connect/app/modules/home/views/home_view.dart';
import 'package:pharma_connect/app/modules/medicines/bindings/medicines_binding.dart';
import 'package:pharma_connect/app/modules/medicines/views/medicines_view.dart';
import 'package:pharma_connect/app/modules/navigation/widgets/app_shell.dart';
import 'package:pharma_connect/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:pharma_connect/app/modules/notifications/views/notifications_view.dart';
import 'package:pharma_connect/app/modules/pharmacies/bindings/pharmacies_binding.dart';
import 'package:pharma_connect/app/modules/pharmacies/views/pharmacies_view.dart';
import 'package:pharma_connect/app/modules/pharmacy_detail/bindings/pharmacy_detail_binding.dart';
import 'package:pharma_connect/app/modules/pharmacy_detail/views/pharmacy_detail_view.dart';
import 'package:pharma_connect/app/modules/profile/bindings/profile_binding.dart';
import 'package:pharma_connect/app/modules/profile/views/profile_view.dart';
import 'package:pharma_connect/app/modules/pharmacy_request/bindings/pharmacy_request_binding.dart';
import 'package:pharma_connect/app/modules/pharmacy_request/views/pharmacy_request_view.dart';
import 'package:pharma_connect/app/modules/pharmacy_request/views/pharmacy_request_status_view.dart';
import 'package:pharma_connect/app/modules/pharmacy_request/controllers/pharmacy_request_status_controller.dart';
import 'package:pharma_connect/app/modules/doctor_request/bindings/doctor_request_binding.dart';
import 'package:pharma_connect/app/modules/doctor_request/views/doctor_request_view.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    // Auth Routes
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    // App Routes
    GetPage(
      name: AppRoutes.home,
      page: () => AppShell(child: const HomeView()),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.pharmacies,
      page: () => AppShell(child: const PharmaciesView()),
      binding: PharmaciesBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => AppShell(child: const ProfileView()),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.consultations,
      page: () => AppShell(child: const ConsultationsView()),
      binding: ConsultationsBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.medicines,
      page: () => AppShell(child: const MedicinesView()),
      binding: MedicinesBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => AppShell(child: const NotificationsView()),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: AppRoutes.pharmacyDetail,
      page: () => const PharmacyDetailView(),
      binding: PharmacyDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorDetail,
      page: () => const DoctorDetailView(),
      binding: DoctorDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.pharmacyRequest,
      page: () => const PharmacyRequestView(),
      binding: PharmacyRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.pharmacyRequestStatus,
      page: () => const PharmacyRequestStatusView(),
      // We don't need a separate binding if we put the controller in the view or reuse one,
      // but let's use a simple bind or BindingsBuilder
      binding: BindingsBuilder(() {
        Get.put(PharmacyRequestStatusController());
      }),
    ),
    GetPage(
      name: AppRoutes.doctorRequest,
      page: () => const DoctorRequestView(),
      binding: DoctorRequestBinding(),
    ),
  ];
}
