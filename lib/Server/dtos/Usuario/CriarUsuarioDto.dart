class CriarUsuarioDto {
  final String nome;
  final String email;
  final String senha;
  final int endereco;

  CriarUsuarioDto({
    required this.nome,
    required this.email,
    required this.senha,
    required this.endereco,
  });
}
