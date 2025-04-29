import 'package:camera/camera.dart';

class CriarLivroDto {
  final String titulo;
  final String autor;
  final int paginas_lidas;
  final int id_usuario;
  final int genero;
  final XFile? url_imagem;

  CriarLivroDto({
    required this.titulo,
    required this.autor,
    required this.paginas_lidas,
    required this.id_usuario,
    required this.genero,
    this.url_imagem
  });
}
