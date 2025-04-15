import 'package:bookio/Server/controllers/EnderecoController.dart';
import 'package:bookio/Server/controllers/UsuarioController.dart';
import 'package:bookio/Server/models/EnderecoModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:bookio/components/Botao.dart';
import 'package:bookio/components/BottomNavbar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late int? id_usuario;
  late UsuariosModel _usuario;
  late EnderecoModel _endereco;

  Future<void> BuscarInformacoesDoUsuario(BuildContext context) async {
    id_usuario =
        Provider.of<GerenciadorDeSessao>(context, listen: false).idUsuario;
    RespostaModel<UsuariosModel> usuario = await UsuarioController()
        .BuscarUsuarioPorId(id_usuario!);
    _usuario = usuario.dados!;
    RespostaModel<EnderecoModel> endereco = await EnderecoController()
        .BuscarEnderecoPorId(_usuario.endereco);
    _endereco = endereco.dados!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 32),
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 20, 24, 27),
        child: FutureBuilder(
          future: BuscarInformacoesDoUsuario(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Erro ao carregar informações.",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.76,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _usuario.nome,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _usuario.email,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 158, 158, 158),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(255, 38, 45, 52),
                            thickness: 2,
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Informações pessoais",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Botao(corTexto: Colors.white, icone: Icons.edit, corIcone: Colors.white, texto: "Editar")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomNavBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
