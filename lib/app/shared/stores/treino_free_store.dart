import 'package:mobx/mobx.dart';
import 'package:workout365app/app/models/treino_completo_model.dart';
import 'package:workout365app/app/models/treino_free_model.dart';
import 'package:workout365app/app/services/treino_free_services.dart';

part 'treino_free_store.g.dart';

class TreinoFreeStore = _TreinoFreeStore with _$TreinoFreeStore;

abstract class _TreinoFreeStore with Store {
  final TreinoFreeServices _services = TreinoFreeServices();

  _TreinoFreeStore();

  @observable
  ObservableFuture<List<TreinoFreeModel>> treinoFuture;

  @observable
  ObservableFuture<List<TreinoCompletoModel>> treinoFutureSelecionado;

  @action
  Future<void> initPage(int treinoId) async {
    treinoFutureSelecionado = buscarTreinoCompleto(treinoId).asObservable();
  }

  @action
  void listarTreinosFree() {
    treinoFuture = ObservableFuture(_services.listarTreinosFree());
  }

  Future<List<TreinoCompletoModel>> buscarTreinoCompleto(int treinoId) async {
    return await _services.buscarTreinoCompleto(treinoId);
  }
}
