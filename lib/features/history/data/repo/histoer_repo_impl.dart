import 'package:en_touch/features/history/data/model/get_histort_model.dart';
import 'package:en_touch/features/history/data/source/history_sorce.dart';
import 'package:en_touch/features/history/data/source/history_source_inpl.dart'
    show HistorySourceImpl;
import 'package:en_touch/features/history/domain/repo/history_repo.dart';

class HistoryRepoImpl extends HistoryRepo {
  HistorySource historySource = HistorySourceImpl();
  @override
  Future<List<GetHistoryModel>?> getHistory() async {
    var response = await historySource.getHistory();
    try {
      if (response!.statusCode! >= 200 && response.statusCode! < 300) {
        List data = response.data;
        return data.map((e) => GetHistoryModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load history');
      }
    } catch (e) {
      return null;
    }
  }
}
