import 'package:bookio/components/forms/CriarLivroForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Criarlivro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Text(
                  "Adicionar\nnovo\nlivro",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
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
                        borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                        color: Color.fromARGB(255, 20, 24, 27)
                    ),
                    child: CriarLivroForm(),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
