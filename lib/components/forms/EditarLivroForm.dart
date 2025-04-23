import 'dart:io';

import 'package:bookio/Server/controllers/GeneroLiterarioController.dart';
import 'package:bookio/Server/controllers/LivroController.dart';
import 'package:bookio/Server/dtos/livro/AtualizarLivroDto.dart';
import 'package:bookio/Server/models/GeneroLiterarioModel.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditarLivroForm extends StatefulWidget {
  final int id_livro;
  final String titulo;
  final String autor;
  final int paginas_lidas;
  final int id_usuario;
  final int id_genero;

  const EditarLivroForm({
    required this.autor,
    required this.id_livro,
    required this.titulo,
    required this.paginas_lidas,
    required this.id_usuario,
    required this.id_genero,
    super.key,
  });

  @override
  State<EditarLivroForm> createState() => _EditarLivroFormState();
}

class _EditarLivroFormState extends State<EditarLivroForm> {
  late List<String> items = [];
  TextEditingController tituloController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController ultimaPaginaController = TextEditingController();
  String? selecionado;

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> buscarGenerosLiterarios() async{
    final generos = await GeneroLiterarioController().BuscarGeneros();
    setState(() {
      items = generos.dados!.map((genero) => genero.nome).toList();
    });
  }

  Future<int> BuscarIdGeneroPorNome(String nome) async{
    final genero = await GeneroLiterarioController().BuscarGeneroPorNome(nome);
    return genero.dados!.id_genero;
  }

  Future<void> BuscarGeneroPorId() async{
    final genero = await GeneroLiterarioController().BuscarGeneroPorID(widget.id_genero);
    selecionado = genero.dados!.nome;
  }

  @override
  void initState() {
    super.initState();
    tituloController.text = widget.titulo;
    autorController.text = widget.autor;
    ultimaPaginaController.text = widget.paginas_lidas.toString();
    buscarGenerosLiterarios();
    BuscarGeneroPorId();
  }

  @override
  Widget build(BuildContext context) {
    final idUsuario =
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
                  height: 60,
                  child:  DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        buttonStyleData: ButtonStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color.fromARGB(255, 144, 144, 144),
                            ),
                            color: Color.fromARGB(255, 20, 24, 27),
                          ),
                          elevation: 2,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 20, 24, 27),
                          ),
                        ),
                        isExpanded: true,
                        hint: Text(
                          "Selecione o gênero",
                          style: TextStyle(color: Colors.white),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),
                          ),
                        ))
                            .toList(),
                        value: selecionado,
                        onChanged: (value) {
                          setState(() {
                            selecionado = value;
                          });
                        },
                      )
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
                            AtualizarLivroDto(
                              id_livro: widget.id_livro,
                              titulo: tituloController.text,
                              autor: autorController.text,
                              paginas_lidas: int.parse(
                                ultimaPaginaController.text,
                              ),
                              id_usuario: widget.id_usuario,
                              id_genero: await BuscarIdGeneroPorNome(selecionado!)
                            );

                        final atualizacao = await LivroController()
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
                      "Editar livro",
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
