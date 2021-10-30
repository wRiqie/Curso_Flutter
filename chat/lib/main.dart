import 'package:chat/app/core/theme/app_theme.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appThemeData,
    initialRoute: Routes.CHAT,
    getPages: AppPages.pages,
  ));

}
