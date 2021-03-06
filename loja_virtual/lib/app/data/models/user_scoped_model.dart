import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserScopedModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserScopedModel of(BuildContext context)
    => ScopedModel.of<UserScopedModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFailed}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
      email: userData['email'],
      password: pass,
    )
        .then((user) {
      firebaseUser = user.user!;

      _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFailed();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFailed}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
          firebaseUser = user.user;

          await _loadCurrentUser();

          onSuccess();
          isLoading = false;
          notifyListeners();
        })
        .catchError((e) {
          onFailed();
          isLoading = false;
          notifyListeners();
        });
  }

  void signOut() async {
    await _auth.signOut();

    userData = {};
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass (String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future? _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .set(userData);
  }

  Future? _loadCurrentUser() async{
    firebaseUser ??= _auth.currentUser;
    if(firebaseUser != null){
      if(userData['name'] == null){
        DocumentSnapshot docUser = await FirebaseFirestore.instance.collection('users').doc(firebaseUser!.uid).get();
        userData['name'] = docUser.get('name');
        userData['email'] = docUser.get('email');
        userData['address'] = docUser.get('address');
      }
    }
    notifyListeners();
  }
}
