import 'dart:convert';
import 'package:bookio/Server/controllers/EnderecoController.dart';
import 'package:bookio/Server/controllers/UsuarioController.dart';
import 'package:bookio/Server/models/EnderecoModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:bookio/Server/session/config.dart';
import 'package:bookio/components/Botao.dart';
import 'package:bookio/components/BottomNavbar.dart';
import 'package:bookio/components/EditarEndereco.dart';
import 'package:bookio/components/EditarInformacoesPessoais.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late int? id_usuario;
  late UsuariosModel _usuario;
  late EnderecoModel _endereco;
  late double lat;
  late double lng;

  Future<void> BuscarInformacoesDoUsuario(BuildContext context) async {
    id_usuario =
        Provider.of<GerenciadorDeSessao>(context, listen: false).idUsuario;
    RespostaModel<UsuariosModel> usuario = await UsuarioController()
        .BuscarUsuarioPorId(id_usuario!);
    _usuario = usuario.dados!;
    RespostaModel<EnderecoModel> endereco = await EnderecoController()
        .BuscarEnderecoPorId(_usuario.endereco);
    _endereco = endereco.dados!;

    final url = Uri.https(
      "cep.awesomeapi.com.br",
      "json/${_endereco.cep.toString()}",
    );
    var response = await http.get(url);

    final dados = jsonDecode(response.body);

    lat = double.parse(dados['lat']);
    lng = double.parse(dados['lng']);

    // LocationPermission permissao = await Geolocator.requestPermission();
    //
    // if (permissao == LocationPermission.denied) {
    //   print("Permissão negada.");
    //   return;
    // }
    //
    // Position posicao = await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.high,
    // );
    //
    // lat = posicao.latitude;
    // lng = posicao.longitude;
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
                      child: Column(
                        spacing: 32,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
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
                                          Botao(
                                            corTexto: Colors.white,
                                            icone: Icons.edit,
                                            corIcone: Colors.white,
                                            texto: "Editar",
                                            funcao: () {
                                              showBottomSheet(
                                                context: context,
                                                builder: (
                                                  BuildContext context,
                                                ) {
                                                  return EditarInfoPessoal(
                                                    id_usuario: id_usuario!,
                                                    nome: _usuario.nome,
                                                    email: _usuario.email,
                                                    senha: _usuario.senha,
                                                    endereco: _endereco.id,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(top: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Nome",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                _usuario.nome,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(top: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "E-mail",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                _usuario.email,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(top: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Senha",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                _usuario.senha,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
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
                                            "Endereço",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Botao(
                                            corTexto: Colors.white,
                                            icone: Icons.edit,
                                            corIcone: Colors.white,
                                            texto: "Editar",
                                            funcao: () {
                                              showBottomSheet(
                                                context: context,
                                                builder: (
                                                  BuildContext context,
                                                ) {
                                                  return EditarEndereco(
                                                    id_endereco: _endereco.id,
                                                    cep: _endereco.cep,
                                                    rua: _endereco.rua,
                                                    cidade: _endereco.cidade,
                                                    estado: _endereco.estado,
                                                    numero: _endereco.numero,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 16),
                                        width: double.infinity,
                                        height: 400,
                                        child: FlutterMap(
                                          options: MapOptions(
                                            initialCenter: LatLng(lat, lng),
                                            initialZoom: 12,
                                          ),
                                          children: [
                                            TileLayer(
                                              urlTemplate:
                                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                              userAgentPackageName:
                                                  'com.example.app',
                                            ),
                                            CircleLayer(
                                              circles: [
                                                CircleMarker(
                                                  point: LatLng(lat, lng),
                                                  radius: 15,
                                                  color: Colors.red.withValues(
                                                    alpha: 0.3,
                                                  ),
                                                  borderColor: Colors.red
                                                      .withValues(alpha: 0.7),
                                                  borderStrokeWidth: 2,
                                                ),
                                              ],
                                            ),
                                          ],
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
                                  alignment: Alignment.bottomRight,
                                  child: Botao(
                                    corTexto: Colors.white,
                                    icone: Icons.logout,
                                    corIcone: Colors.white,
                                    texto: "Sair da conta",
                                  ),
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
