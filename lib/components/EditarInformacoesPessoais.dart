import 'package:bookio/components/forms/EditarInfoPessoalForm.dart';
import 'package:flutter/material.dart';

class EditarInfoPessoal extends StatefulWidget {
  final int id_usuario;
  final String nome;
  final String email;
  final String senha;
  final int endereco;

  const EditarInfoPessoal({
    required this.id_usuario,
    required this.nome,
    required this.email,
    required this.senha,
    required this.endereco,
    super.key,
  });

  @override
  State<EditarInfoPessoal> createState() => _EditarInfoPessoalState();
}

class _EditarInfoPessoalState extends State<EditarInfoPessoal> {
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
                        "Editar\nInformações pessoais",
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
                    child: EditarInfoPessoalForm(
                      id_usuario: widget.id_usuario,
                      nome: widget.nome,
                      email: widget.email,
                      senha: widget.senha,
                      endereco: widget.endereco,
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
