import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/modules/order/order_controller.dart';

class OrderPage extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pedido Realizado'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: appThemeData.primaryColor,
                size: 80,
              ),
              const Text(
                'Pedido realizado com sucesso!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Código do pedido: ${controller.orderId}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ));
  }
}
