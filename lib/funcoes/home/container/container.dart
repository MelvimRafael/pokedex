import 'package:flutter/material.dart';
import 'package:pokemon/funcoes/home/paginas/carregando.dart';
import 'package:pokemon/funcoes/home/paginas/home_page.dart';
import 'package:pokemon/modelos/detalhes.dart';
import 'package:pokemon/modelos/pokemon.dart';
import 'package:pokemon/pokemon_futu.dart';
import '../paginas/error.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    Key? key,
    required this.future,
    required this.onIntemTap,
  }) : super(key: key);

  final IPokemon future;
  final Function(String, ArgumentosDetalhe) onIntemTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: future.getAllPokemons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return HomeCarregando();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return HomePage(
            list: snapshot.data!,
            onIntemTap: onIntemTap,
          );
        }

        if (snapshot.hasError) {
          return HomeError(error: (snapshot.error as Falha).messagem!);
        }

        return Container();
      },
    );
  }
}

// widget pokemon home

class ItemPokemon extends StatelessWidget {
  const ItemPokemon({
    super.key,
    required this.pokemon,
    required this.onTap,
  });
  final Pokemon pokemon;
  final Function(String, ArgumentosDetalhe) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(
          '/detalhes',
          ArgumentosDetalhe(
            pokemon: pokemon,
          )),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: pokemon.baseColor!.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            pokemon.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          '#${pokemon.num}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: pokemon.type
                              .map((e) => TipoWidegt(
                                    name: e,
                                  ))
                              .toList(),
                        ),
                        Flexible(
                          child: Container(
                            height: 100,
                            width: 2,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 3,
            child: Image.network(pokemon.image),
          ),
        ],
      ),
    );
  }
}

class TipoWidegt extends StatelessWidget {
  const TipoWidegt({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            name,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
