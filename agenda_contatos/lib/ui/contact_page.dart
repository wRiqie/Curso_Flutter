import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  late Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = Contact();
    }
    else{
      _editedContact = Contact.fromMap(widget.contact!.toMap());

      _nameController.text = _editedContact.name.toString();
      _emailController.text = _editedContact.email.toString();
      _phoneController.text = _editedContact.phone.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
      appBar: AppBar(
        title: Text(_editedContact.name ?? "Novo contato"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
        onPressed: () {
          if(_editedContact.name!.isNotEmpty || _editedContact.name != null){
            Navigator.pop(context, _editedContact);
          }
          else{
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    image: _editedContact.img != null ?
                      FileImage(File(_editedContact.img.toString())) : 
                        AssetImage("images/person.png") as ImageProvider
                  ),
                ),
              ),
              onTap: (){
                ImagePicker.platform.pickImage(source: ImageSource.camera).then((file) {
                  if(file == null)
                    return;
                  else{
                    setState(() {
                      _editedContact.img = file.path;
                      print(file.path);
                    });
                  }
                });
              },
            ),
            TextField(
              controller: _nameController,
              focusNode: _nameFocus,
              decoration: InputDecoration(
                labelText: "Nome"
              ),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact.name = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email"
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone"
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.phone = text;
              },
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    ),
    );
  }

  Future<bool> _requestPop() {
    if(_userEdited){
      showDialog(
        context: context,
         builder: (context){
           return AlertDialog(
             title: Text("Descartar alterações?"),
             content: Text("Se sair as alterações serão perdidas."),
             actions: [
               TextButton(
                 onPressed: (){
                  Navigator.pop(context);
                 }, 
                 child: Text("Cancelar")
                ),
                TextButton(
                 onPressed: (){
                   Navigator.pop(context);
                   Navigator.pop(context);
                 }, 
                 child: Text("Sim")
                ),
             ],
           );
         }
      );
      return Future.value(false);
    }
    else{
      return Future.value(true);
    }
  }
}
