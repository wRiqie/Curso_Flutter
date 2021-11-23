import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/data/models/user_scoped_model.dart';
import 'package:loja_virtual/app/global_widgets/drawer_tiles.dart';
import 'package:loja_virtual/app/routes/app_pages.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(left: 32, top: 16),
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                  height: 170,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 8,
                        left: 0,
                        child: Text(
                          "Flutter's\nCloathing",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UserScopedModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Olá, ${!model.isLoggedIn() ? "" : model.userData['name']}',
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(!model.isLoggedIn()){
                                      Get.toNamed(Routes.LOGIN);
                                    }
                                    else{
                                      model.signOut();
                                      pageController.jumpTo(0);
                                    }
                                  },
                                  child: Text(
                                    !model.isLoggedIn() ? 'Entre ou cadastre-se >' : 'Sair',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                DrawerTile(Icons.home, 'Início', pageController, 0),
                DrawerTile(Icons.list, 'Produtos', pageController, 1),
                DrawerTile(Icons.location_on, 'Lojas', pageController, 2),
                DrawerTile(
                    Icons.playlist_add_check, 'Meus Pedidos', pageController, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
