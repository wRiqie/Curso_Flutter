import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/modules/home/widgets/orders/orders_tab_controller.dart';
import 'package:loja_virtual/app/modules/home/widgets/orders/widgets/order_tile.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';

class OrdersTab extends GetView<OrdersTabController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersTabController>(
      init: OrdersTabController(),
      builder: (_) {
        if (UserScopedModel.of(context).isLoggedIn()) {
          String uid = UserScopedModel.of(context).firebaseUser!.uid;

          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('orders')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: snapshot.data!.docs.map((doc) => OrderTile(doc.id)).toList().reversed.toList(),
                );
              }
            },
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.view_list,
                  size: 80,
                  color: appThemeData.primaryColor,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Faça o login para visualizar seus pedidos',
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
                  onPressed: controller.login,
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(appThemeData.primaryColor),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
