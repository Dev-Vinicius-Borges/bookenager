import 'dart:io';
import 'package:bookio/Server/abstracts/IUsuarioInterface.dart';
import 'package:bookio/Server/dtos/Usuario/AtualizarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/dtos/Usuario/FazerLoginDto.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/models/UsuariosModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsuarioService implements IUsuarioInterface {
  late SupabaseClient _contexto;

  UsuarioService([SupabaseClient? cliente]) {
    _contexto = cliente ?? Supabase.instance.client;
  }

  @override
  Future<RespostaModel<UsuariosModel>> BuscarUsuarioPorEmail(String email) {
    // TODO: implement BuscarUsuarioPorEmail
    throw UnimplementedError();
  }

  @override
  Future<RespostaModel<UsuariosModel>> CriarUsuario(
    CriarUsuarioDto criarUsuarioDto,
  ) async {
    RespostaModel<UsuariosModel> resposta = RespostaModel();
    try {
      var consulta =
          await _contexto
              .from("usuarios")
              .select()
              .eq("email", criarUsuarioDto.email)
              .maybeSingle();

      if (consulta != null) {
        resposta.status = HttpStatus.conflict;
        resposta.mensagem = "Já existe uma conta com esse e-mail.";
        return resposta;
      }

      await _contexto
          .from("usuarios")
          .insert({
            "nome": criarUsuarioDto.nome,
            "email": criarUsuarioDto.email,
            "senha": criarUsuarioDto.senha,
            "endereco": criarUsuarioDto.endereco,
          })
          .select()
          .single();

      resposta.status = HttpStatus.created;
      resposta.mensagem = "Conta criada com sucesso.";

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro: $err";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<UsuariosModel>> FazerLogin(
    FazerLoginDto fazerLoginDto,
  ) async {
    RespostaModel<UsuariosModel> resposta = RespostaModel();
    try {
      final consulta =
          await _contexto
              .from("usuarios")
              .select()
              .eq("email", fazerLoginDto.email)
              .maybeSingle();

      if (consulta == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Tente com outras credenciais.";
        return resposta;
      }

      if (consulta["senha"] != fazerLoginDto.senha) {
        resposta.status = HttpStatus.unauthorized;
        resposta.mensagem = "E-mail ou senha incorretos.";
        return resposta;
      }

      resposta.status = HttpStatus.accepted;
      resposta.mensagem = "Bem-vindo";
      resposta.dados = UsuariosModel(
        id: consulta['id'],
        nome: consulta['nome'],
        email: consulta['email'],
        senha: consulta['senha'],
        endereco: consulta['endereco'],
      );
      return resposta;
    } catch (err) {
      resposta.status = 500;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<UsuariosModel>> AtualizarUsuario(
    AtualizarUsuarioDto atualizarUsuarioDto,
  ) async {
    RespostaModel<UsuariosModel> resposta = RespostaModel<UsuariosModel>();
    try {
      final usuario =
          await _contexto
              .from('usuarios')
              .select()
              .eq('id', atualizarUsuarioDto.id)
              .maybeSingle();

      if (usuario == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Usuário não encontrado";
        return resposta;
      }

      await _contexto
          .from('usuarios')
          .update({
            "nome": atualizarUsuarioDto.nome,
            "email": atualizarUsuarioDto.email,
            "senha": atualizarUsuarioDto.senha,
          })
          .eq("id", atualizarUsuarioDto.id);

      resposta.mensagem = "Usuário atualizado com sucesso.";
      resposta.status = HttpStatus.accepted;
      resposta.dados = UsuariosModel(
        id: atualizarUsuarioDto.id,
        nome: atualizarUsuarioDto.nome,
        email: atualizarUsuarioDto.email,
        senha: atualizarUsuarioDto.senha,
        endereco: atualizarUsuarioDto.endereco,
      );

      return resposta;
    } catch (err) {
      resposta.status = 500;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<UsuariosModel>> BuscarUsuarioPorId(int idUsuario) async {
    RespostaModel<UsuariosModel> resposta = RespostaModel<UsuariosModel>();
    try {
      final usuario =
          await _contexto
              .from('usuarios')
              .select()
              .eq('id', idUsuario)
              .maybeSingle();

      if (usuario == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Usuário não encontrado.";
        return resposta;
      }

      resposta.mensagem = "Usuário encontrado.";
      resposta.status = HttpStatus.found;
      resposta.dados = UsuariosModel(
        id: usuario['id'],
        nome: usuario['nome'],
        email: usuario['email'],
        senha: usuario['senha'],
        endereco: usuario['endereco'],
      );

      return resposta;
    } catch (err) {
      resposta.status = 500;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }
}
