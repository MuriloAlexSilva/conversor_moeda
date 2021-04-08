import 'package:flutter/material.dart';

Widget textFieldCustom(String prefix, String label,
    TextEditingController controller, Function func) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: TextField(
      onChanged: func,
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(
        color: Colors.amber,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.amber),
        prefixText: prefix,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}
