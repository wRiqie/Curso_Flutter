import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contador de Pessoas",
      home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _people = 0;
  String _infoText = "Pode Entrar!";

  void changePeople(int delta){
    setState(() {
      _people += delta;

      if(_people < 0){
        _infoText = "Mundo invertido?!";
      } else if(_people <= 10){
        _infoText = "Pode Entrar!";
      } else if(_people > 10){
        _infoText = "Lotado";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: prefer_const_constructors
            Text(
              "Pessoas: $_people",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      child: const Text("+1",
                          style: TextStyle(fontSize: 40, color: Colors.white)),
                      onPressed: () {
                        changePeople(1);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      child: const Text("-1",
                          style: TextStyle(fontSize: 40, color: Colors.white)),
                      onPressed: () {
                        changePeople(-1);
                      }),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            Text(
              _infoText,
              style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            ),
          ],
        ),
      ],
    );
  }
}
