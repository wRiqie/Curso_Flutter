import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/cart/cart_controller.dart';

class CartBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CartController>(() => CartController());
  }
}