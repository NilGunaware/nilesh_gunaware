import 'package:get/get.dart';
import 'pages/bspok_home_page.dart';
import 'pages/bspok_login_page.dart';
import 'pages/bspok_cart_page.dart';
import 'bspok_bindings.dart';

class BSpokRoutes {
  static final routes = [
    GetPage(
      name: '/bspok/home',
      page: () => const BSpokHomePage(),
      binding: BSpokBindings(),
    ),
    GetPage(
      name: '/bspok/login',
      page: () => const BSpokLoginPage(),
      binding: BSpokBindings(),
    ),
    GetPage(
      name: '/bspok/cart',
      page: () => const BSpokCartPage(),
    ),
  ];
} 