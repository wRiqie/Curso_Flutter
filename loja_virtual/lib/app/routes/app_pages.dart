import 'package:get/get.dart';
import 'package:loja_virtual/app/modules/cart/cart_binding.dart';
import 'package:loja_virtual/app/modules/cart/cart_page.dart';
import 'package:loja_virtual/app/modules/details/details_binding.dart';
import 'package:loja_virtual/app/modules/details/details_page.dart';
import 'package:loja_virtual/app/modules/home/home_binding.dart';
import 'package:loja_virtual/app/modules/home/home_page.dart';
import 'package:loja_virtual/app/modules/login/login_binding.dart';
import 'package:loja_virtual/app/modules/login/login_page.dart';
import 'package:loja_virtual/app/modules/order/order_binding.dart';
import 'package:loja_virtual/app/modules/order/order_page.dart';
import 'package:loja_virtual/app/modules/products/products_binding.dart';
import 'package:loja_virtual/app/modules/products/products_page.dart';
import 'package:loja_virtual/app/modules/signup/signup_binding.dart';
import 'package:loja_virtual/app/modules/signup/signup_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTS,
      page: () => ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.DETAILS,
      page: () => DetailsPage(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => OrderPage(),
      binding: OrderBinding(),
    ),
  ];
}
