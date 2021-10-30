import 'package:chat/app/modules/chat/chat_message.dart';
import 'package:chat/app/modules/chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';

class ChatPage extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: GetBuilder(
            init: ChatController(),
            builder: (_) => Text(controller.currentUser != null
                ? 'Olá, ${controller.currentUser!.displayName}'
                : 'Chat App'),
          ),
          elevation: 0,
          actions: [
            GetBuilder(
                init: ChatController(),
                builder: (_) => controller.currentUser != null
                    ? IconButton(
                        onPressed: () {
                          controller.Logout();
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                        ),
                      )
                    : Container()),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
              stream: controller.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List documents = snapshot.data!.docs.reversed.toList();

                    return ListView.builder(
                        itemCount: documents.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return ChatMessage(
                            documents[index].data(), 
                            documents[index].data()['uid'] == controller.currentUser?.uid ? true : false
                          );
                        });
                }
              },
            )),
            Obx(() =>
              controller.isLoading.value ? LinearProgressIndicator() : Container()
            ),
            TextComposer(controller.sendMessage),
          ],
        ));
  }
}
