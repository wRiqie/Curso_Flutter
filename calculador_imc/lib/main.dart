import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    int precision = 3;

    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(precision)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(precision)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            "Levemente acima do peso (${imc.toStringAsPrecision(precision)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(precision)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(precision)})";
      } else if (imc >= 40) {
        _infoText =
            "Obesidade grau III (${imc.toStringAsPrecision(precision)})";
      }
    });
    print(imc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () {
                  _resetFields();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.person_outline,
                      size: 120, color: Colors.green),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          labelText: "Peso (kg)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      controller: weightController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Insira seu peso!";
                        }
                      }),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          labelText: "Altura (cm)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      controller: heightController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Insira sua altura!";
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _calculate();
                          }
                        },
                        child: const Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
