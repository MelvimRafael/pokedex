import 'package:flutter/material.dart';
import 'package:pokemon/modelos/pokemon.dart';
import '../funcoes/home/paginas/carregando.dart';
import '../funcoes/home/paginas/error.dart';
import '../pokemon_futu.dart';

class PageDetalhes extends StatelessWidget {
  const PageDetalhes({super.key, required this.pokemon, required this.list});
  final Pokemon pokemon;
  final List<Pokemon> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              elevation: 0,
              backgroundColor: pokemon.baseColor,
            ),
          ),
          Positioned(
            top: 85,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              color: pokemon.baseColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            pokemon.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Text(
                          pokemon.num,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: PageView(
                        children:
                            list.map((e) => Image.network(e.image)).toList(),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Container

class ArgumentosDetalhe {
  final Pokemon pokemon;

  ArgumentosDetalhe({required this.pokemon});
}

class ContaineDetalhe extends StatelessWidget {
  const ContaineDetalhe({
    Key? key,
    required this.future,
    required this.argumento,
  }) : super(key: key);

  final IPokemon future;
  final ArgumentosDetalhe argumento;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: future.getAllPokemons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeCarregando();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return PageDetalhes(pokemon: argumento.pokemon, list: snapshot.data!);
        }

        if (snapshot.hasError) {
          return HomeError(error: (snapshot.error as Falha).messagem!);
        }

        return Container();
      },
    );
  }
}
