import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/FazerLoginDto.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:bookio/Server/services/UsuarioService.dart';

class UsuarioController{
  late UsuarioService _service;

  UsuarioController(){
    _service = new UsuarioService();
  }

  Future<RespostaModel<UsuariosModel>> CriarUsuario(CriarUsuarioDto criarUsuarioDto) async{
    return await _service.CriarUsuario(criarUsuarioDto);
  }

  Future<RespostaModel<UsuariosModel>> FazerLogin(FazerLoginDto fazerLoginDto) async{
    return await _service.FazerLogin(fazerLoginDto);
  }
}