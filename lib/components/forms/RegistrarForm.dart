import 'dart:convert';
import 'dart:io';
import 'package:bookio/Server/controllers/EnderecoController.dart';
import 'package:bookio/Server/controllers/UsuarioController.dart';
import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/dtos/endereco/CriarEnderecoDto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => RegistrarState();
}

class RegistrarState extends State<Registrar> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return true;
  }

  buscarEndereco(String cep) async {
    final url = Uri.https("viacep.com.br", "ws/$cep/json/");
    var response = await http.get(url);

    if (response.statusCode != 200) {
      return;
    }

    final dados = jsonDecode(response.body);

    ruaController.text = dados['logradouro'];
    cidadeController.text = dados['localidade'];
    estadoController.text = dados['estado'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 237,
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Criar conta",
                style: TextStyle(color: Colors.white, fontSize: 16),
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
                            !valueValidator(value) ? "Insira o nome." : null,
                    controller: nameController,
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

                      hintText: 'Nome',
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

                      hintText: 'E-mail',
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
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    validator:
                        (String? value) =>
                            !valueValidator(value) ? "Insira a senha." : null,
                    controller: passwordController,
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
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 70,
                  child: TextFormField(
                    onChanged: (cepDigitado) {
                      buscarEndereco(cepDigitado);
                    },
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    validator: (String? value) {
                      if (!valueValidator(value)) {
                        return "Insira o CEP.";
                      }
                      if (value!.length < 8 || value!.length > 8) {
                        return "Digite o CEP corretamente.";
                      }

                      return null;
                    },

                    controller: cepController,
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

                      hintText: 'XXXXXXXX',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "CEP",
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
                            !valueValidator(value) ? "Insira a rua." : null,
                    controller: ruaController,
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

                      hintText: 'Rua X',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Rua",
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
                            !valueValidator(value) ? "Insira a cidade." : null,
                    controller: cidadeController,
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

                      hintText: 'Cidade X',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Cidade",
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
                            !valueValidator(value) ? "Insira o estado." : null,
                    controller: estadoController,
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

                      hintText: 'Estado X',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Estado",
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
                        CriarEnderecoDto novoEndereco = CriarEnderecoDto(
                          cep: int.parse(cepController.text),
                          rua: ruaController.text,
                          cidade: cidadeController.text,
                          estado: estadoController.text,
                        );

                        final criacaoEndereco = await EnderecoController()
                            .CriarEndereco(novoEndereco);

                        CriarUsuarioDto novoUsuario = CriarUsuarioDto(
                          nome: nameController.text,
                          email: emailController.text,
                          senha: passwordController.text,
                          endereco: criacaoEndereco.dados!.id,
                        );

                        final criacaoUsuario = await UsuarioController()
                            .CriarUsuario(novoUsuario);


                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(criacaoUsuario.mensagem.toString()),
                          ),
                        );

                        if (criacaoUsuario.status == HttpStatus.created){
                          Navigator.pushNamed(context, "/login");
                        }

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Por favor, preencha todos os campos corretamente.",
                            ),
                          ),
                        );
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
                      "Criar conta",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Text(
                      "Já possue uma conta?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Entre na sua conta",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
