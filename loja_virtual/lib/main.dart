import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/cart_scoped_model.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/modules/home/home_binding.dart';
import 'package:scoped_model/scoped_model.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ScopedModel<UserScopedModel>(
      model: UserScopedModel(),
      child: ScopedModelDescendant<UserScopedModel>(
        builder: (context, child, model) {
          return ScopedModel<CartScopedModel>(
            model: CartScopedModel(model),
            child: GetMaterialApp(
              title: "Flutter's Clothing",
              debugShowCheckedModeBanner: false,
              theme: appThemeData,
              getPages: AppPages.pages,
              initialRoute: Routes.HOME,
              initialBinding: HomeBinding(),
            ),
          );
        },
      ),
    ),
  );
}
