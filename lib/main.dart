
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/pokemon_futu.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemom MPB',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Rotas(
        future: PokemonFuture(
          dio: Dio(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
