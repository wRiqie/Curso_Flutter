import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/app/data/models/product_model.dart';

class CartModel{
  String? cid;
  String? category;
  String? pid;
  late int quantity;
  String? size;
  
  ProductModel? productModel;

  CartModel();

  CartModel.fromDocument(DocumentSnapshot document){
    cid = document.id;
    category = document.get('category');
    pid = document.get('pid');
    quantity = document.get('quantity');
    size = document.get('size');
  }

  Map<String, dynamic> toMap(){
    return {
      'category': category,
      'pid': pid,
      'quantity': quantity,
      'size': size,
      'product': productModel?.toResumedMap()
    };
  }
}