import 'package:workout365app/app/models/avaliacao_model.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/models/usuario_treino_model.dart';
import 'package:workout365app/app/repository/treino_free_repository.dart';

class TreinoFreeServices {
  final TreinoFreeRepository _repository = TreinoFreeRepository();

  TreinoFreeServices();

  Future<List<TreinoFreeModel>> listarTreinosFree() {
    return _repository.listarTreinosFree();
  }

  Future<List<TreinoCompletoModel>> buscarTreinoCompleto(int treinoId) async {
    return await _repository.buscarTreinoCompleto(treinoId);
  }

  Future<UsuarioTreinoModel> enviarInicioTreino(
      TreinoCompletoModel treinoCompleto, String inicioDoTreino) async {
    return await _repository.enviarInicioTreino(treinoCompleto, inicioDoTreino);
  }

  Future<UsuarioTreinoModel> enviarFimDoTreino(
      UsuarioTreinoModel usuarioTreinoModel,
      String datafimTreino,
      String tempoTotalTreino) async {
    return await _repository.enviarFimDoTreino(
        usuarioTreinoModel, datafimTreino, tempoTotalTreino);
  }

  Future<AvaliacaoModel> enviarAvaliacao(int userTreinoId, int nota) async {
    return await _repository.enviarAvaliacao(userTreinoId, nota);
  }
}
