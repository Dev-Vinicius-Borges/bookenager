import 'dart:io';
import 'dart:js_interop';

import 'package:bookio/Server/abstracts/ILivroInterface.dart';
import 'package:bookio/Server/dtos/livro/AtualizarLivroDto.dart';
import 'package:bookio/Server/dtos/livro/CriarLivroDto.dart';
import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LivroService implements ILivroInterface {
  @override
  Future<RespostaModel<LivrosModel>> AtualizarLivro(
    AtualizarLivroDto atualizarLivroDto,
  ) async {
    RespostaModel<LivrosModel> resposta = new RespostaModel();
    try {
      var livro =
          await Supabase.instance.client
              .from('livros')
              .select()
              .eq('id', atualizarLivroDto.id_livro)
              .maybeSingle();

      if (livro == null) {
        resposta.mensagem = "Livro não encontrado.";
        resposta.status = HttpStatus.notFound;
        return resposta;
      }

      await Supabase.instance.client
          .from('livros')
          .update({
            "paginas_lidas": atualizarLivroDto.paginas_lidas,
            "autor": atualizarLivroDto.autor,
            "titulo": atualizarLivroDto.titulo,
          })
          .eq('id', atualizarLivroDto.id_livro)
          .eq('dono', atualizarLivroDto.id_usuario);

      resposta.status = HttpStatus.accepted;
      resposta.mensagem = "Livro atualizado com sucesso.";
      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<List<Map<String, dynamic>>>> BuscarLivrosPorIdDoUsuario(
    int id_usuario,
  ) async {
    RespostaModel<List<Map<String, dynamic>>> resposta = new RespostaModel();
    try {
      var livros = await Supabase.instance.client
          .from('livros')
          .select()
          .eq("dono", id_usuario)
          .eq('status', true);

      if (livros.isEmpty) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Nenhum livro encontrado.";
        return resposta;
      }

      resposta.dados = livros;
      resposta.mensagem = "Livros encontrados.";
      resposta.status = HttpStatus.found;

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: ${err.toExternalReference}";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<LivrosModel>> CriarNovoLivro(
    CriarLivroDto criarLivroDto,
  ) async {
    RespostaModel<LivrosModel> resposta = new RespostaModel();
    try {
      var livro = await Supabase.instance.client
          .from('livros')
          .select()
          .eq('titulo', criarLivroDto.titulo)
          .eq('autor', criarLivroDto.autor);

      if (livro.length > 0) {
        resposta.status = HttpStatus.conflict;
        resposta.mensagem = "Você já´cadastrou esse livro.";
        return resposta;
      }

      await Supabase.instance.client.from('livros').insert({
        'criado_em': new DateTime.now().toUtc().toIso8601String(),
        'titulo': criarLivroDto.titulo,
        'paginas_lidas': criarLivroDto.paginas_lidas,
        'status': true,
        'dono': criarLivroDto.id_usuario,
        'autor': criarLivroDto.autor,
      });

      resposta.dados = LivrosModel(
        titulo: criarLivroDto.titulo,
        autor: criarLivroDto.autor,
        paginas_lidas: criarLivroDto.paginas_lidas,
        id_usuario: criarLivroDto.id_usuario,
      );

      resposta.mensagem = "Livro criado com sucesso.";
      resposta.status = HttpStatus.created;
      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<LivrosModel>> RemoverLivro(int id_livro) async {
    RespostaModel<LivrosModel> resposta = new RespostaModel();
    try {
      var livro =
          await Supabase.instance.client
              .from('livros')
              .select()
              .eq('id', id_livro)
              .maybeSingle();

      if (livro == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Livro não encontrado.";
        return resposta;
      }

      await Supabase.instance.client.from('livros').delete().eq("id", id_livro);

      resposta.status = HttpStatus.accepted;
      resposta.mensagem = "Livro removido.";

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }
}
