import 'package:flutter/cupertino.dart';

class Usuario extends StatefulWidget{
  final String id_usuario;
  final String nome;
  final String email;
  final String senha;

  const Usuario(this.id_usuario, this.nome, this.email, this.senha,{super.key});

  @override
  State<Usuario> createState() => _UsuarioState();

}

class _UsuarioState extends State<Usuario>{

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

}