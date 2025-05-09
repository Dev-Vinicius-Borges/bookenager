import 'package:bookio/Server/models/GeneroLiterarioModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/services/GeneroLiterarioService.dart';

class GeneroLiterarioController{
  late GeneroLiterarioService _service;

  GeneroLiterarioController(){
    _service = new GeneroLiterarioService();
  }

  Future<RespostaModel<List<GeneroLiterarioModel>>> BuscarGeneros() async{
    var busca = await _service.BuscarGenerosLiterarios();
    return busca;
  }

  Future<RespostaModel<GeneroLiterarioModel>> BuscarGeneroPorNome(String nome) async{
    var busca = await _service.BuscarGeneroPorNome(nome);
    return busca;
  }
  
  Future<RespostaModel<GeneroLiterarioModel>> BuscarGeneroPorID(int id) async{
    var busca = await _service.BuscarGeneroPorId(id);
    return busca;
  }
}