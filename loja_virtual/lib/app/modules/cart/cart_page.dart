import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/cart_scoped_model.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/modules/cart/cart_controller.dart';
import 'package:loja_virtual/app/modules/cart/widgets/cart_price.dart';
import 'package:loja_virtual/app/modules/cart/widgets/cart_tile.dart';
import 'package:loja_virtual/app/modules/cart/widgets/discount_card.dart';
import 'package:loja_virtual/app/modules/cart/widgets/ship_card.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Carrinho'),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartScopedModel>(
              builder: (context, child, model) {
                int pCount = model.products.length;
                return Text(
                  '$pCount ${pCount == 1 ? 'ITEM' : 'ITENS'}',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ),
        ],
      ),
      body: GetBuilder<CartController>(
        init: CartController(),
        builder: (_) {
          return ScopedModelDescendant<CartScopedModel>(
            builder: (context, child, model) {
              if (model.isLoading && UserScopedModel.of(context).isLoggedIn()) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!UserScopedModel.of(context).isLoggedIn()) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 80,
                        color: appThemeData.primaryColor,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Faça o login para adicionar produtos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              appThemeData.primaryColor),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (model.products.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum produto no carrinho',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return ListView(
                  children: [
                    Column(
                      children: model.products.map((product) {
                        return CartTile(product);
                      }).toList(),
                    ),
                    const DiscountCart(),
                    const ShipCard(),
                    CartPrice(() async {
                      model.finishOrder().then((orderId) {
                        if (orderId != '') {
                          Get.back();
                          Get.toNamed(Routes.ORDER, arguments: [orderId]);
                        }
                      });
                    }),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
