import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/modules/signup/signup_controller.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserScopedModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: controller.formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(hintText: 'Nome Completo'),
                  validator: (text) {
                    if (text != null) {
                      if (text.isEmpty) {
                        return 'Nome Inválido';
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
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
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.addressController,
                  decoration: InputDecoration(hintText: 'Endereço'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text != null) {
                      if (text.isEmpty) {
                        return 'Endereço Inválido';
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    child: const Text(
                      'Criar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            appThemeData.primaryColor)),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        Map<String, dynamic> userData = {
                          'name': controller.nameController.text,
                          'email': controller.emailController.text,
                          'address': controller.addressController.text,
                        };

                        model.signUp(
                          userData: userData,
                          pass: controller.passwordController.text,
                          onSuccess: controller.onSuccess,
                          onFailed: controller.onFailed,
                        );
                      }
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
