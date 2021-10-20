import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
 
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                      FileImage(File(contacts[index].img.toString())) : 
                        AssetImage("images/person.png") as ImageProvider
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contacts[index].name ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(contacts[index].email ?? "",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(contacts[index].phone ?? "",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),  
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
      context: context,
       builder: (context){
         return BottomSheet(
           builder: (context){
             return Container(
               padding: EdgeInsets.all(10),
               child: Column(
                 children: [
                   TextButton(
                     child: Text("Ligar", style: TextStyle(color: Colors.red, fontSize: 20),),
                     onPressed: (){

                     },
                   ),
                   TextButton(
                     child: Text("Ligar", style: TextStyle(color: Colors.red, fontSize: 20),),
                     onPressed: (){
                       
                     },
                   ),
                   TextButton(
                     child: Text("Ligar", style: TextStyle(color: Colors.red, fontSize: 20),),
                     onPressed: (){
                       
                     },
                   ),
                 ],
               ),
             );
           },
           onClosing: () {},
         );
       }
    );
  }

  void _showContactPage({Contact? contact}) async{
    final recContact = await Navigator.push(context, 
    MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    if(recContact != null){
      if(contact != null){
        await helper.updateContact(recContact);
      }
      else{
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      for (Contact item in list) {
        item.img=null;
        helper.updateContact(item);
        print(item);
      }
      setState(() {
        contacts = list;
      });
    });
  }
}
