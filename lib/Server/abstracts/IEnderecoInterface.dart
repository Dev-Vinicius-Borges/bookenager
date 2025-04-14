import 'package:bookio/Server/dtos/endereco/AtualizarEnderecoDto.dart';
import 'package:bookio/Server/dtos/endereco/CriarEnderecoDto.dart';
import 'package:bookio/Server/models/EnderecoModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';

abstract class IEnderecoInterface{
  Future<RespostaModel<EnderecoModel>> BuscarEnderecoPorId(int id);
  Future<RespostaModel<EnderecoModel>> CriarEndereco(CriarEnderecoDto criarEnderecoDto);
  Future<RespostaModel<EnderecoModel>> RemoverEndereco(int id);
  Future<RespostaModel<EnderecoModel>> AtualizarEndereco(AtualizarEnderecoDto atualizarEnderecoDto);
}