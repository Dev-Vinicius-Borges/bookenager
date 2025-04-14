import 'package:bookio/Server/dtos/Usuario/AtualizarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/FazerLoginDto.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:bookio/Server/services/UsuarioService.dart';

class UsuarioController{
  late UsuarioService _service;

  UsuarioController(){
    _service = UsuarioService();
  }

  Future<RespostaModel<UsuariosModel>> CriarUsuario(CriarUsuarioDto criarUsuarioDto) async{
    return await _service.CriarUsuario(criarUsuarioDto);
  }

  Future<RespostaModel<UsuariosModel>> FazerLogin(FazerLoginDto fazerLoginDto) async{
    return await _service.FazerLogin(fazerLoginDto);
  }

  Future<RespostaModel<UsuariosModel>> BuscarUsuarioPorEmail(String email) async{
    final busca = await _service.BuscarUsuarioPorEmail(email);
    return busca;
  }

  Future<RespostaModel<UsuariosModel>> AtualizarUsuario(AtualizarUsuarioDto atualizarUsuarioDto) async{
    final atualizacao = await _service.AtualizarUsuario(atualizarUsuarioDto);
    return atualizacao;
  }

  Future<RespostaModel<UsuariosModel>> BuscarUsuarioPorId(int id) async{
    final busca = await _service.BuscarUsuarioPorId(id);
    return busca;
  }
}