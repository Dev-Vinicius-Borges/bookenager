import 'dart:io';
import 'package:bookio/Server/controllers/GeneroLiterarioController.dart';
import 'package:bookio/Server/controllers/LivroController.dart';
import 'package:bookio/Server/dtos/livro/CriarLivroDto.dart';
import 'package:bookio/Server/models/GeneroLiterarioModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:camera/camera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';



class CriarLivroForm extends StatefulWidget {

  const CriarLivroForm({super.key});

  @override
  State<CriarLivroForm> createState() => _CriarLivroFormState();
}

class _CriarLivroFormState extends State<CriarLivroForm> {
  late List<String> items = [];
  TextEditingController tituloController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController ultimaPaginaController = TextEditingController();
  TextEditingController generoController = TextEditingController();
  String? selecionado;
  late CameraController _controller;
  List<CameraDescription> _cameras = [];
  late Future<void> _initializeControllerFuture;
  XFile? _imagemCapturada;

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> buscarGenerosLiterarios() async {
    final generos = await GeneroLiterarioController().BuscarGeneros();
    setState(() {
      items = generos.dados!.map((genero) => genero.nome).toList();
    });
  }

  Future<int> BuscarIdGeneroPorNome(String nome) async {
    final genero = await GeneroLiterarioController().BuscarGeneroPorNome(nome);
    return genero.dados!.id_genero;
  }

  Future<XFile?> tirarFoto() async {
    await _initializeControllerFuture;
    if (!_controller.value.isInitialized || _controller.value.isTakingPicture) {
      return null;
    }
    try {
      return await _controller.takePicture();
    } on CameraException catch (e) {
      debugPrint('Erro ao capturar imagem: $e');
      return null;
    }
  }

  Future<void> iniciarCamera() async {
    _cameras = await availableCameras();

    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    _initializeControllerFuture = _controller.initialize();

    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    iniciarCamera();
    buscarGenerosLiterarios();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: SizedBox(
                      width: 150,
                      height: 200,
                      child: _imagemCapturada != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_imagemCapturada!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                          : FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CameraPreview(_controller),
                            );
                          } else {
                            return Container(
                              color: Colors.grey[300],
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      final file = await tirarFoto();
                      if (file != null) {
                        setState(() {
                          _imagemCapturada = file;
                        });
                      }
                    },
                    child: Icon(Icons.camera_alt),
                  ),
                ],
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
                            !valueValidator(value) ? "Insira o título." : null,
                    controller: tituloController,
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

                      hintText: 'Ex. Duna',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Título",
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
                            !valueValidator(value)
                                ? "Insira o nome do autor."
                                : null,
                    controller: autorController,
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

                      hintText: 'Ex. Frank Ebert',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Nome do autor",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color.fromARGB(255, 144, 144, 144),
                          ),
                          color: Color.fromARGB(255, 20, 24, 27),
                        ),
                        elevation: 2,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 20, 24, 27),
                        ),
                      ),
                      isExpanded: true,
                      hint: Text(
                        "Selecione o gênero",
                        style: TextStyle(color: Colors.white),
                      ),
                      items:
                          items
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      value: selecionado,
                      onChanged: (value) {
                        setState(() {
                          selecionado = value;
                        });
                      },
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
                            !valueValidator(value)
                                ? "Insira a última página lida."
                                : null,
                    controller: ultimaPaginaController,
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

                      hintText: 'Ex. 250',
                      filled: true,
                      alignLabelWithHint: true,
                      label: Text(
                        "Última página lida",
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
                        CriarLivroDto novoLivro = CriarLivroDto(
                          titulo: tituloController.text,
                          autor: autorController.text,
                          paginas_lidas: int.parse(ultimaPaginaController.text),
                          id_usuario: idUsuario!,
                          genero: await BuscarIdGeneroPorNome(selecionado!),
                          url_imagem: _imagemCapturada!
                        );


                        final criacao = await LivroController().criarNovoLivro(
                          novoLivro,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(criacao.mensagem.toString())),
                        );

                        if (criacao.status == HttpStatus.created) {
                          Navigator.pushReplacementNamed(context, "/home");
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
                      "Adicionar livro",
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
