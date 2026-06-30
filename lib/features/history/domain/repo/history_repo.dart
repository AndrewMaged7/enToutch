import 'package:en_touch/features/history/data/model/get_histort_model.dart';

abstract class HistoryRepo{
  Future<List<GetHistoryModel>?> getHistory();
}