import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:bookio/components/BottomNavbar.dart';
import 'package:bookio/components/CriarLivro.dart';
import 'package:bookio/components/Livros.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookio/Server/controllers/LivroController.dart';

class BooksPage extends StatelessWidget {
  Future<List<Widget>> livrosDoUsuario(int? id) async {
    var consulta = await LivroController().BuscarLivrosPorIdDoUsuario(id ?? 21);
    var livros = consulta.dados ?? <Map<String, dynamic>>[];

    var livrosMapeados =
        livros
            .map(
              (livro) => Livros(
                livro['id'],
                livro['titulo'],
                livro['autor'],
                livro['paginas_lidas'],
                livro['dono'],
              ),
            )
            .toList();

    return livrosMapeados;
  }

  @override
  Widget build(BuildContext context) {
    final id_usuario =
        Provider.of<GerenciadorDeSessao>(context, listen: false).idUsuario;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 20, 24, 27),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0, -1),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.763,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Meus livros",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Builder(
                            builder: (context) {
                              return FilledButton.icon(
                                onPressed: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Criarlivro();
                                    },
                                  );
                                },
                                label: const Text(
                                  "Novo",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.plus_one,
                                  color: Colors.white,
                                ),
                                iconAlignment: IconAlignment.end,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                        Color.fromARGB(255, 85, 103, 253),
                                      ),
                                  shape: WidgetStatePropertyAll<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<Widget>>(
                        future: livrosDoUsuario(id_usuario),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "Erro ao carregar livro. ${snapshot.error}",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                "Nenhum livro encontrado.",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return ListView(children: snapshot.data!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
