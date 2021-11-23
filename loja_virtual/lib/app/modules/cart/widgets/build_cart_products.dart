import 'package:flutter/material.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/cart_model.dart';
import 'package:loja_virtual/app/data/models/cart_scoped_model.dart';

Widget BuildContent(BuildContext context, CartModel cartProduct) {

  CartScopedModel.of(context).updatePrices();

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        width: 120,
        child: Image.network(cartProduct.productModel?.images?[0],
            fit: BoxFit.cover),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cartProduct.productModel!.title.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              Text(
                'Tamanho: ${cartProduct.size}',
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                'R\$ ${cartProduct.productModel!.price.toStringAsFixed(2)}',
                style: TextStyle(
                    color: appThemeData.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: cartProduct.quantity > 1 ? (){
                      CartScopedModel.of(context).decProduct(cartProduct);
                    } 
                    : null,
                    icon: Icon(Icons.remove),
                    color: appThemeData.primaryColor,
                  ),
                  Text(cartProduct.quantity.toString()),
                  IconButton(
                    onPressed: () {
                      CartScopedModel.of(context).incProduct(cartProduct);
                    },
                    icon: Icon(Icons.add),
                    color: appThemeData.primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      CartScopedModel.of(context).removeCartItem(cartProduct);
                    },
                    child: Text(
                      'Remover',
                      style: TextStyle(
                        color: Colors.grey[500]
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
