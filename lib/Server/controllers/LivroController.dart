import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:bookio/Server/services/LivroService.dart';

class LivroController {
  late LivroService _service;

  LivroController() {
    _service = new LivroService();
  }

  Future<RespostaModel<List<LivrosModel>>> BuscarLivrosPorIdDoUsuario(int id_usuario) async{
    print("O que veio do controller: ${_service.BuscarLivrosPorIdDoUsuario(id_usuario)}");
    return await _service.BuscarLivrosPorIdDoUsuario(id_usuario);
  }
}
