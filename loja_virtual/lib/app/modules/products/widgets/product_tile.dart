import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/product_model.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductModel product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: type == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      product.images?[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            product.title.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: appThemeData.primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      product.images?[0],
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: appThemeData.primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      onTap: () {
        Get.toNamed(Routes.DETAILS, arguments: [product]);
      },
    );
  }
}
