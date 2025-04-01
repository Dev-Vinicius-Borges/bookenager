import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/services/LivroService.dart';

class LivroController {
  late LivroService _service;

  LivroController() {
    _service = new LivroService();
  }

  Future<RespostaModel<List<Map<String, dynamic>>>> BuscarLivrosPorIdDoUsuario(int idUsuario) async{
    var busca = await _service.BuscarLivrosPorIdDoUsuario(idUsuario);
    return busca;
  }
}
