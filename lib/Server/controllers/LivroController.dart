import 'package:bookio/Server/dtos/livro/AtualizarLivroDto.dart';
import 'package:bookio/Server/dtos/livro/CriarLivroDto.dart';
import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/services/LivroService.dart';
import 'package:bookio/components/Livros.dart';

class LivroController {
  late LivroService _service;

  LivroController() {
    _service = new LivroService();
  }

  Future<RespostaModel<List<Map<String, dynamic>>>> BuscarLivrosPorIdDoUsuario(
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

  Future<RespostaModel<LivrosModel>> RemoverLivro(int id_livro) async {
    var remocao = await _service.RemoverLivro(id_livro);
    return remocao;
  }

  Future<RespostaModel<LivrosModel>> AtualizarLivro(
    AtualizarLivroDto atualizarLivroDto,
  ) async {
    var atualizacao = await _service.AtualizarLivro(atualizarLivroDto);
    return atualizacao;
  }
}
