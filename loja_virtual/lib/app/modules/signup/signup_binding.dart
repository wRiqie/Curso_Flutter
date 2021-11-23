import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/signup/signup_controller.dart';

class SignUpBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SignUpController>(() => SignUpController());
  }
}