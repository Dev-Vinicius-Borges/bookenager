class AtualizarUsuarioDto {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final int endereco;

  AtualizarUsuarioDto({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.endereco,
  });
}
