import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/details/details_controller.dart';

class DetailsBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<DetailsController>(() => DetailsController());
  }
}