import 'package:bookio/Server/dtos/Usuario/AtualizarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/FazerLoginDto.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';

abstract class IUsuarioInterface {
  Future<RespostaModel<UsuariosModel>> CriarUsuario(CriarUsuarioDto criarUsuarioDto);
  Future<RespostaModel<UsuariosModel>> BuscarUsuarioPorEmail(String email);
  Future<RespostaModel<UsuariosModel>> FazerLogin(FazerLoginDto fazerLoginDto);
  Future<RespostaModel<UsuariosModel>> AtualizarUsuario(AtualizarUsuarioDto atualizarUsuarioDto);
  Future<RespostaModel<UsuariosModel>> BuscarUsuarioPorId(int idUsuario);
}
