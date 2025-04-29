import 'dart:io';
import 'package:bookio/Server/abstracts/ILivroInterface.dart';
import 'package:bookio/Server/dtos/livro/AtualizarLivroDto.dart';
import 'package:bookio/Server/dtos/livro/CriarLivroDto.dart';
import 'package:bookio/Server/models/LivrosModel.dart';
import 'package:bookio/Server/models/RespostaModel.dart';
import 'package:camera/camera.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LivroService implements ILivroInterface {
  late SupabaseClient _contexto;

  LivroService([SupabaseClient? cliente]) {
    _contexto = cliente ?? Supabase.instance.client;
  }

  @override
  Future<RespostaModel<LivrosModel>> AtualizarLivro(
      AtualizarLivroDto atualizarLivroDto) async {
    RespostaModel<LivrosModel> resposta = RespostaModel();
    try {
      var livro = await _contexto
          .from('livros')
          .select()
          .eq('id', atualizarLivroDto.id_livro)
          .maybeSingle();

      if (livro == null) {
        resposta.mensagem = "Livro não encontrado.";
        resposta.status = HttpStatus.notFound;
        return resposta;
      }

      String? imagemUrlAntiga = livro['imagem'];

      if (atualizarLivroDto.url_imagem != null) {
        if (imagemUrlAntiga != null) {
          final filePath = imagemUrlAntiga.split('/').last;
          await _contexto.storage
              .from('livros')
              .remove([filePath]);
        }

        XFile imagemXFile = atualizarLivroDto.url_imagem!;
        final fileBytes = await imagemXFile.readAsBytes();
        final fileName = 'livro_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final storagePath = 'livros/$fileName';
        final response = await _contexto.storage
            .from('livros')
            .uploadBinary(storagePath, fileBytes, fileOptions: const FileOptions(contentType: 'image/jpeg'));

        imagemUrlAntiga = _contexto.storage.from('livros').getPublicUrl(storagePath);
      }

      await _contexto.from('livros').update({
        "paginas_lidas": atualizarLivroDto.paginas_lidas,
        "autor": atualizarLivroDto.autor,
        "titulo": atualizarLivroDto.titulo,
        "genero": atualizarLivroDto.id_genero,
        "imagem": imagemUrlAntiga
      }).eq('id', atualizarLivroDto.id_livro)
          .eq('dono', atualizarLivroDto.id_usuario);

      resposta.status = HttpStatus.accepted;
      resposta.mensagem = "Livro atualizado com sucesso.";
      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }


  @override
  Future<RespostaModel<List<LivrosModel>>> BuscarLivrosPorIdDoUsuario(
      int idUsuario) async {
    RespostaModel<List<LivrosModel>> resposta = RespostaModel<List<LivrosModel>>();
    try {
      var livros = await _contexto
          .from('livros')
          .select()
          .eq("dono", idUsuario)
          .eq('status', true);

      if (livros.isEmpty) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Nenhum livro encontrado.";
        return resposta;
      }

      final livrosMap = await Future.wait(
        livros.map((livro) async {
          final imagemUrl = livro['imagem'];
          final XFile imagemXFile = await baixarImagemComoXFile(imagemUrl);

          return LivrosModel(
            id_livro: livro['id'],
            titulo: livro['titulo'],
            autor: livro['autor'],
            paginas_lidas: livro['paginas_lidas'],
            id_usuario: livro['dono'],
            genero: livro['genero'],
            url_imagem: imagemXFile,
          );
        }),
      );

      resposta.dados = livrosMap;
      resposta.mensagem = "Livros encontrados.";
      resposta.status = HttpStatus.found;

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }


  static Future<XFile> baixarImagemComoXFile(String imageUrl) async {
    final resposta = await http.get(Uri.parse(imageUrl));

    if (resposta.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final filePath = p.join(tempDir.path, 'livro_${DateTime
          .now()
          .millisecondsSinceEpoch}.jpg');

      final file = File(filePath);
      await file.writeAsBytes(resposta.bodyBytes);

      return XFile(filePath);
    } else {
      throw Exception('Erro ao baixar a imagem (${resposta.statusCode})');
    }
  }

  @override
  Future<RespostaModel<LivrosModel>> CriarNovoLivro(
      CriarLivroDto criarLivroDto,) async {
    String? imagemUrl;
    RespostaModel<LivrosModel> resposta = RespostaModel();
    try {
      var livro = await _contexto
          .from('livros')
          .select()
          .eq('titulo', criarLivroDto.titulo)
          .eq('autor', criarLivroDto.autor)
          .eq('genero', criarLivroDto.genero);

      if (livro.isNotEmpty) {
        resposta.status = HttpStatus.conflict;
        resposta.mensagem = "Você já cadastrou esse livro.";
        return resposta;
      }

      XFile imagemXFile = criarLivroDto.url_imagem!;
      final fileBytes = await imagemXFile.readAsBytes();
      final fileName = 'livro_${DateTime
          .now()
          .millisecondsSinceEpoch}.jpg';
      final storagePath = 'livros/$fileName';
      final response = await _contexto.storage
          .from('livros')
          .uploadBinary(storagePath, fileBytes,
          fileOptions: const FileOptions(contentType: 'image/jpeg'));

      imagemUrl = _contexto.storage.from('livros').getPublicUrl(storagePath);

      await _contexto.from('livros').insert({
        'criado_em': DateTime.now().toUtc().toIso8601String(),
        'titulo': criarLivroDto.titulo,
        'paginas_lidas': criarLivroDto.paginas_lidas,
        'status': true,
        'dono': criarLivroDto.id_usuario,
        'autor': criarLivroDto.autor,
        'genero': criarLivroDto.genero,
        'imagem': imagemUrl
      });

      resposta.dados = new LivrosModel(
          titulo: criarLivroDto.titulo,
          autor: criarLivroDto.autor,
          paginas_lidas: criarLivroDto.paginas_lidas,
          id_usuario: criarLivroDto.id_usuario,
          genero: criarLivroDto.genero,
          url_imagem: await baixarImagemComoXFile(imagemUrl)
      );

      resposta.mensagem = "Livro criado com sucesso.";
      resposta.status = HttpStatus.created;
      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }

  @override
  Future<RespostaModel<LivrosModel>> RemoverLivro(int idLivro) async {
    RespostaModel<LivrosModel> resposta = RespostaModel();
    try {
      var livro =
      await _contexto
          .from('livros')
          .select()
          .eq('id', idLivro)
          .maybeSingle();

      if (livro == null) {
        resposta.status = HttpStatus.notFound;
        resposta.mensagem = "Livro não encontrado.";
        return resposta;
      }

      String? imagemUrl = livro['imagem'];

      if (imagemUrl != null) {
        final filePath = imagemUrl
            .split('/')
            .last;

        await _contexto.storage
            .from('livros')
            .remove([filePath]);
      }

      await _contexto.from('livros').delete().eq("id", idLivro);

      resposta.status = HttpStatus.accepted;
      resposta.mensagem = "Livro e imagem removidos.";

      return resposta;
    } catch (err) {
      resposta.status = HttpStatus.internalServerError;
      resposta.mensagem = "Erro no servidor: $err";
      return resposta;
    }
  }
}
