import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/modules/details/details_controller.dart';

class DetailsPage extends GetView<DetailsController> {
  @override
  Widget build(BuildContext context) {
    final prod = controller.product;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            prod.title.toString(),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images: prod.images!.map((url) {
                  return Builder(builder: (context) {
                    return Image.network(url);
                  });
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: appThemeData.primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    prod.title.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  Text(
                    'R\$ ${prod.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: appThemeData.primaryColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Tamanho',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  GetBuilder<DetailsController>(
                    init: DetailsController(),
                    builder: (_) {
                      return SizedBox(
                        height: 34,
                        child: GridView(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.5),
                          children: prod.sizes!.map((size) {
                            return GestureDetector(
                              onTap: () {
                                controller.changeSize(size);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                        color: controller.size == size
                                            ? appThemeData.primaryColor
                                            : Colors.grey,
                                        width: 3)),
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(size),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: GetBuilder<DetailsController>(
                      init: DetailsController(),
                      builder: (_) {
                        return ElevatedButton(
                          onPressed: controller.size != null
                              ? () {
                                  if (UserScopedModel.of(context)
                                      .isLoggedIn()) {
                                    controller.addToCard(context);
                                  } else {
                                    controller.login();
                                  }
                                }
                              : null,
                          child: GetBuilder<DetailsController>(
                            init: DetailsController(),
                            initState: (_) {},
                            builder: (_) {
                              return Text(
                                UserScopedModel.of(context).isLoggedIn()
                                    ? 'Adicionar ao carrinho'
                                    : 'Entre para comprar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              );
                            },
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  appThemeData.primaryColor)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    prod.description.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
