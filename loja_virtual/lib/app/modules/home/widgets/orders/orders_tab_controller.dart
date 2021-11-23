import 'package:get/get.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';

class OrdersTabController extends GetxController {
  void login(){
    Get.toNamed(Routes.LOGIN)?.then((_) {
      update();
    });
  }
}