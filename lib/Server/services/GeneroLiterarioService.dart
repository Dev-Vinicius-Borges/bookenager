import 'dart:io';

import 'package:bookio/Server/abstracts/IGeneroLiterarioInterface.dart';
import 'package:bookio/Server/models/GeneroLiterarioModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GeneroLiterarioService implements IGeneroLiterarioInterface {
  late SupabaseClient _contexto;

  GeneroLiterarioService([SupabaseClient? cliente]) {
    _contexto = cliente ?? Supabase.instance.client;
  }

  @override
  Future<RespostaModel<List<GeneroLiterarioModel>>>
  BuscarGenerosLiterarios() async {
    RespostaModel<List<GeneroLiterarioModel>> resposta =
        new RespostaModel<List<GeneroLiterarioModel>>();
    try {
      var generosLiterarios =
          await _contexto.from('generos_literarios').select();

      if (generosLiterarios.isEmpty) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Nenhum gênero literário encontrado.";
        return resposta;
      }

      List<GeneroLiterarioModel> generos =
          generosLiterarios
              .map(
                (genero) => GeneroLiterarioModel(
                  id_genero: genero['id'],
                  nome: genero['genero'],
                ),
              )
              .toList();

      resposta.dados = generos;
      resposta.mensagem = "Generos entrados.";
      resposta.status = HttpStatus.found;

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: ${err}";
      return resposta;
    }
  }
}
