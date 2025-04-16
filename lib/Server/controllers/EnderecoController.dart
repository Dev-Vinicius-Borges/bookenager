import 'package:bookio/Server/dtos/endereco/AtualizarEnderecoDto.dart';
import 'package:bookio/Server/dtos/endereco/CriarEnderecoDto.dart';
import 'package:bookio/Server/models/EnderecoModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/services/EnderecoService.dart';

class EnderecoController {
  late EnderecoService _service;

  EnderecoController() {
    _service = new EnderecoService();
  }

  Future<RespostaModel<EnderecoModel>> AtualizarEndereco(
    AtualizarEnderecoDto atualizarEnderecoDto,
  ) async {
    final atualizacao = await _service.AtualizarEndereco(atualizarEnderecoDto);
    return atualizacao;
  }

  Future<RespostaModel<EnderecoModel>> BuscarEnderecoPorId(int id) async {
    final busca = await _service.BuscarEnderecoPorId(id);
    return busca;
  }

  Future<RespostaModel<EnderecoModel>> CriarEndereco(
    CriarEnderecoDto criarEnderecoDto,
  ) async {
    final criacao = await _service.CriarEndereco(criarEnderecoDto);
    return criacao;
  }

  Future<RespostaModel<EnderecoModel>> RemoverEndereco(int id) async {
    final remocao = await _service.RemoverEndereco(id);
    return remocao;
  }
}
