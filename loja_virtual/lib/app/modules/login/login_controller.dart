import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSuccess() {
    Get.back();
  }

  void onFailed() {
    Get.rawSnackbar(
      message: 'Falha ao entrar',
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    );
  }

  void login(UserScopedModel model) {
    if (formKey.currentState!.validate()) {
      model.signIn(
          email: emailController.text,
          pass: passwordController.text,
          onSuccess: onSuccess,
          onFailed: onFailed);
    }
  }

  void recoverPass(UserScopedModel model) {
    if (emailController.text.isEmpty) {
      Get.rawSnackbar(
        message: 'Insira seu email para recuperação',
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      );
    } else {
      model.recoverPass(emailController.text);
      Get.rawSnackbar(
        message: 'Confira seu email',
        backgroundColor: appThemeData.primaryColor,
        duration: Duration(seconds: 2),
      );
    }
  }
}
