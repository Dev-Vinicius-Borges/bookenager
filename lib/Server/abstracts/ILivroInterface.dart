import 'package:bookio/Server/dtos/Usuario/CriarUsuarioDto.dart';
import 'package:bookio/Server/dtos/livro/AtualizarLivroDto.dart';
import 'package:bookio/Server/dtos/livro/CriarLivroDto.dart';
import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';

abstract class ILivroInterface{
  Future<RespostaModel<List<LivrosModel>>> BuscarLivrosPorIdDoUsuario(int id_usuario);
  Future<RespostaModel<LivrosModel>> CriarNovoLivro(CriarLivroDto criarLivroDto);
  Future<RespostaModel<LivrosModel>> AtualizarLivro(AtualizarLivroDto atualizarLivroDto);
  Future<RespostaModel<LivrosModel>> RemoverLivro(int id_livro);
}