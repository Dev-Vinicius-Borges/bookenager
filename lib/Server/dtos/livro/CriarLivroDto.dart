class CriarLivroDto {
  final String titulo;
  final String autor;
  final String paginas_lidas;
  final String id_usuario;

  CriarLivroDto({
    required this.titulo,
    required this.autor,
    required this.paginas_lidas,
    required this.id_usuario,
  });
}
