import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
  }

  void onSuccess() {
    Get.rawSnackbar(
      message: 'Usuário criado com sucesso',
      backgroundColor: appThemeData.primaryColor,
      duration: Duration(seconds: 2),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Get.back();
    });
  }

  void onFailed() {
    Get.rawSnackbar(
      message: 'Falha ao criar usuário',
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    );
  }
}
