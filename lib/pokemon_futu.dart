import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/funcoes/home/container/container.dart';
import 'package:pokemon/modelos/detalhes.dart';
import 'package:pokemon/modelos/pokemon.dart';

abstract class IPokemon {
  Future<List<Pokemon>> getAllPokemons();
}

class PokemonFuture implements IPokemon {
  final Dio dio;
  PokemonFuture({required this.dio});
  @override
  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await dio.get(Api.allPokemonsURL);
      final json = jsonDecode(response.data) as Map<String, dynamic>;
      final list = json['pokemon'] as List<dynamic>;
      return list.map((e) => Pokemon.fromMap(e)).toList();
    } catch (e) {
      throw Falha(messagem: 'Não Carregou');
    }
  }
}

class Api {
  static String allPokemonsURL =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
}

class Falha implements Exception {
  final String? messagem;

  Falha({this.messagem});
}

class Rotas extends StatelessWidget {
  const Rotas({super.key, required this.future});
  final PokemonFuture future;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) {
              return HomeContainer(
                future: future,
                onIntemTap: (rotas, argumentos) {
                  Navigator.of(context).pushNamed(rotas, arguments: argumentos);
                },
              );
            },
          );
        }
        if (settings.name == '/detalhes')
          return MaterialPageRoute(
            builder: (context) {
              return ContaineDetalhe(
                future: future,
                argumento: (settings.arguments as ArgumentosDetalhe),
              );
            },
          );
      },
    );
  }
}
