import 'dart:io';

import 'package:bookio/Server/controllers/LivroController.dart';
import 'package:bookio/Server/controllers/UsuarioController.dart';
import 'package:bookio/Server/dtos/livro/AtualizarLivroDto.dart';
import 'package:bookio/Server/dtos/livro/CriarLivroDto.dart';
import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditarLivroForm extends StatefulWidget {
  final int id_livro;
  final String titulo;
  final String autor;
  final int paginas_lidas;
  final int id_usuario;

  const EditarLivroForm({
    required this.autor,
    required this.id_livro,
    required this.titulo,
    required this.paginas_lidas,
    required this.id_usuario,
    super.key,
  });

  @override
  State<EditarLivroForm> createState() => _EditarLivroFormState();
}

class _EditarLivroFormState extends State<EditarLivroForm> {
  TextEditingController tituloController = new TextEditingController();
  TextEditingController autorController = new TextEditingController();
  TextEditingController ultimaPaginaController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    tituloController.text = widget.titulo;
    autorController.text = widget.autor;
    ultimaPaginaController.text = widget.paginas_lidas.toString();
  }

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final id_usuario =
        Provider.of<GerenciadorDeSessao>(context, listen: false).idUsuario;
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 70,
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    validator:
                        (String? value) =>
                            !valueValidator(value) ? "Insira o título." : null,
                    controller: tituloController,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 144, 144, 144),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 154, 154, 154),
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),

                      hintText: 'Ex. Duna',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Título",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 70,
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    validator:
                        (String? value) =>
                            !valueValidator(value)
                                ? "Insira o nome do autor."
                                : null,
                    controller: autorController,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 144, 144, 144),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 154, 154, 154),
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),

                      hintText: 'Ex. Frank Ebert',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Nome do autor",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 70,
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    validator:
                        (String? value) =>
                            !valueValidator(value)
                                ? "Insira a última página lida."
                                : null,
                    controller: ultimaPaginaController,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 144, 144, 144),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 154, 154, 154),
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),

                      hintText: 'Ex. 250',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Última página lida",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AtualizarLivroDto livroAtualizado =
                            new AtualizarLivroDto(
                              id_livro: widget.id_livro,
                              titulo: tituloController.text,
                              autor: autorController.text,
                              paginas_lidas: int.parse(
                                ultimaPaginaController.text,
                              ),
                              id_usuario: widget.id_usuario,
                            );

                        final atualizacao = await new LivroController()
                            .AtualizarLivro(livroAtualizado);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              atualizacao.mensagem.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );

                        if (atualizacao.status == HttpStatus.accepted) {
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromARGB(255, 85, 103, 254),
                      ),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      "Adicionar livro",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
