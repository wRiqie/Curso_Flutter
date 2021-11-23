import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/global_widgets/cart_button.dart';
import 'package:loja_virtual/app/global_widgets/custom_drawer.dart';
import 'package:loja_virtual/app/modules/home/home_controller.dart';
import 'package:loja_virtual/app/modules/home/widgets/home/home_tab.dart';
import 'package:loja_virtual/app/modules/home/widgets/orders/orders_tab.dart';
import 'package:loja_virtual/app/modules/home/widgets/places/places_tab.dart';
import 'package:loja_virtual/app/modules/home/widgets/products/category_tab.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          floatingActionButton: const CartButton(),
          body: HomeTab(),
          drawer: CustomDrawer(controller.pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Produtos',
            ),
            centerTitle: true,
          ),
          body: ProductsTab(),
          drawer: CustomDrawer(controller.pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Lojas'),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(controller.pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Meus Pedidos'),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(controller.pageController),
        ),
      ],
    );
  }
}
