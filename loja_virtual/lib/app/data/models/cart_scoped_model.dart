import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/app/data/models/cart_model.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScopedModel extends Model {
  UserScopedModel? user;

  List<CartModel> products = [];

  String? couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartScopedModel(this.user) {
    if (user!.isLoggedIn()) {
      _loadCartItems();
    }
  }

  static CartScopedModel of(BuildContext context) =>
      ScopedModel.of<CartScopedModel>(context);

  void addCartItem(CartModel product) {
    products.add(product);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.firebaseUser!.uid)
        .collection('cart')
        .add(product.toMap())
        .then((doc) {
      product.cid = doc.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartModel product) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.firebaseUser!.uid)
          .collection('cart')
          .doc(product.cid)
          .delete();

      products.remove(product);

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  void decProduct(CartModel cartProduct) {
    cartProduct.quantity--;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.firebaseUser!.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartModel cartProduct) {
    cartProduct.quantity++;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.firebaseUser!.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    couponCode == couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartModel c in products) {
      if (c.productModel != null) {
        price += c.quantity * c.productModel!.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  Future<String> finishOrder() async {
    if (products.isEmpty) return '';

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection('orders').add({
      'clientId': user!.firebaseUser!.uid,
      'products': products.map((e) => e.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discountPrice': discount,
      'totalPrice': productsPrice - discount + shipPrice,
      'status': 1
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.firebaseUser!.uid)
        .collection('orders')
        .doc(refOrder.id)
        .set({'orderId': refOrder.id});

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.firebaseUser!.uid)
        .collection('cart')
        .get();

    for(DocumentSnapshot doc in query.docs){
      doc.reference.delete();
    }

    products.clear();

    couponCode = '';
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.id;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.firebaseUser!.uid)
        .collection('cart')
        .get();

    products = query.docs.map((doc) => CartModel.fromDocument(doc)).toList();

    notifyListeners();
  }
}
