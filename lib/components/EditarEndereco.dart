import 'package:bookio/components/forms/EditarEnderecoForm.dart';
import 'package:flutter/material.dart';

class EditarEndereco extends StatefulWidget {
  final int id_endereco;
  final int cep;
  final String rua;
  final String cidade;
  final String estado;
  final String numero;

  const EditarEndereco({
    required this.id_endereco,
    required this.cep,
    required this.rua,
    required this.cidade,
    required this.estado,
    required this.numero,
    super.key,
  });

  @override
  State<EditarEndereco> createState() => _EditarEnderecoState();
}

class _EditarEnderecoState extends State<EditarEndereco> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 630,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Container(
              width: double.infinity,
              height: 630,
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
                        "Editar\nEndereço",
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
                    height: 520,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                      color: Color.fromARGB(255, 20, 24, 27),
                    ),
                    child: EditarEnderecolForm(
                      id_endereco: widget.id_endereco,
                      cep: widget.cep,
                      rua: widget.rua,
                      cidade: widget.cidade,
                      estado: widget.estado,
                      numero: widget.numero,
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
