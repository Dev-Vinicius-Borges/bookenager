import 'package:camera/camera.dart';

class AtualizarLivroDto {
  final int id_livro;
  final String titulo;
  final String autor;
  final int paginas_lidas;
  final int id_usuario;
  final int id_genero;
  final XFile? url_imagem;

  AtualizarLivroDto({
    required this.id_livro,
    required this.titulo,
    required this.autor,
    required this.paginas_lidas,
    required this.id_usuario,
    required this.id_genero,
    this.url_imagem
  });
}
