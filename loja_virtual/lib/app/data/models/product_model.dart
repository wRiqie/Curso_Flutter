import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String id;
  String? category;
  String? title;
  String? description;
  late double price;
  List? images;
  List? sizes;

  ProductModel({ required this.id, this.category, this.title, this.description, required this.price, this.images, this.sizes });

  ProductModel.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot.get('title');
    description = snapshot.get('description');
    price = snapshot.get('price') + 0.0; // Para resolver o bug em que quando o número tem 00 depois da vírgula acaba virando int
    images = snapshot.get('images');
    sizes = snapshot.get('sizes');
  }

  Map<String, dynamic> toResumedMap(){
    return {
      'title': title,
      'description': description,
      'price': price
    };
  }
}