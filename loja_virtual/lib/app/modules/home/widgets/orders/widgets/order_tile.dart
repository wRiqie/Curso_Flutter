import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/app/modules/home/widgets/orders/widgets/status_circle.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int status = snapshot.data!['status'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código do pedido: ${orderId}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(_buildProductsText(snapshot.data)),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Status do pedido:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatusCircle('1', 'Preparação', status, 1),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey,
                      ),
                      StatusCircle('2', 'Transporte', status, 2),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey,
                      ),
                      StatusCircle('3', 'Entrega', status, 3),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot? snapshot) {
    String text = 'Descrição:\n';
    if (snapshot != null) {
      for (LinkedHashMap p in snapshot.get('products')) {
        text +=
            '${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';
      }
      text += 'Total: R\$ ${snapshot.get('totalPrice').toStringAsFixed(2)}';

      return text;
    } else {
      return text;
    }
  }
}
