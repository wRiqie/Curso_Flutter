import 'package:chat/app/modules/chat/chat_binding.dart';
import 'package:chat/app/modules/chat/chat_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.CHAT,
      page: () => ChatPage(),
      binding: ChatBinding()
    )
  ];
}
