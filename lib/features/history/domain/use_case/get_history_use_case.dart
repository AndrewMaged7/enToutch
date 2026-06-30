import 'package:en_touch/features/history/data/model/get_histort_model.dart';
import 'package:en_touch/features/history/data/repo/histoer_repo_impl.dart';
import 'package:en_touch/features/history/domain/repo/history_repo.dart';

class GetHistoryUseCase {
  HistoryRepo historyRepo = HistoryRepoImpl();

  Future<List<GetHistoryModel>?> call() async {
    return await historyRepo.getHistory();
  }
}
