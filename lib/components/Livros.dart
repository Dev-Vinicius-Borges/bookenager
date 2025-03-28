import 'package:flutter/cupertino.dart';

class Livros extends StatefulWidget{
  final String id_livro;
  final String titulo;
  final String autor;
  final String paginas_lidas;
  final String id_usuario;

  const Livros(this.id_livro, this.titulo, this.autor, this.paginas_lidas, this.id_usuario, {super.key});

  @override
  State<Livros> createState() => _LivrosState();

}

class _LivrosState extends State<Livros>{

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }

}