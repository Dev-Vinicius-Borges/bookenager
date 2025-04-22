class CriarEnderecoDto {
  final int cep;
  final String rua;
  final String cidade;
  final String estado;
  final String numero;

  CriarEnderecoDto({
    required this.cep,
    required this.rua,
    required this.cidade,
    required this.estado,
    required this.numero
  });
}
