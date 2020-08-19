import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/repository/treino_free_repository.dart';

class TreinoFreeServices {
  final TreinoFreeRepository _repository = TreinoFreeRepository();

  TreinoFreeServices();

  Future<List<TreinoFreeModel>> listarTreinosFree() {
    return _repository.listarTreinosFree();
  }
}
