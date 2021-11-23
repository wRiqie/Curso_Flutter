import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/data/models/cart_model.dart';
import 'package:loja_virtual/app/data/models/cart_scoped_model.dart';
import 'package:loja_virtual/app/data/models/product_model.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/modules/cart/cart_page.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';

class DetailsController extends GetxController {
  final ProductModel product = Get.arguments[0];
  String? size;

  changeSize(s) {
    size = s;
    update();
  }

  void addToCard(BuildContext context) {
    CartModel cartProduct = CartModel();
    cartProduct.size = size;
    cartProduct.quantity = 1;
    cartProduct.pid = product.id;
    cartProduct.category = product.category;
    cartProduct.productModel = product;

    CartScopedModel.of(context).addCartItem(cartProduct);

    Get.toNamed(Routes.CART);
  }

  void login(){
    Get.toNamed(Routes.LOGIN)?.then((_) {
      update();
    });
  }
}
