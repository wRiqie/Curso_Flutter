import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/products/products_controller.dart';

class ProductsBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ProductsController>(() => ProductsController());
  }
}