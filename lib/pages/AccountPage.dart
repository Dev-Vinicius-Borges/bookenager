import 'package:bookio/Server/controllers/EnderecoController.dart';
import 'package:bookio/Server/controllers/UsuarioController.dart';
import 'package:bookio/Server/models/EnderecoModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:bookio/components/BottomNavbar.dart';
import 'package:flutter/material.dart';
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

  Future<void> BuscarInformacoesDoUsuario() async {
    id_usuario = Provider
        .of<GerenciadorDeSessao>(context, listen: false)
        .idUsuario;
    RespostaModel<UsuariosModel> usuario = await UsuarioController()
        .BuscarUsuarioPorId(id_usuario!);
    _usuario = usuario.dados!;
    RespostaModel<EnderecoModel> endereco = await EnderecoController()
        .BuscarEnderecoPorId(_usuario.endereco);
    _endereco = endereco.dados!;
  }

  @override
  void initState() {
    super.initState();
    BuscarInformacoesDoUsuario();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 20, 24, 27),
        child: Stack(
          children: [
            Column(
              children: [
                Text(_usuario.nome, style: TextStyle(color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(_usuario.email, style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),),
                ),
              ],
            ),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
