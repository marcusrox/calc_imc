import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  double _imc = 0.0;
  String _infoTextIMC = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetForm() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      _imc = 0.0;
      _infoTextIMC = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura =
          double.parse(alturaController.text) / 100; // altura em metros
      _imc = peso / (altura * altura);
      if (_imc < 18.6)
        _infoTextIMC = "Abaixo do peso. IMC: " + _imc.toStringAsPrecision(4);
      else if (_imc < 30.0)
        _infoTextIMC = "Dentro do peso. IMC: " + _imc.toStringAsPrecision(4);
      else
        _infoTextIMC = "Acima do peso. IMC: " + _imc.toStringAsPrecision(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetForm,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 100.0, color: Colors.green),
              TextFormField(
                controller: pesoController,
                validator: (value){ if (value.isEmpty) return "Informe o peso!";},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: " Peso (kg):",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              TextFormField(
                controller: alturaController,
                validator: (value){ if (value.isEmpty) return "Informe a altura!";},
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: " Altura (cm):",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 90,
                child: RaisedButton(
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) _calcularIMC();
                  },
                  color: Colors.green,
                ),
              ),
              Text(_infoTextIMC,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0))
            ],
          ),
        ),
      ),
    );
  }
}
