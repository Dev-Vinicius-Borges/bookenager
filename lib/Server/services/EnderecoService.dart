import 'dart:io';

import 'package:bookio/Server/abstracts/IEnderecoInterface.dart';
import 'package:bookio/Server/dtos/endereco/AtualizarEnderecoDto.dart';
import 'package:bookio/Server/dtos/endereco/CriarEnderecoDto.dart';
import 'package:bookio/Server/models/EnderecoModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EnderecoService implements IEnderecoInterface {
  late SupabaseClient _contexto;

  EnderecoService([SupabaseClient? cliente]) {
    _contexto = cliente ?? Supabase.instance.client;
  }

  @override
  Future<RespostaModel<EnderecoModel>> AtualizarEndereco(
    AtualizarEnderecoDto atualizarEnderecoDto,
  ) async {
    RespostaModel<EnderecoModel> resposta = new RespostaModel<EnderecoModel>();
    try {
      var buscaEndereco =
          await _contexto
              .from('endereco')
              .select()
              .eq('id', atualizarEnderecoDto.id)
              .maybeSingle();


      if (buscaEndereco == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Endereço não encontrado.";
        return resposta;
      }

      final atualizacao = await _contexto
          .from('endereco')
          .update({
            "cep": atualizarEnderecoDto.cep,
            "rua": atualizarEnderecoDto.rua,
            "cidade": atualizarEnderecoDto.cidade,
            "estado": atualizarEnderecoDto.estado,
            "numero": atualizarEnderecoDto.numero
          })
          .eq('id', atualizarEnderecoDto.id);

      resposta.status = HttpStatus.ok;
      resposta.mensagem = "Endereço atualizado com sucesso.";
      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: ${err}";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<EnderecoModel>> BuscarEnderecoPorId(int id) async {
    RespostaModel<EnderecoModel> resposta = new RespostaModel<EnderecoModel>();
    try {
      var enderecoEncontrado =
          await _contexto.from("endereco").select().eq('id', id).maybeSingle();

      if (enderecoEncontrado == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Endereço não encontrado.";
        return resposta;
      }

      EnderecoModel endereco = new EnderecoModel(
        id: enderecoEncontrado['id'],
        cep: enderecoEncontrado['cep'],
        rua: enderecoEncontrado['rua'],
        cidade: enderecoEncontrado['cidade'],
        estado: enderecoEncontrado['estado'],
        numero: enderecoEncontrado['numero']
      );

      resposta.mensagem = "Endereço encontrado.";
      resposta.status = HttpStatus.found;
      resposta.dados = endereco;

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: ${err}";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<EnderecoModel>> CriarEndereco(
    CriarEnderecoDto criarEnderecoDto,
  ) async {
    RespostaModel<EnderecoModel> resposta = new RespostaModel<EnderecoModel>();
    try {
      final novoEndereco =
          await _contexto
              .from('endereco')
              .insert({
                "cep": criarEnderecoDto.cep,
                "rua": criarEnderecoDto.rua,
                "cidade": criarEnderecoDto.cidade,
                "estado": criarEnderecoDto.estado,
                "numero": criarEnderecoDto.numero
              })
              .select()
              .single();

      resposta.status = HttpStatus.created;
      resposta.mensagem = "Endereço criado com sucesso";
      resposta.dados = new EnderecoModel(
        id: novoEndereco['id'],
        cep: novoEndereco['cep'],
        rua: novoEndereco['rua'],
        cidade: novoEndereco['cidade'],
        estado: novoEndereco['estado'],
        numero: novoEndereco['numero']
      );

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: ${err}";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<EnderecoModel>> RemoverEndereco(int id) async {
    RespostaModel<EnderecoModel> resposta = new RespostaModel<EnderecoModel>();
    try {
      final enderecoExistente =
          await _contexto.from('endereco').select().eq('id', id).maybeSingle();

      if (enderecoExistente == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Endereço não encontrado.";
        return resposta;
      }

      final enderecoRemovido =
          await _contexto
              .from('endereco')
              .delete()
              .eq('id', id)
              .select()
              .single();

      resposta.status = HttpStatus.ok;
      resposta.mensagem = "Endereço removido com sucesso.";

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: ${err}";
      return resposta;
    }
  }
}
