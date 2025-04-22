import 'dart:io';

import 'package:bookio/Server/controllers/UsuarioController.dart';
import 'package:bookio/Server/dtos/Usuario/AtualizarUsuarioDto.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditarInfoPessoalForm extends StatefulWidget {
  final int id_usuario;
  final String nome;
  final String email;
  final String senha;
  final int endereco;

  const EditarInfoPessoalForm({
    required this.id_usuario,
    required this.nome,
    required this.email,
    required this.senha,
    required this.endereco,
    super.key,
  });

  @override
  State<EditarInfoPessoalForm> createState() => _EditarInfoPessoalFormState();
}

class _EditarInfoPessoalFormState extends State<EditarInfoPessoalForm> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.nome;
    emailController.text = widget.email;
    senhaController.text = widget.senha;
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
                    !valueValidator(value) ? "Insira o nome." : null,
                    controller: nomeController,
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

                      hintText: 'Ex. John Doe',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Nome",
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
                    !valueValidator(value) ? "Insira o email." : null,
                    controller: emailController,
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

                      hintText: 'Ex. John@Doe.com',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "E-mail",
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
                    !valueValidator(value) ? "Insira a senha." : null,
                    controller: senhaController,
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

                      hintText: '********',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Senha",
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
                        AtualizarUsuarioDto novosDadosUsuario = new AtualizarUsuarioDto(
                            id: widget.id_usuario,
                            nome: nomeController.text,
                            email: emailController.text,
                            senha: senhaController.text,
                            endereco: widget.endereco
                        );

                        var atualizacao = await new UsuarioController().AtualizarUsuario(novosDadosUsuario);

                        print("atualização de usuario: ${atualizacao.mensagem}");

                        if (atualizacao.status == HttpStatus.accepted){
                          Navigator.pushReplacementNamed(context, "/conta");
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
                      "Editar informações",
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
