import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var stream = FirebaseFirestore.instance.collection('messages').orderBy('time').snapshots();

  User? currentUser;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      currentUser = user;
      update();
    });
  }

  Future<User?> getUser() async {
    try {
      if (currentUser != null){
        return currentUser;
      } 

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential AuthResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = AuthResult.user;
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  void sendMessage({String? text, XFile? imgFile}) async {
    final User? user = await getUser();

    if (user == null) {
      Get.rawSnackbar(
          message: "Não foi possível fazer o login, tente novamente",
          backgroundColor: Colors.red);
    } else {
      Map<String, dynamic> data = {
        "uid": user.uid,
        "senderName": user.displayName,
        "senderPhotoUrl": user.photoURL,
        "time": Timestamp.now()
      };

      if (imgFile != null) {
        isLoading.value = true;
        TaskSnapshot task = await FirebaseStorage.instance
            .ref()
            .child(user.uid)
            .child(DateTime.now().millisecondsSinceEpoch.toString())
            .putFile(File(imgFile.path));

        String url = await task.ref.getDownloadURL();
        data['imgUrl'] = url;
        data['text'] = "";

        isLoading.value = false;
      }

      if (text != null) {
        data['text'] = text;
      }

      FirebaseFirestore.instance.collection('messages').add(data);
    }
  }

  void Logout(){
    FirebaseAuth.instance.signOut();
    _googleSignIn.signOut();
    Get.rawSnackbar(message: "Você saiu com sucesso");
  }
}
