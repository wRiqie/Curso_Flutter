import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/modules/login/login_controller.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(appThemeData.primaryColor),
                elevation: MaterialStateProperty.all(0)),
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            onPressed: () {
              Get.back();
              Get.toNamed(Routes.REGISTER);
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserScopedModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: controller.formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text != null) {
                      if (text.isEmpty || !text.contains('@')) {
                        return 'Email Inválido';
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (text) {
                    if (text != null) {
                      if (text.isEmpty || text.length < 6) {
                        return 'Senha Inválida';
                      }
                    }
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      controller.recoverPass(model);
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      textAlign: TextAlign.right,
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            appThemeData.primaryColor)),
                    onPressed: () {
                      controller.login(model);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
