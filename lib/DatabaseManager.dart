import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';


class DatabaseManager {

  Future<void> connect(BuildContext context) async {
    debugPrint("Connecting...");
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("LOADING"),
            content: CircularProgressIndicator(),
          );
        },
      );
      await SqlConn.connect(
          ip: "10.10.11.6",
          port: "1433",
          databaseName: "proyect",
          username: "admin",
          password: "thevoidloop1906");
      debugPrint("Connected!");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
  }

  Future<int> validarUsario(String query) async {
    var res = await SqlConn.readData(query);

    String jsonString = res.toString();
    List<dynamic> parsedList = jsonDecode(jsonString);

    int result = parsedList[0]['Result']; // Accede al valor de la clave "Result"
    debugPrint(res.toString());
    return result;
  }

  Future<void> write(String query) async {
    var res = await SqlConn.writeData(query);
    debugPrint(res.toString());
  }
}
