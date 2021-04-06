import 'package:conversor_moeda/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double dolar;
  double euro;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
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
                          style: TextStyle(color: Colors.white),
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
                            style: TextStyle(color: Colors.white),
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
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.amber),
                              prefixText: "R\$ ",
                              labelText: "Reais",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.amber),
                              prefixText: "US\$ ",
                              labelText: "Dolares",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.amber),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.amber),
                              prefixText: "€ ",
                              labelText: "Euros",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
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
