import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/services/UsuarioService.dart';

class UsuarioController{
  late UsuarioService _service;

  UsuarioController(){
    _service = new UsuarioService();
  }

  void CriarUsuario(CriarUsuarioDto criarUsuarioDto){
    _service.CriarUsuario(criarUsuarioDto);
  }
}