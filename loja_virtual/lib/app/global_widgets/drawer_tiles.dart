import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_virtual/app/core/app_theme.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Get.back();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: controller.page!.round() == page ? appThemeData.primaryColor : Colors.grey[700],
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.page!.round() == page ? appThemeData.primaryColor : Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
