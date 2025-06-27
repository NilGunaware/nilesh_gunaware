import 'package:get/get.dart';
import 'controllers/bspok_auth_controller.dart';
import 'controllers/bspok_home_controller.dart';
import 'controllers/bspok_cart_controller.dart';

class BSpokBindings extends Bindings {
  @override
  void dependencies() {
    // Auth Controller
    Get.lazyPut<BSpokAuthController>(() => BSpokAuthController());
    
    // Home Controller
    Get.lazyPut<BSpokHomeController>(() => BSpokHomeController());
    
    // Cart Controller
    Get.lazyPut<BSpokCartController>(() => BSpokCartController());
  }
} 