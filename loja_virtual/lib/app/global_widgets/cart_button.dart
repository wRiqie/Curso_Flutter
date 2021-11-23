import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(Routes.CART);
      },
      child: const Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
      backgroundColor: appThemeData.primaryColor,
    );
  }
}
