class AtualizarEnderecoDto {
  final int id;
  final int cep;
  final String rua;
  final String cidade;
  final String estado;

  AtualizarEnderecoDto({
    required this.id,
    required this.cep,
    required this.rua,
    required this.cidade,
    required this.estado,
  });
}
