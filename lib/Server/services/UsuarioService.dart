import 'package:bookio/Server/abstracts/IUsuarioInterface.dart';
import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/FazerLoginDto.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsuarioService implements IUsuarioInterface {
  @override
  Future<RespostaModel<UsuariosModel>> BuscarUsuarioPorEmail(String email) {
    // TODO: implement BuscarUsuarioPorEmail
    throw UnimplementedError();
  }

  @override
  Future<RespostaModel<UsuariosModel>> CriarUsuario(CriarUsuarioDto criarUsuarioDto) {
    // TODO: implement CriarUsuario
    throw UnimplementedError();
  }

  @override
  Future<RespostaModel<UsuariosModel>> FazerLogin(FazerLoginDto fazerLoginDto) {
    // TODO: implement FazerLogin
    throw UnimplementedError();
  }
  
}