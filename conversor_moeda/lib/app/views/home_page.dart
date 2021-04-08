import 'package:conversor_moeda/app/components/text_field_custom.dart';

import 'package:conversor_moeda/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _realController = TextEditingController();
  TextEditingController _dolarController = TextEditingController();
  TextEditingController _euroController = TextEditingController();

  double dolar;
  double euro;

  void realChanged(String text) {
    if (text.isEmpty) {
      clearAll();
      return;
    } else {
      double real = double.tryParse(text);
      _dolarController.text = (real / dolar).toStringAsFixed(2);
      _euroController.text = (real / euro).toStringAsFixed(2);
    }
  }

  void dolarChanged(String text) {
    if (text.isEmpty) {
      clearAll();
      return;
    } else {
      double dolar = double.tryParse(text);
      _realController.text = (dolar * this.dolar)
          .toStringAsFixed(2); //Neste caso o this.dolar seria o dolar do data
      _euroController.text = ((dolar * this.dolar) / euro).toStringAsFixed(2);
    }
  }

  void euroChanged(String text) {
    if (text.isEmpty) {
      clearAll();
      return;
    } else {
      double euro = double.tryParse(text);
      _realController.text = (euro * this.euro)
          .toStringAsFixed(2); //Neste caso o this.euro seria o euro do data
      _dolarController.text = ((euro * this.euro) / euro).toStringAsFixed(2);
    }
  }

  void clearAll() {
    _realController.text = "";
    _dolarController.text = "";
    _euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          backgroundColor: Colors.yellow[600],
          title: Text('Conversor de Moedas'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Carregando os dados',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                );

              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Erro ao realizar o download dos dados. :(',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(),
                        Icon(
                          Icons.monetization_on,
                          size: 140,
                          color: Colors.amber,
                        ),
                        textFieldCustom(
                            "R\$ ", "Reais", _realController, realChanged),
                        textFieldCustom(
                            "US\$ ", "Dolares", _dolarController, dolarChanged),
                        textFieldCustom(
                            "€ ", "Euros", _euroController, euroChanged),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
