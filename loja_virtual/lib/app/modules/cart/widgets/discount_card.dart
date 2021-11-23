import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/cart_scoped_model.dart';

class DiscountCart extends StatelessWidget {
  const DiscountCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Digite seu cupom'),
              initialValue: CartScopedModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.data() != null) {
                    CartScopedModel.of(context).setCoupon(text, docSnap.get('percent'));
                    Get.rawSnackbar(
                        message:
                            'Desconto de ${docSnap.get('percent')}% aplicado!',
                        backgroundColor: appThemeData.primaryColor);
                  } else {
                    CartScopedModel.of(context).setCoupon('', 0);
                    Get.rawSnackbar(
                        message:
                            'Cupom não existente!',
                        backgroundColor: Colors.redAccent);
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
