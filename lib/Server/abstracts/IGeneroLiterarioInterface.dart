import 'package:bookio/Server/models/GeneroLiterarioModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';

abstract class IGeneroLiterarioInterface{
  Future<RespostaModel<List<GeneroLiterarioModel>>> BuscarGenerosLiterarios();
  Future<RespostaModel<GeneroLiterarioModel>> BuscarGeneroPorNome(String nome);
  Future<RespostaModel<GeneroLiterarioModel>> BuscarGeneroPorId(int id);
}