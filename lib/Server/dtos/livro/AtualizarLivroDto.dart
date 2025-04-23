class AtualizarLivroDto {
  final int id_livro;
  final String titulo;
  final String autor;
  final int paginas_lidas;
  final int id_usuario;
  final int id_genero;

  AtualizarLivroDto({
    required this.id_livro,
    required this.titulo,
    required this.autor,
    required this.paginas_lidas,
    required this.id_usuario,
    required this.id_genero,
  });
}
