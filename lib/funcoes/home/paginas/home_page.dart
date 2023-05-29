import 'package:flutter/material.dart';
import 'package:pokemon/funcoes/home/container/container.dart';

import '../../../modelos/detalhes.dart';
import '../../../modelos/pokemon.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.list,
    required this.onIntemTap,
  }) : super();

  final List<Pokemon> list;
  final Function(String, ArgumentosDetalhe) onIntemTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'Pokemon',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: list
              .map(
                (e) => ItemPokemon(
                  pokemon: e,
                  onTap: onIntemTap,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
