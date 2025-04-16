import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Botao extends StatefulWidget{
  final String texto;
  final Color corTexto;
  final IconData? icone;
  final Color corIcone;
  final Function()? funcao;

  Botao({super.key, required this.corTexto, required this.icone, required this.corIcone, required this.texto, this.funcao});

  @override
  State<Botao> createState() => _BotaoState();
}

class _BotaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 75, 57, 239)),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              )
          )
      ),
      onPressed: widget.funcao,
      child: Row(
        children: [
          Text(
            widget.texto,
            style: TextStyle(
              color: widget.corTexto,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(widget.icone, color: widget.corIcone),
          ),
        ],
      ),
    );
  }
}