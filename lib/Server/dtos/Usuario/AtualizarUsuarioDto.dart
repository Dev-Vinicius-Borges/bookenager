class AtualizarUsuarioDto {
  final int id;
  final String nome;
  final String email;
  final String senha;

  AtualizarUsuarioDto({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });
}
