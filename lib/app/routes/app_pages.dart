import 'package:get/get.dart';
import 'package:pharma_connect/app/modules/home/bindings/home_binding.dart';
import 'package:pharma_connect/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // Add more pages here
  ];
}
