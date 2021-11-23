import 'package:get/get.dart';

class OrderController extends GetxController {
  late final String orderId;

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments[0];
  }
}