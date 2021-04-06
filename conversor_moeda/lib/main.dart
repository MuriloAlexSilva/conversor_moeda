import 'package:conversor_moeda/app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert'; //Para adicionar o json

//a chave foi colocada em uma var para evitar erros de digitação
var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json-cors&key=65fcbecc");

void main() async {
  runApp(HomePage());
}

Future<Map> getData() async {
  //Função com o nome getData para retornar os valores no futuro.

  http.Response response = await http.get(request);
  return json.decode(response.body);
}
