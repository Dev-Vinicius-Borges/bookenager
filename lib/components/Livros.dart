import 'dart:io';

import 'package:bookio/Server/controllers/LivroController.dart';
import 'package:bookio/components/EditarLivro.dart';
import 'package:flutter/material.dart';

class Livros extends StatefulWidget {
  final int id_livro;
  final String titulo;
  final String autor;
  final int paginas_lidas;
  final int id_usuario;

  const Livros(
    this.id_livro,
    this.titulo,
    this.autor,
    this.paginas_lidas,
    this.id_usuario, {
    super.key,
  });

  @override
  State<Livros> createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 40, 46, 53),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.titulo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          Text(
                            widget.autor,
                            style: TextStyle(
                              color: Color.fromARGB(255, 166, 166, 166),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Páginas lidas",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 137, 137, 137),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  widget.paginas_lidas.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 16,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 207, 88),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return EditarLivro(
                                widget.id_livro,
                                widget.titulo,
                                widget.autor,
                                widget.paginas_lidas,
                                widget.id_usuario,
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit_note_rounded,
                          size: 24,
                          color: Color.fromARGB(255, 38, 45, 52),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 89, 99),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final remocao = await LivroController()
                              .RemoverLivro(widget.id_livro);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                remocao.mensagem.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );

                          if (remocao.status == HttpStatus.accepted) {
                            Navigator.pushReplacementNamed(context, "/home");
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 24,
                          color: Color.fromARGB(255, 38, 45, 52),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
