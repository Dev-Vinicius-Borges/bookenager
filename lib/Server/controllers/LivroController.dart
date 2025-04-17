import 'package:bookio/Server/dtos/livro/AtualizarLivroDto.dart';
import 'package:bookio/Server/dtos/livro/CriarLivroDto.dart';
import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/services/LivroService.dart';

class LivroController {
  late LivroService _service;

  LivroController() {
    _service = LivroService();
  }

  Future<RespostaModel<List<LivrosModel>>> BuscarLivrosPorIdDoUsuario(
    int idUsuario,
  ) async {
    var busca = await _service.BuscarLivrosPorIdDoUsuario(idUsuario);

    return busca;
  }

  Future<RespostaModel<LivrosModel>> criarNovoLivro(
    CriarLivroDto criarLivroDto,
  ) async {
    var criacao = await _service.CriarNovoLivro(criarLivroDto);


    return criacao;
  }

  Future<RespostaModel<LivrosModel>> RemoverLivro(int idLivro) async {
    var remocao = await _service.RemoverLivro(idLivro);
    return remocao;
  }

  Future<RespostaModel<LivrosModel>> AtualizarLivro(
    AtualizarLivroDto atualizarLivroDto,
  ) async {
    var atualizacao = await _service.AtualizarLivro(atualizarLivroDto);
    return atualizacao;
  }
}
