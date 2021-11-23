import 'package:get/get.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';

class CartController extends GetxController {
  login() {
    Get.toNamed(Routes.LOGIN)?.then((_) {
      update();
    });
  }
}
