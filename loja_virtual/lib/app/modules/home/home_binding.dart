import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<HomeController>(() => HomeController());
  }
}