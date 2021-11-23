import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/app/data/models/cart_model.dart';
import 'package:loja_virtual/app/data/models/product_model.dart';
import 'package:loja_virtual/app/modules/cart/widgets/build_cart_products.dart';

class CartTile extends StatelessWidget {
  final CartModel cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productModel == null
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(cartProduct.category)
                  .collection('items')
                  .doc(cartProduct.pid)
                  .get(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  cartProduct.productModel = ProductModel.fromDocument(snapshot.data!);
                  return BuildContent(context ,cartProduct);
                }
                else{
                  return Container(
                    height: 70,
                    child: const CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : BuildContent(context, cartProduct),
    );
  }
}
