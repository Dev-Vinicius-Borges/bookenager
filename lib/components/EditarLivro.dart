import 'package:bookio/components/forms/EditarLivroForm.dart';
import 'package:flutter/material.dart';

class EditarLivro extends StatefulWidget {
  final int id_livro;
  final String titulo;
  final String autor;
  final int paginas_lidas;
  final int id_usuario;

  const EditarLivro(
    this.id_livro,
    this.titulo,
    this.autor,
    this.paginas_lidas,
    this.id_usuario, {
    super.key,
  });

  @override
  State<EditarLivro> createState() => _EditarLivroState();
}

class _EditarLivroState extends State<EditarLivro> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 104, 64, 237),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16),
                child: Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Editar\nlivro",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, size: 32, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Container(
                    width: double.infinity,
                    height: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                      color: Color.fromARGB(255, 20, 24, 27),
                    ),
                    child: EditarLivroForm(
                      id_livro: widget.id_livro,
                      paginas_lidas: widget.paginas_lidas,
                      id_usuario: widget.id_usuario,
                      titulo: widget.titulo,
                      autor: widget.autor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
