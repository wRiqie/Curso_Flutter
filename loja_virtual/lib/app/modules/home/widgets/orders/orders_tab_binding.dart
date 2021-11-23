import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/home/widgets/orders/orders_tab_controller.dart';

class OrdersTabBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<OrdersTabController>(() => OrdersTabController());
  }
}