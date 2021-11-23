import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/data/models/product_model.dart';
import 'package:loja_virtual/app/modules/products/products_controller.dart';
import 'package:loja_virtual/app/modules/products/widgets/product_tile.dart';

class ProductsPage extends GetView<ProductsController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.snapshot.get('title')),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('products').doc(controller.snapshot.id).collection('items').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.65
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      ProductModel data = ProductModel.fromDocument(snapshot.data!.docs[index]);

                      data.category = controller.snapshot.id;

                      return ProductTile("grid", data);
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      ProductModel data = ProductModel.fromDocument(snapshot.data!.docs[index]);

                      data.category = controller.snapshot.id;

                      return ProductTile("list", data);
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
