import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/login/login_controller.dart';

class LoginBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<LoginController>(() => LoginController());
  }
}