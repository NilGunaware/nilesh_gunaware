import 'package:get/get.dart';
import '../views/login_page.dart';
import '../views/signup_page.dart';
import '../views/home_page.dart';
import '../views/forgot_password_page.dart';
import '../B-spok/bspok_routes.dart';
import '../B-spok/pages/bspok_home_page.dart';
import '../B-spok/bspok_bindings.dart';

class Routes {
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const BSPOK = '/bspok';
}

class AppRoutes {
  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.SIGNUP, page: () => SignupPage()),
    GetPage(name: Routes.HOME, page: () => HomePage()),
    GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPasswordPage()),
    GetPage(
      name: Routes.BSPOK, 
      page: () => const BSpokHomePage(),
      binding: BSpokBindings(),
    ),
    ...BSpokRoutes.routes,
  ];
}
