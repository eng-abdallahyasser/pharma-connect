part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const INITIAL = _Paths.HOME;
  static const HOME = _Paths.HOME;

  // Add more routes here
  // static const PRODUCT = _Paths.PRODUCT;
  // static const CART = _Paths.CART;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';

  // Add more paths here
  // static const PRODUCT = '/product';
  // static const CART = '/cart';
}
