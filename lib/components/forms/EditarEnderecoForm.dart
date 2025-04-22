import 'dart:convert';
import 'dart:io';

import 'package:bookio/Server/controllers/EnderecoController.dart';
import 'package:bookio/Server/dtos/endereco/AtualizarEnderecoDto.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditarEnderecolForm extends StatefulWidget {
  final int id_endereco;
  final int cep;
  final String rua;
  final String cidade;
  final String estado;
  final String numero;

  const EditarEnderecolForm({
    required this.id_endereco,
    required this.cep,
    required this.rua,
    required this.cidade,
    required this.estado,
    required this.numero,
    super.key,
  });

  @override
  State<EditarEnderecolForm> createState() => _EditarEnderecolFormState();
}

class _EditarEnderecolFormState extends State<EditarEnderecolForm> {
  TextEditingController cepController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cepController.text = widget.cep.toString();
    ruaController.text = widget.rua;
    cidadeController.text = widget.cidade;
    estadoController.text = widget.estado;
    numeroController.text = widget.numero;
  }

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return true;
  }

  buscarEndereco(String cep) async {
    final url = Uri.https("cep.awesomeapi.com.br", "json/$cep");
    var response = await http.get(url);

    if (response.statusCode != 200) {
      return;
    }

    final dados = jsonDecode(response.body);

    ruaController.text = dados['address_name'];
    cidadeController.text = dados['city'];
    estadoController.text = dados['state'];

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
                    onChanged: (cepDigitado) {
                      buscarEndereco(cepDigitado);
                    },
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    validator:
                        (String? value) =>
                            !valueValidator(value) ? "Insira o CEP." : null,
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

                      hintText: 'Ex. 12345678',
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
                            !valueValidator(value) ? "Insira a rua" : null,
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

                      hintText: 'Ex. Rua X',
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
                            !valueValidator(value) ? "Insira o número" : null,
                    controller: numeroController,
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

                      hintText: 'Ex. XX',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Número",
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
                            !valueValidator(value) ? "Insira a cidade" : null,
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

                      hintText: 'Ex. Cidade X',
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

                      hintText: 'Ex. Estado X',
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
                        AtualizarEnderecoDto novoEndereco =
                            new AtualizarEnderecoDto(
                              id: widget.id_endereco,
                              cep: int.parse(cepController.text),
                              rua: ruaController.text,
                              cidade: cidadeController.text,
                              estado: estadoController.text,
                              numero: numeroController.text,
                            );

                        var atualizacao = await EnderecoController()
                            .AtualizarEndereco(novoEndereco);


                        if (atualizacao.status == HttpStatus.ok){
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
                      "Editar endereço",
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
