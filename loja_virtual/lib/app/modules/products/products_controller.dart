import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/data/models/product_model.dart';

class ProductsController extends GetxController {
  final DocumentSnapshot snapshot = Get.arguments[0];
}