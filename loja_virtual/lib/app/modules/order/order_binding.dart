import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/order/order_controller.dart';

class OrderBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<OrderController>(() => OrderController());
  }
}